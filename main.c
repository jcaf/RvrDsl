/*MPLAX IDE v6.25
 * AVR GNU TOOL CHAIN 
 *  
 * File:   main.c
 * Author: jcaf
 *
 * Created on April 13, 2025, 12:41 PM
 * 
 * ATmega328P @16MHz (Resonator_SMD_Murata_CSTxExxV-3Pin)
 * 
 1)  http://www.engbedded.com/fusecalc/
         lock bits:
         http://eleccelerator.com/fusecalc/fusecalc.php?chip=atmega328p

 2) verificar que responda el atmega (ONLY A RESET)
 [jcaf@jcafpc ~]$ avrdude -c usbasp -B5 -v -p m328P

 3) programar fuse (sin preservar EEPROM)

 [jcaf@jcafpc ~]$ avrdude -c usbasp -B5 -p m328P -U lfuse:w:0xff:m -U hfuse:w:0xd9:m -U efuse:w:0xff:m

 4) GRABAR EL CODIGO FUENTE CON EL COMANDO ACOSTUMBRADO
 [root@JCAFPC Release]# avrdude -c usbasp -B5 -p m328P -U flash:w:ATmega328Pmplabx.X.production.hex

 NUEVO
 [root@JCAFPC Release]# avrdude -c usbasp -B0.3 -p m328P -V -U flash:w:ATmega328Pmplabx.X.production.hex (MAS RAPIDO!)
 Tambien puede ser sin -BX.. cuando ya esta bien configurado los fuses:
 [root@JCAFPC Release]# avrdude -c usbasp -p m328P -U flash:w:ATmega328Pmplabx.X.production.hex

 5) GRABAR LA EEPROM
 [jcaf@jcafpc Release]$ avrdude -c usbasp -B4 -p m328P -V -U eeprom:w:ATmega328Pmplabx.X.production.eep

 6) programar fuse (PRESERVANDO EEPROM)

                avrdude -c usbasp -B5 -p m328P -U lfuse:w:0xff:m -U hfuse:w:0xd1:m -U efuse:w:0xff:m

 7) Verificar los fuses
 [jcaf@jcafpc Release]$ avrdude -c usbasp -B4 -p m328P -U lfuse:r:-:i -v

 +++++++++++++++++++++++
 proteger flash (modo 3): lectura y escritura
 avrdude -c usbasp -B10 -p m328P -U lock:w:0xFC:m
 */
#include <stdio.h>
#include <stdlib.h>
#include <avr/eeprom.h>
#include "system.h"
#include "types.h"
#include "lcdan/lcdan.h"
#include "lcdan/lcdan_aux.h"
#include "pinGetLevel/pinGetLevel.h"
#include "adc/adc.h"
#include "main.h"

uint16_t EEMEM PWM = 0;
uint16_t EEMEM ICR1_latest = 0;

#define VOUT_MAX 10.0f         //Volts

#define PWM_BIT_RESOL_MAX 16
#define PWM_BIT_RESOL_MIN 10
#define POTENCIOMETRO_CALIBRACION_STEP_ADC_BIT_RESOL 8 //8bits suficiente para seleccionar entre 10 - 16 bits de PWM resol.
#define CALIBSTEP_ADC_VALUE_MAX  ((1<<POTENCIOMETRO_CALIBRACION_STEP_ADC_BIT_RESOL)-1)
#define CALIBSTEP_ADC_VALUE_MIN  0
        
//y = mx + b
#define EQUATION_m ( (float)(PWM_BIT_RESOL_MAX-PWM_BIT_RESOL_MIN)) / ( CALIBSTEP_ADC_VALUE_MAX - CALIBSTEP_ADC_VALUE_MIN) 
#define EQUATION_solve_b(y,m,x) (y-(m*x))
#define EQUATION_b EQUATION_solve_b(PWM_BIT_RESOL_MIN,EQUATION_m,CALIBSTEP_ADC_VALUE_MIN)

uint8_t PWM_BIT_RESOL_SELECTED;
uint8_t PWM_BIT_RESOL_SELECTED_latest;
uint8_t EEMEM PWM_BIT_RESOL_SELECTED_EEMEM_latest = 0;

float voltage_step;

#define ADC_BIT_RESOL 8//12    //Bits
//#define R2POWER16 ((uint32_t)0x00001<<ADC_BIT_RESOL)
//#define VSTEP 1.5259e-04//(VOUT_MAX/( ((uint16_t)1)<<16 ))  //2^ADC_BIT_RESOL
//#define VSTEP (VOUT_MAX/((float)R2POWER16) )  //2^ADC_BIT_RESOL
#define VSTEP (VOUT_MAX/((uint32_t)0x00001<<ADC_BIT_RESOL))
#define VOUT_OFFSET 11.285E-3 //Voltaje en reposo

float vout; 

volatile struct _isr_flag
{
    unsigned sysTickMs : 1;
    unsigned __a : 7;
} isr_flag = {0};


struct _mainflag mainflag;

void ADC_config2ReadPotSetVoltStep(void)
{
    ADC_setAutoTrigger_disabled();
    ADC_disable();
    //
    ADC_set_channel(ADC_CH_0);
    ADC_enable();
    ADC_set_prescaler(ADC_PRESCALER_128);
    ADC_set_reference(ADC_REF_AVCC);
    ADC_setAutoTrigger_enabled();
    ADC_setAutoTrigger_source(ADC_AUTOTRIGGER_SOURCE_FREE_RUNNING);
    ADC_set_adjust(ADC_ADJUST_LEFT);//solo uso el registro superior para 8bits
    ADC_setBit_startConversion_On();
}
/*
void ADC_config2MeasuringAnalogVoltage(void)
{
	//
	ADC_setAutoTrigger_disabled();
	ADC_disable();
	//
	ADC_set_channel(ADC_CH_1);
	ADC_enable();
	ADC_set_prescaler(ADC_PRESCALER_128);
	//ADC_set_reference(ADC_REF_INTERNAL_2_56V);
        ADC_set_reference(ADC_REF_AVCC);
	ADC_setAutoTrigger_enabled();
	ADC_setAutoTrigger_source(ADC_AUTOTRIGGER_SOURCE_FREE_RUNNING);
        ADC_set_adjust(ADC_ADJUST_RIGHT);
	ADC_setBit_startConversion_On();
}
*/

//            //+++++++++++++++++++++++
//            uint8_t adclow = ADCL;
//            uint16_t adc16 = (((uint16_t)ADCH)<<8) + adclow;
//            //
//            //float VoltOuput = ( (adc16*5.0f)/1024.0f )*2;
//            float VoltOuput = ( (adc16*10.07f)/1024.0f )*1;
//            VoltOuput *= 1.0050f;
//            dtostrf(VoltOuput,0,8, buff);
//            lcdan_set_cursor_in_row1(0);
//            lcdan_print_string(buff);
//            lcdan_print_string("   V");
//            //+++++++++++++++++++++++


void readPotSetVoltStep(void)
{  
    volatile uint8_t adclow = ADCL;//Captura la conversion actual, pero uso ADCH
    char buff[20];
    PWM_BIT_RESOL_SELECTED =  (uint8_t) ((ADCH*EQUATION_m) +  EQUATION_b);
    
    if (PWM_BIT_RESOL_SELECTED_latest != PWM_BIT_RESOL_SELECTED)
    {
        itoa(PWM_BIT_RESOL_SELECTED,buff ,10);
        lcdan_set_cursor_in_row0(0);
        lcdan_print_string(buff);
        lcdan_print_string("-BIT ");
        //
        voltage_step = (float)(VOUT_MAX/((uint32_t)0x00001<<PWM_BIT_RESOL_SELECTED));
        dtostrf(voltage_step,0,6, buff);
        lcdan_set_cursor_in_row0(7);
        lcdan_print_string(buff);
        lcdan_print_string("V");
        
        ConfigInputPin(DDRB, 1); //Disable output pin
        ICR1 = (uint16_t) (((uint32_t)0x00001<<PWM_BIT_RESOL_SELECTED) -1);
        if ((PWM_BIT_RESOL_SELECTED_latest > 0) && (OCR1A>0))
        {
            //si ha cambiado, entonces actualizar 
            //factor = 2^x/ OCR actual ;
            //OCR = 2^new/factor;//Valor actual de OCR
            float factor = (1<<PWM_BIT_RESOL_SELECTED_latest) / OCR1A;
            OCR1A = (int) ((1<<PWM_BIT_RESOL_SELECTED)/factor);
        }
        else
        {
            OCR1A = 0;
        }
        ConfigOutputPin(DDRB, 1); //Enable output pin
        //
        //Al ultimo recien actualiza el valor
        PWM_BIT_RESOL_SELECTED_latest != PWM_BIT_RESOL_SELECTED;
        
        eeprom_update_byte(&PWM_BIT_RESOL_SELECTED_EEMEM_latest);
    }
}    
     

/*
 void readPotSetVoltStep(void)
{  
    volatile uint8_t adclow = ADCL;//Captura la conversion actual, pero uso ADCH
    char buff[20];
    PWM_BIT_RESOL_SELECTED =  (uint8_t) ((ADCH*EQUATION_m) +  EQUATION_b);
    itoa(PWM_BIT_RESOL_SELECTED,buff ,10);
    
    lcdan_set_cursor_in_row0(0);
    lcdan_print_string(buff);
    lcdan_print_string("-BIT ");
    
    //
    voltage_step = (float)(VOUT_MAX/((uint32_t)0x00001<<PWM_BIT_RESOL_SELECTED));
    dtostrf(voltage_step,0,6, buff);
    lcdan_set_cursor_in_row0(7);
    lcdan_print_string(buff);
    lcdan_print_string("V");
     
    ICR1 = (uint16_t) (((uint32_t)0x00001<<PWM_BIT_RESOL_SELECTED) -1);
}
*/
//void print_voltage_step(void)
//{
//    char bb[10];
//    itoa(ADC_BIT_RESOL,bb ,10);
//    lcdan_print_string(bb);
//}
    
int8_t xxx()
{
    ICR1 = eeprom_read_word(&ICR1_latest);
    if (ICR1_latest!= ICR1)
    {
        if (ICR1_latest == 0)
        {
            //significa que se ha grabado por primera en la EEPROM
            //--> actualizar directamente
        }
        
        ICR1_latest = ICR1;
    }
}
void print_vout(float vout)
{
    char buff[20];
    dtostrf(vout,0,6, buff);
    lcdan_set_cursor_in_row1(0);
    lcdan_print_string("V=");
    lcdan_print_string(buff);
    lcdan_print_string("V  ");
}
int main(void)
{
    int counter0 = 0;
    int counter1 = 0;

    lcdan_init();
    ConfigOutputPin(CONFIGIOxLCDAN_BK, PINxLCDAN_BK);
    PinTo1(PORTWxLCDAN_BK, PINxLCDAN_BK);

    ADC_config2ReadPotSetVoltStep();
    //        
    //Config to 1ms
    TCNT0 = 0x00;
    TCCR0A = (1 << WGM01);
    TCCR0B = (0 << CS02) | (1 << CS01) | (1 << CS00); //CTC PRES = 64
    OCR0A = CTC_SET_OCR_BYTIME(1e-3, 64); // 
    //
    TIMSK0 |= (1 << OCIE0A);
    sei();

    //Activar pullups en las entradas
    pinGetLevel_init(); //with Changed=flag activated at initialization

    
    //fast PWM only in OC1A,OC1B normal pin
    TCCR1A = (1 << COM1A1) | (0 << COM1A0) | (0 << COM1B1) | (0 << COM1B0) | (1 << WGM11) | (0 << WGM10);
    TCCR1B = (1 << WGM13) | (1 << WGM12) | (1 << CS10);
    TCNT1 = 0;
    
    //ICR1 = 0xFFFF; //16Bits
    //ICR1 = (uint16_t) (((uint32_t)0x00001<<ADC_BIT_RESOL) -1);
    //OCR1A = 0;
    //OCR1A = 750;
    readPotSetVoltStep();//get ICR1 value

    OCR1A = eeprom_read_word(&PWM);

    ICR1 = eeprom_read_word(&ICR1_latest);
    PWM_BIT_RESOL_SELECTED_latest = eeprom_read_byte(&PWM_BIT_RESOL_SELECTED_EEMEM_latest);
   
    ConfigOutputPin(DDRB, 1); //OC1A
   
    while (1)
    {
        
        if (isr_flag.sysTickMs)
        {
            isr_flag.sysTickMs = 0;
            mainflag.sysTickMs = 1;
        }

        if (mainflag.sysTickMs)
        {
            if (++counter0 >= (20 / SYSTICK_MS)) //20ms
            {
                counter0 = 0;
                //
                readPotSetVoltStep();
                //
                pinGetLevel_job();
                //-
                if (pinGetLevel_hasChanged(PGLEVEL_LYOUT_KB_MINUS))
                {
                    pinGetLevel_clearChange(PGLEVEL_LYOUT_KB_MINUS);
                    //
                    if (pinGetLevel_level(PGLEVEL_LYOUT_KB_MINUS) == 0) //active in low
                    {
                        OCR1A--;
                        vout -= voltage_step;//
                        print_vout(vout + VOUT_OFFSET);
                        
                        lcdan_set_cursor_in_row1(15);
                        lcdan_print_string("-");

                        counter1 = 0;
                        mainflag.clearSignPlusMinus = 1;
                        
                        eeprom_update_word(&PWM, OCR1A);

                    }
                }
                //+
                if (pinGetLevel_hasChanged(PGLEVEL_LYOUT_KB_PLUS))
                {
                    pinGetLevel_clearChange(PGLEVEL_LYOUT_KB_PLUS);
                    //
                    if (pinGetLevel_level(PGLEVEL_LYOUT_KB_PLUS) == 0) //active in low
                    {
                        OCR1A++;
                        vout += voltage_step ;
                        print_vout(vout + VOUT_OFFSET);
                        
                        lcdan_set_cursor_in_row1(15);
                        lcdan_print_string("+");
                        
                        counter1 = 0;
                        mainflag.clearSignPlusMinus = 1;
                        
                        eeprom_update_word(&PWM, OCR1A);
                    }
                }
               // 
            }
        }
        //
        if (mainflag.clearSignPlusMinus)
        {
            if (mainflag.sysTickMs)
            {
                if (++counter1 >= (100/ SYSTICK_MS))
                {
                    counter1  = 0;
                    mainflag.clearSignPlusMinus = 0;

                    lcdan_set_cursor_in_row1(15);
                    lcdan_print_string(" ");
                }
            }
        }
        
        //
        mainflag.sysTickMs = 0;

    }

    return 0;
}

ISR(TIMER0_COMPA_vect)
{
    isr_flag.sysTickMs = 1;
}

