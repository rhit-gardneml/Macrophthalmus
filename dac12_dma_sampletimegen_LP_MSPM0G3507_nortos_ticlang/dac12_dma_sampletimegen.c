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
const uint16_t gOutputSignalSine20k[] = {4079,4031,3951,3842,3704,3540,3353,3145,2919,2680,
    2431,2176,1919,1664,1415,1176,951,742,555,391,253,144,64,16,0,16,64,144,253,391,555,742,950,
    1175,1415,1664,1919,2176,2431,2680,2919,3144,3352,3540,3704,3842,3951,4031,4079,4095,4079,
    4031,3951,3842,3704,3540,3353,3145,2919,2680,2431,2176,1919,1664,1415,1176,951,742,555,
    391,253,144,64,16,0,16,64,144,253,391,555,742,950,1175,1415,1664,1919,2176,2431,2680,
    2919,3144,3352,3540,3704,3842,3951,4031,4079,4095,16,64,144,253,391,555,742,950,1176,
    1415,1664,1919,2176,2431,2680,2919,3144,3353,3540,3704,3842,3951,4031,4079,4095,4079,
    4031,3951,3842,3704,3540,3353,3145,2920,2680,2431,2176,1919,1664,1415,1176,951,743,
    555,391,253,144,64,16,0,4079,4031,3951,3842,3704,3540,3353,3145,2919,2680,2431,2176,
    1919,1664,1415,1176,951,742,555,391,253,144,64,16,0,16,64,144,253,391,555,742,950,
    1175,1415,1664,1919,2176,2431,2680,2919,3144,3352,3540,3704,3842,3951,4031,4079,
    4095,16,64,144,253,391,555,742,950,1176,1415,1664,1919,2176,2431,2680,2919,3144,
    3353,3540,3704,3842,3951,4031,4079,4095,4079,4031,3951,3842,3704,3540,3353,3145,
    2920,2680,2431,2176,1919,1664,1415,1176,951,743,555,391,253,144,64,16,0,16,64,144,
    253,391,555,742,950,1176,1415,1664,1919,2176,2431,2680,2919,3144,3353,3540,3704,
    3842,3951,4031,4079,4095,4079,4031,3951,3842,3704,3540,3353,3145,2920,2680,2431,
    2176,1919,1664,1415,1176,951,743,555,391,253,144,64,16,0};

const uint16_t gOutputSignalSine100k[] = {4095,3704,2681,1415,391,0,391,1414,2680,3704,4095,
    4095,3704,2681,1415,391,0,391,1414,2680,3704,4095,0,391,1414,2680,3704,4095,3704,2681,1415,
    391,0,4095,3704,2681,1415,391,0,391,1414,2680,3704,4095,0,391,1414,2680,3704,4095,3704,2681,
    1415,391,0,0,391,1414,2680,3704,4095,3704,2681,1415,391,0};

const uint16_t gOutputSignalSine80k[] = {4095,3481,2662,1638,819,205,0,410,1229,2252,3071,3890,
    4095,4095,3481,2662,1638,819,205,0,410,1229,2252,3071,3890,4095,0,614,1433,2457,3276,3890,4095,
    3686,2867,1843,1024,205,0,4095,3481,2662,1638,819,205,0,410,1229,2252,3071,3890,4095,0,614,1433,
    2457,3276,3890,4095,3686,2867,1843,1024,205,0,0,614,1433,2457,3276,3890,4095,3686,2867,1843,1024,
    205,0};

const uint16_t gOutputSignalSine8k[]   = {4095,3842,3145,2176,1176,391,16,144,742,1664,2680,3540,4031,
4031,3540,2680,1664,742,144,16,391,1176,2176,3145,3842,4095,3842,3145,2176,1176,391,16,144,742,1664,
2680,3540,4031,4031,3540,2680,1664,742,144,16,391,1176,2176,3145,3842,4095};

/*
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
}*/

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
    setupDMARegs(DMA_CH0_CHAN_ID, (uint32_t)&(DAC0->DATA0), (uint32_t)&gOutputSignalSine8k, sizeof(gOutputSignalSine8k)/sizeof(uint16_t));
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
