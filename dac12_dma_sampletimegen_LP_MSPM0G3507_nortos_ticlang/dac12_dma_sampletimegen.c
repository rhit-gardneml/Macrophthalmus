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
#include "ti/devices/msp/peripherals/hw_dac12.h"
#include "ti/driverlib/dl_dac12.h"
#include "ti/driverlib/dl_uart_main.h"
#include "ti/driverlib/dl_uart_extend.h"
#include "ti_msp_dl_config.h"
#include <sys/_stdint.h>

volatile bool gCheckDAC;
volatile uint16_t gDACResult;
volatile bool gCheckCTS;
#define BUFFERA 0
#define BUFFERB 1

/* Repetitive sine wave */
uint32_t theBuffers[64] = 
{   200,	401,	601,	799,	995,	1189,	1379,	1567,	1751,	1930,
	2105,	2275,	2439,	2598,	2750,	2896,	3034,	3166,	3289,	3405,
    3513,	3612,	3702,	3784,	3856,	3919,	3973,	4017,	4051,	4076,
    4091,	4096,	4091,	4076,	4051,	4017,	3973,	3919,	3856,	3784,
    3702,	3612,	3513,	3405,	3289,	3166,	3034,	2896,	2750,	2598,
    2439,	2275,	2105,	1930,	1751,	1567,	1379,	1189,	995,	799,
    601,	401,	200,	0};

uint16_t theBuffer[128] =
{
    0,  	100,	200,	301,	401,	501,	601,	700,	799,	897,
    995,	1092,	1189,	1284,	1379,	1474,	1567,	1659,	1751,	1841,
    1930,	2018,	2105,	2191,	2275,	2358,	2439,	2519,	2598,	2675,
    2750,	2824,	2896,	2966,	3034,	3101,	3166,	3229,	3289,	3348,
    3405,	3460,	3513,	3563,	3612,	3658,	3702,	3744,	3784,	3821,
    3856,	3889,	3919,	3947,	3973,	3996,	4017,	4035,	4051,	4065,
    4076,	4084,	4091,	4094,	4096,	4094,	4091,	4084,	4076,	4065,
    4051,	4035,	4017,	3996,	3973,	3947,	3919,	3889,	3856,	3821,
    3784,	3744,	3702,	3658,	3612,	3563,	3513,	3460,	3405,	3348,
    3289,	3229,	3166,	3101,	3034,	2966,	2896,	2824,	2750,	2675,
    2598,	2519,	2439,	2358,	2275,	2191,	2105,	2018,	1930,	1841,
    1751,	1659,	1567,	1474,	1379,	1284,	1189,	1092,	995,	897,
    799,	700,	601,	501,	401,	301,	200,	100    
};

/* Repetitive sine wave */
const uint16_t gOutputSignalSine64[] = {2048, 2248, 2447, 2642, 2831, 3013,
    3185, 3347, 3496, 3631, 3750, 3854, 3940, 4007, 4056, 4086, 4095, 4086,
    4056, 4007, 3940, 3854, 3750, 3631, 3496, 3347, 3185, 3013, 2831, 2642,
    2447, 2248, 2048, 1847, 1648, 1453, 1264, 1082, 910, 748, 599, 464, 345,
    241, 155, 88, 39, 9, 0, 9, 39, 88, 155, 241, 345, 464, 599, 748, 910, 1082,
    1264, 1453, 1648, 1847};

void fillBuffer(uint8_t nBufferID) {
    // ASSERT_CTS for buffer
    //DL_UART_setClearToSend();
    
    // Check for Data Available
    for(uint8_t nIndex=0;nIndex<64;nIndex++) {
        uint8_t highbyte = DL_UART_Main_receiveData(UART_0_INST);
        uint8_t lowbyte = DL_UART_Main_receiveData(UART_0_INST);
        uint16_t sampleValue = highbyte<<8 | lowbyte;
        // store the sampleValue off to the buffer
        theBuffers[nIndex] = sampleValue;
    }  
    // CLEAR CTS for buffer
}

void setupDMARegs(uint16_t DMAChannel, uint32_t pDACAddr, uint32_t pBufferAddr, uint32_t u32BufferSize) {
    DL_DMA_setSrcAddr(DMA, DMAChannel, pBufferAddr);
    DL_DMA_setDestAddr(DMA, DMAChannel, pDACAddr);
    DL_DMA_setTransferSize(DMA, DMAChannel, u32BufferSize);
    DL_DMA_enableChannel(DMA, DMAChannel);
}

int main(void)
{
    // DAC12_Regs  DACRegs;
    // DL_DAC12_Config DACConfig;

    SYSCFG_DL_init();
    // DL_DAC12_init(&DACRegs, &DACConfig);

    //NVIC_EnableIRQ(DAC0_INT_IRQn);
    gCheckDAC = false;
    gCheckCTS = false;
    uint8_t gBufferAB_TX = 0;  // 0 is A, 1 is B

    // Preload two buffers from the UART
    //fillBuffer(BUFFERA);
    //fillBuffer(BUFFERB);

    uint64_t currentBuffer = BUFFERA;

    // set buffer A to DMA 0
    setupDMARegs(DMA_CH0_CHAN_ID, (uint32_t)&(DAC0->DATA0), (uint32_t)&gOutputSignalSine64, 64);
    NVIC_EnableIRQ(DAC0_INT_IRQn);

    // enable auto-increment on DMA

    // Start Transmission of buffer
    DL_DAC12_enable(DAC0);

    while (1) {
        // Wait for buffer to complete transmission
        while (false == gCheckDAC) {
            __WFE();
        }
        // should already be transmitting next buffer

        //fillBuffer(currentBuffer);
        // switch buffers
        currentBuffer = (currentBuffer == BUFFERA) ? BUFFERB : BUFFERA;
        gCheckDAC = false;
        DL_DAC12_enable(DAC0);
    }

    DL_SYSCTL_enableSleepOnExit();
    while (1) {
        __WFI();
    }
}

void DAC12_IRQHandler() {
    switch (DL_DAC12_getPendingInterrupt(DAC0)) {
        case DL_DAC12_IIDX_DMA_DONE:
            gCheckDAC = true;
            DAC0->CPU_INT.IMASK &= ~0x00004000;
            break;
        default:
            break;
    }
}
