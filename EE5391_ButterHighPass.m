clc;
close all;
clear all;

%[B,A] = BUTTER(N,Wn,'stop') is a bandstop filter if Wn = [W1 W2].
%butter()

fs = 48000;
w1 = 1000/(fs/2);
w2 = 10000/(fs/2);
[b a] = butter(10,0.4,'high');


%a = [ 1.0000   -1.9924    3.0195   -2.8185    2.0387   -1.0545    0.4144   -0.1157    0.0225   -0.0027    0.0001];
%b = [0.0122   -0.1219    0.5484   -1.4624    2.5592   -3.0710    2.5592   -1.4624    0.5484   -0.1219    0.0122];



h = fvtool(b,a);
load('Basstone.mat');
figure(2);
subplot(3,1,1);
plot(sig);
S = abs(fft(sig));
n = 0:220;
subplot(3,1,2);
stem(S);
subplot(3,1,3)
stem(n,S(1:221));

y = filter(b,a,sig);
figure(3);
subplot(3,1,1);
plot(y);
title('Original Signal, Filtered');
xlabel('time');
ylabel('Amp');
Y = abs(fft(y));
%n = 0:220;
subplot(3,1,2);
title('Frequency Analysis');
xlabel('freq');
ylabel('Mag');
stem(Y);
subplot(3,1,3)
stem(n,Y(1:221));
title('First 220 frequencies');
xlabel('freq');
ylabel('Mag');