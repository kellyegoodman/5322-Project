%% TEST OPEN SONGS, GET MFCCS
clear all; close all; clc
fs = 11025;     % is this the correct sampling frequency?

load('truth.mat');
filepath = 'C:\Users\kellygoodman\Documents\CU BOULDER\ECEN 5322\PROJECT\tracks\';

% make mfcc parameter structure
p.fs = fs;
p.visu            = 0;
p.fft_size        = 256;
p.hopsize         = 128;
p.num_ceps_coeffs = 20;
p.use_first_coeff = 1;
p.mel_filt_bank   = 'auditory-toolbox'; 
p.dB_max          = 96;

num_songs = 1;
num_coeff = 10;
genres = cell(1,num_songs);
figure
for n = 1:num_songs
    % select a song
    i = round((n-1)*length(truth)/num_songs+1);
filename = [filepath, truth{i,1}];
genres{n} = truth{i,2};
y = wavread(filename);

% sample the song
time_len = 30;  % number of seconds to sample
start = floor((length(y) - time_len*fs)/2);
stop = start + floor(time_len*fs);
chunk = y(start:min(stop,length(y)));
%plot(chunk)

% look at mfcc of the song chunk
[mfcc,DCT] = ma_mfcc(chunk, p);
subplot(2,5,n)
% plot first num_coeff MFCC coefficients (Tzanetakis paper recommends first 5)
% ignore "0th" (i.e. DC) MFCC
imagesc(mfcc(2:(2+num_coeff),:))

% plot spectrogram
m = round(.023*fs);   % window size is approximately 23ms
[sone, Ntot, p] = ma_sone(chunk,p);
xmf = spectrogram_hann_ovlp(chunk,m,fs);
%imagesc(fft)
%imagesc(sone)

title(truth{i,2});
end
%suptitle(['First ',num2str(num_coeff),' MFCC coefficients of random songs'])
suptitle('Spectrogram of Songs')