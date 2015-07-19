%code to play the playback tone contaning 80Hz tone added to it 

clc;
close all;
clear all;

fs = 48000;
load('Tone80.mat');%tone is sampled at 48000Hz and saved in a mat file
cycles = 10; %setting the number of cycles here changes the length of the tone
%each cycle is 1 sec long

t = t80(1,1:(fs*cycles));

sound(t,fs);