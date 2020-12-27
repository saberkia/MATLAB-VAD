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
WL    = 5000;          % Window Lenght
%%
sample_rate = 5;                                       % Downsample Rate
[data,Fs] = audioread('Voice 003.m4a');
data_dspl = data(1:sample_rate:end);                   % Downsampling
Fs        = Fs/sample_rate;
hamming   = @(N)(0.54-0.46*cos(2*pi*(0:N-1).'/(N-1))); % hamming window
%%
for index = 1:50
    point  = (index -1)*WL + 1;
    signal = data(point:point + WL)';
    % Feature extraction (feature vectors as columns)
    [MFCCs, MFSCs, frames] = ...
        mfcc_m( signal, Fs, Tw, Ts, alpha, hamming, R, M, C, L );
    x(index) = mean(MFSCs(:));
    figure(1)
    imagesc(1:size(MFSCs,2), 0:C-1, MFSCs);
    axis('xy')
    drawnow
end

figure
subplot(2,1,1), plot(x), grid on
subplot(2,1,2), plot(data_dspl), grid on ,axis tight