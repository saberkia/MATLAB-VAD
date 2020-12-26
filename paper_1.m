clc
clear
close all

Tw    = 25;            % analysis frame duration (ms)
Ts    = 12.5;          % analysis frame shift (ms)
alpha = 0.97;          % preemphasis coefficient
R     = [ 300 8000 ];  % frequency range to consider
M     = 20;            % number of filterbank channels
C     = 33;            % number of cepstral coefficients
L     = 22;            % cepstral sine lifter parameter
point = 600000;
sample_rate = 5;       % Downsample Rate

[data,Fs] = audioread('Voice 003.m4a');
signal    = data(point:point + 80000)';
% Downsampling
signal    = signal(1:sample_rate:end);
Fs        = Fs/sample_rate;
plot(signal)
grid on

% hamming window
hamming = @(N)(0.54-0.46*cos(2*pi*(0:N-1).'/(N-1)));

% Feature extraction (feature vectors as columns)
[MFCCs, MFSCs, frames] = ...
    mfcc_m( signal, Fs, Tw, Ts, alpha, hamming, R, M, C, L );

% Plot cepstrum over time
figure('Position', [30 100 800 200], 'PaperPositionMode', 'auto', ...
    'color', 'w', 'PaperOrientation', 'landscape', 'Visible', 'on' );

imagesc(1:size(MFSCs,2), 0:C-1, MFSCs);
axis('xy')
xlabel('Frame index')
ylabel('Cepstrum index')
title('Mel frequency spectrum')




