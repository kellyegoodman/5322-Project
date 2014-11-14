function xmf = spectrogram_hann_ovlp(x,m,fs)
% get the stft of x
% based on algorithm [PTVF92] by Elias Pampalk, but avoids looping by using
% reshape and concatentate functions to interleave the overlapping blocks
% m = block length

% make m even
m = m + mod(m,2);

% make x a row vector if not already (assumes x is oriented columnwise)
x = reshape(x,1,numel(x));

% zero-pad x up to a multiple of m
lx = length(x);
nt = floor((lx + m - 1)/m);
x = [x,zeros(1,-lx+nt*m)];

% interleave overlapping rectangular windows
x = reshape(x,m/2,nt*2);
x = [x;x];
x = reshape(x,m*nt*2,1);
x = x(m/2+1:length(x)-m/2);
x = reshape(x,m,nt*2-1);
% apply hanning window to blocks to diminish spectral leakage
xmw = x.*repmat(hanning(m),1,size(x,2));

f_range = linspace(0,fs/2,m);
t_range = linspace(0,lx/fs,nt*2-1);

% compute m-point DTFT of each block
xmf = fft(xmw,size(xmw,1));
xmf = xmf(1:m/2+1,:);

sg_plot(t_range,f_range,xmf);

    function h = sg_plot(t_range,f_range,y)
        % plot an image of the spectrogram
        eps = 1e-3;
        
        y_max = max(max(abs(y)));
        y_log = 20*log10(abs(y)/y_max + eps);
        fig = figure;
        
        h = imagesc(t_range,(f_range),(y_log));
        colormap(gray)
        set(gca,'YDir','normal')
        xlabel('Time [s]')
        ylabel('Frequency [Hz]')
        
    end


end