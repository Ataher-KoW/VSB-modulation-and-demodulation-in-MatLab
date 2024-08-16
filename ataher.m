fs = 1e5;
t = -0.01:1/fs:0.01;  
fc = 2e4;  
m = sinc(1e4*t); 
carrier = cos(2*pi*fc*t); 
dsb_sc = m .* carrier; 
Wn = (fc - 2) / (fs/2) 
[b, a] = butter(15, Wn, 'high'); 
vsb = filter(b, a, dsb_sc);
demodulated = vsb .* carrier;  
cutoff_lp = 5e3 / (fs/2);  
[b_lp, a_lp] = butter(8, cutoff_lp, 'low'); 
demodulated_filtered = filter(b_lp, a_lp, demodulated);
N = length(t);
f = (-N/2:N/2-1)*(fs/N);
m_fft = fftshift(fft(m, N));  
dsb_sc_fft = fftshift(fft(dsb_sc, N));
vsb_fft = fftshift(fft(vsb, N));
demodulated_fft = fftshift(fft(demodulated_filtered, N));
m_fft_normalized = m_fft / max(abs(m_fft));
dsb_sc_fft_normalized = dsb_sc_fft / max(abs(dsb_sc_fft));
vsb_fft_normalized = vsb_fft / max(abs(vsb_fft));
demodulated_fft_normalized = demodulated_fft / max(abs(demodulated_fft));

%بلوت للانبوت
figure;
subplot(5,1,1);
plot(f, abs(m_fft_normalized), 'm', 'LineWidth', 1.5);
title('Frequency Spectrum of Input Signal (sinc function)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
%بلوت للدبل سايد باند
subplot(5,1,2);
plot(f, abs(dsb_sc_fft_normalized), 'r', 'LineWidth', 1.5);
title('Frequency Spectrum of DSB-SC Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
%vsb plot
subplot(5,1,3);
plot(f, abs(vsb_fft_normalized), 'b', 'LineWidth', 1.5);
title('Frequency Spectrum of VSB Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
%demodultaed
subplot(5,1,4);
plot(f, abs(demodulated_fft_normalized), 'g', 'LineWidth', 1.5);
title('Frequency Spectrum of Demodulated Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');