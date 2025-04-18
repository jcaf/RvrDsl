/* 
 * File:   main.h
 * Author: jcaf
 *
 * Created on April 13, 2025, 12:50 PM
 */

#ifndef MAIN_H
#define	MAIN_H

#define SYSTICK_MS 1	//1ms

struct _mainflag
{
		unsigned sysTickMs :1;
		unsigned lock_keyplus:1;
        unsigned lock_keyminus:1;
        unsigned clearSignPlusMinus:1;
        unsigned __a:4;
};


#define PORTWxLCDAN_BK PORTB
#define PORTRxLCDAN_BK PINB
#define CONFIGIOxLCDAN_BK DDRB
#define PINxLCDAN_BK 0

#define PORTWxTECLA_MINUS PORTC
#define PORTRxTECLA_MINUS PINC
#define CONFIGIOxTECLA_MINUS DDRC
#define PINxTECLA_MINUS 2

#define PORTWxTECLA_PLUS PORTC
#define PORTRxTECLA_PLUS PINC
#define CONFIGIOxTECLA_PLUS DDRC
#define PINxTECLA_PLUS 3


#ifdef	__cplusplus
extern "C" {
#endif




#ifdef	__cplusplus
}
#endif

#endif	/* MAIN_H */

