% Daniel Zuerbig
% ECE 413 Music and Engineering
% Homework Assignment 4, Effects

% This is the main run file

close all; clc; clear all;

[song, fs] = audioread('song2.wav');
% Sirius, Alan Parsons Project
song2 = audioread('song.wav');
% Never Going Back Again, Fleetwood Mac

t = 0:(1/fs):4;
t = [t';t'];
test_n = randn(4*fs, 2);
test_n = filter(1, [1 -.9], test_n);
% I made this pink noise for testing the flanger. You can use this if you
% want

ring = ring_mod(song, 400, .6, fs);
% sound in, mod freq, depth, fs

tremolo_pan = trem(song, 'triangle', 2, 250, .6, fs);
tremolo = trem(song, 'sin', 20, 0, .6, fs);
% sound in, wave type, LFO freq, lag, depth, fs

distortion = distort(song, 4, .2);
% sound in, gain, tone

slapback = tap_delay(song, .8, .05, .9, fs);
echo = tap_delay(song, .4, .3, .5, fs);
tempo_delay = tap_delay(song2, .9, .5, .1, fs);
% sound in, depth, delay, feedback gain, fs

[comp, gains] = compress(song, .3, .8, 100, fs);
% sound in, thresh, slope, attack in microseconds, sampling rate 

flang = flanger(song, 1, .001, .0002, .6, fs);
chorus = flanger(song, .6, .1, .01, .3, fs);
% sound in, depth, min delay, max delay, LFO, fs

%%

disp('Now playing the ring mod effect')
play(ring, fs)

disp('Now playing a panning tremolo effect')
play(tremolo_pan, fs)

disp('Now playing a tremolo effect')
play(tremolo, fs)

disp('Now playing a distortion effect')
play(distortion, fs)

disp('Now playing a fun slapback effect')
play(slapback, fs)

disp('Now playing a large echo effect')
play(echo, fs)

disp('Now playing another echo effect')
play(tempo_delay, fs)

disp('Now playing a compressed song')
play(comp, fs)

disp('Now playing a flanger effect')
play(flang, fs)

disp('Now playing a chorus effect')
play(chorus, fs)


figure
stem(gains)
title('gain for each sample of compressor')
xlabel('sample')
ylabel('gain')


