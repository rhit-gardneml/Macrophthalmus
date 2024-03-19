/*
 * Copyright (c) 2021, Texas Instruments Incorporated
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * *  Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * *  Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * *  Neither the name of Texas Instruments Incorporated nor the names of
 *    its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "ti/devices/msp/m0p/mspm0g350x.h"
#include "ti/driverlib/dl_dma.h"
#include "ti/driverlib/dl_uart_main.h"
#include "ti_msp_dl_config.h"
#include <stdio.h>

#define ADC_SAMPLE_SIZE (128)

uint16_t gADCSamplesPing[ADC_SAMPLE_SIZE];
uint16_t gADCSamplesPong[ADC_SAMPLE_SIZE];

volatile bool gCheckADC;
volatile bool gPing;

#include <math.h>
#define M_PI       3.14159265358979323846   // pi

void initalizeBuffer( uint16_t* pBuffer, int nNumElements )
{
    double dSampleRate = (32000000 / 48) / 128; // (32MHz / 48) / 128
    double dFrequency = 1000;   // 1kHz
    double pi2 = 2 * M_PI;
    double dAmplitude;
    double dStep;
    double dBitsPerSample = 12;
    double dBFS = -0.01;    // dB full-scale

    dAmplitude = pow(10.0, (dBFS/20.0)) * pow(2.0, (dBitsPerSample-1));
    dStep = (pi2 / dSampleRate) * dFrequency;

    for( int nSampleNum=0; nSampleNum<nNumElements; nSampleNum++ )
    {
        double dValue = sin( dStep * (double)nSampleNum );
        uint16_t nSampleValue = (uint16_t)((dAmplitude * dValue) + (pow(2, dBitsPerSample)/2));   // 2048 is 1/2 of 4096 (2^12)
        
        pBuffer[nSampleNum] = nSampleValue;
        //fprintf( stdout, "%d,", pBuffer[nSampleNum] );
    }
}

int main(void) {
  uint16_t i16PacketCount = 0;

  gPing = true;

  SYSCFG_DL_init();

  //initalizeBuffer( gADCSamplesPing, ADC_SAMPLE_SIZE );
  //initalizeBuffer( gADCSamplesPong, ADC_SAMPLE_SIZE );

   // Configure DMA source, destination and size
  DL_DMA_setSrcAddr(DMA, DMA_CH0_CHAN_ID, (uint32_t)DL_ADC12_getFIFOAddress(ADC12_0_INST));
  DL_DMA_setDestAddr(DMA, DMA_CH0_CHAN_ID, (uint32_t)&gADCSamplesPing[0]);
  DL_DMA_setTransferSize(DMA, DMA_CH0_CHAN_ID, ADC_SAMPLE_SIZE);
  DL_DMA_enableChannel(DMA, DMA_CH0_CHAN_ID);

  // Setup interrupts on device
  NVIC_EnableIRQ(ADC12_0_INST_INT_IRQN);

  DL_GPIO_clearPins(GPIO_LEDS_PIN_1_PIN, GPIO_LEDS_PIN_0_PIN);

  gCheckADC = false;

  // The ADC is configured for Repeat Single Conversion,
  // so the ADC will continue until DL_ADC12_disableConversions() is called
  DL_ADC12_startConversion(ADC12_0_INST);

  //printf("PingPong\n");

  while (1) {

    while (false == gCheckADC) {
      __WFE();
    }
    gCheckADC = false;

    // Packet Header
    {
        uint8_t highbyte = (uint8_t)(i16PacketCount >> 8);
        uint8_t lowbyte  = (uint8_t)i16PacketCount;
        DL_UART_transmitDataBlocking(UART_0_INST, 0xA5);
        DL_UART_transmitDataBlocking(UART_0_INST, 0xFF);
        DL_UART_transmitDataBlocking(UART_0_INST, highbyte);
        DL_UART_transmitDataBlocking(UART_0_INST, lowbyte);
        i16PacketCount++;
    }
    /* Switch to send ADC Results to Pong Buffer */
    if (gPing) {
        DL_GPIO_setPins(GPIO_LEDS_PIN_0_PORT, GPIO_LEDS_PIN_0_PIN); //green
        for(int i=0; i < ADC_SAMPLE_SIZE; i++) {
            uint8_t lowbyte  = (uint8_t)gADCSamplesPing[i];
            uint8_t highbyte = (uint8_t)(gADCSamplesPing[i] >> 8);
            DL_UART_transmitDataBlocking(UART_0_INST, highbyte);
            DL_UART_transmitDataBlocking(UART_0_INST, lowbyte);
        }
        DL_GPIO_clearPins(GPIO_LEDS_PIN_0_PORT, GPIO_LEDS_PIN_0_PIN);
        //gPing = false;
    }
    else {
        DL_GPIO_setPins(GPIO_LEDS_PIN_1_PORT, GPIO_LEDS_PIN_1_PIN); //blue
        for(int i=0; i < ADC_SAMPLE_SIZE; i++) {
            uint8_t lowbyte  = (uint8_t)gADCSamplesPong[i];
            uint8_t highbyte = (uint8_t)(gADCSamplesPong[i] >> 8);
            DL_UART_transmitDataBlocking(UART_0_INST, highbyte);
            DL_UART_transmitDataBlocking(UART_0_INST, lowbyte);
        }
        DL_GPIO_clearPins(GPIO_LEDS_PIN_1_PORT, GPIO_LEDS_PIN_1_PIN);
        //gPing = true;
    }
    //printf("Packet %d\n", i16PacketCount);
  }
}
        
void ADC12_0_INST_IRQHandler(void) {
  switch (DL_ADC12_getPendingInterrupt(ADC12_0_INST)) {
  case DL_ADC12_IIDX_DMA_DONE:
    /* Switch to send ADC Results to Pong Buffer */
    if (gPing) {
        DL_GPIO_setPins(GPIO_LEDS_PIN_3_PORT, GPIO_LEDS_PIN_3_PIN);
        DL_DMA_setDestAddr(DMA, DMA_CH0_CHAN_ID, (uint32_t)&gADCSamplesPong[0]);
        DL_DMA_setTransferSize(DMA, DMA_CH0_CHAN_ID, ADC_SAMPLE_SIZE);
        DL_DMA_enableChannel(DMA, DMA_CH0_CHAN_ID);
        DL_ADC12_enableDMA(ADC12_0_INST);
        gPing = false;
    }
    /* Switch to send ADC Results to Ping Buffer */
    else {
        DL_GPIO_clearPins(GPIO_LEDS_PIN_3_PORT, GPIO_LEDS_PIN_3_PIN);
        DL_DMA_setDestAddr(DMA, DMA_CH0_CHAN_ID, (uint32_t)&gADCSamplesPing[0]);
        DL_DMA_setTransferSize(DMA, DMA_CH0_CHAN_ID, ADC_SAMPLE_SIZE);
        DL_DMA_enableChannel(DMA, DMA_CH0_CHAN_ID);
        DL_ADC12_enableDMA(ADC12_0_INST);
        gPing = true;
    }
    gCheckADC = true;
    break;
  default:
    break;
  }
}
