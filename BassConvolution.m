clc;
close all;
clear all;

%arrays a0,a1,a2,b1,b2 contains the numerator and denominator coefficients
%these coefficients are scaled by 2^31
%such a long number has been chosen, to scale, because these filters were
%designed using the fdatool and the coeeficients hence, obtained were
%double precision floating points
%these coefficients are also rounded to 7 pts after the decimal
%please find all the precise values in the excel sheet attached

a0 = [0.9996671
0.9996671
0.9996671
0.9996671
0.9996671
0.9996671
0.9991681
0.9996671
0.9996671
0.9996671
0.9996671

];

a1 = [-1.9993273
-1.9993187
-1.9993067
-1.9992913
-1.9992725
-1.9992502
-1.9982266
-1.9991954
-1.9991629
-1.9991269
-1.9990875



]

a2 = a0;
b1 = a1;

b2 = [0.9993341
0.9993341
0.9993341
0.9993341
0.9993341
0.9993341
0.9983362
0.9993341
0.9993341
0.9993341
0.9993341


];

%the mat file BassTone contains 48000 samples of the signal that is an
%addition of all the sine waves sampled at 48000 Hz and are in the range
%[20-120]  Hz
load('Basstone');
tone = sig;

%figure 1 contains the frequency analysis of the signal 'sig'
n = 0:1:219;
figure(1)
subplot(3,1,1)
plot(sig);
subplot(3,1,2)
Xs = abs(fft(sig));
plot(Xs(1:(length(Xs)/2)));
subplot(3,1,3)
stem(n,Xs(1:220));

%implementing convolution here as expected to be implemented on the
%DSK5509a board
%the following code will filter each frequency and then perform its
%frequency analysis and plot its graph for verification purposes

x(1) = 0;
x(2) = 0;
y(3) = 0;
y(2) = 0;
y(1) = 0;
for j = 1:11
for i = 1:48000
    x(3) = tone(i);
    y(3) = (a0(j,1)*x(3)) + (a1(j,1)*x(2)) + (a2(j,1)*x(1)) - (b1(j,1)*y(2)) - (b2(j,1)*y(1)); 
    fsig(j,i) = y(3);
    y(1) = y(2);
    y(2) = y(3);
    x(1) = x(2);
    x(2) = x(3);
end
x(1) = 0;
x(2) = 0;
y(3) = 0;
y(2) = 0;
y(1) = 0;
end

for j = 1:11
figure(j+1)
subplot(3,1,1)
plot(fsig(j,:));
title('Filtered Signal');
xlabel('time');
ylabel('Amp');
subplot(3,1,2)
fXs = abs(fft(fsig(j,:)));
plot(fXs(1:(length(fXs)/2)));
title('Frequency Analysis');
xlabel('freq');
ylabel('Mag');
subplot(3,1,3)
stem(n,fXs(1:220));
title(['fnotch :',int2str(j*10 + 10),'Hz']);
xlabel('freq');
ylabel('Mag');
end;