#ifndef GET_POWER_H
#define GET_POWER_H

#include <PZEM004Tv30.h>

// Khai báo đối tượng PZEM
extern PZEM004Tv30 pzem;

// Khai báo các hàm
float getVol();
float getAmp();
float getPF();
float getWat();
float getFre();
float getEnergy();
void showData(float volt, float ampe, float PF, float wat, float Frequency, float Energy);
bool resetEnergy();

#endif // GET_POWER_H
