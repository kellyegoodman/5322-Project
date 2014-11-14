%% LOAD DATA
clear all; close all; clc

% load genres
filename = 'genres.txt';
filepath = 'C:\Users\kellygoodman\Documents\CU BOULDER\ECEN 5322\PROJECT\';
filename = [filepath,filename];

genres = importdata(filename);
% save('genres.mat','genres')

% load truth table
DELIMITER = '\t';
HEADERLINES = 0;

filename = [filepath,'ground_truth.xlsx'];

truth = importdata(filename,DELIMITER);
for i = 1:size(truth,1)
    song_name = truth{i,1};
    truth{i,1} = [song_name(8:end-3), 'wav'];
end
% save('truth.mat','truth')