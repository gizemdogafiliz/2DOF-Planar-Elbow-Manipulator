clc
clear all;

Vin = 12;
D = 0.7;
Ts = 50e-6;
Rout = 100;
Rl = 1e-3;

current_ripple_L = 0.05;
voltage_ripple_C = 0.2;

I = (Vin * D)/(Rout*(1-D)^2 + Rl);

L = (Vin*D - I*Rl) * D*Ts / (current_ripple_L)
C = (((Vin*D)/(Rout * (1-D)^2 +Rl)) + ((I*Rl - Vin*D)/((1-D)*Rout))) * (D*Ts/voltage_ripple_C)

