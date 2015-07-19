clc;
close all;
clear all;

fs = 48000;
load('Tone80.mat'); %Tone80 mat file contains the audio tone added with an 80 Hz sine wave
%this file is approx 3 mins long and is sampled at 48000 Hz 
%each cycle is 1 sec long, and contains 48000 samples  
cycles = 10; %no of cycles can be changed to the desirable length of tone to be played back


%implementing notch filter for fnotch = 80Hz
%2nd order filter, designed in fdatool
%numerator and denominator coefficients scaled by 2^31 and rounded
a0 = 2145697141;
a1 = -4291158982;
a2 = 2145697141;
b1 = -4291158982;
b2 = 2143910633;

div = power(2,31);

a0 = double(a0/div);
a1 = double(a1/div);
a2 = double(a2/div);
b1 = double(b1/div);
b2 = double(b2/div);

%initializing the sample values
x(1) = 0;
x(2) = 0;
y(3) = 0;
y(2) = 0;
y(1) = 0;

%implementing the IIR filter equation  in time domain
for i = 1:(fs*cycles)
   x(3) = t80(1,i);
   y(3) = ((a0)*x(3)) + (a1*x(2)) + (a2*x(1)) - (b1*y(2)) - (b2*y(1)); 
    fsig(1,i) = y(3);
    y(1) = y(2);
    y(2) = y(3);
    x(1) = x(2);
   x(2) = x(3);
end

%playing the filtered tone
sound(fsig ,48000);