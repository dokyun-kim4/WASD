function wasd(data,game,threshold)
%Function for plotting Game Data
%   data: Input .csv file
%   game: Input game name string
%   threshold: Input threshold for trimming data
    arguments
        data
        game
        threshold=0.4;
    end
    %Read Data
    data = csvread(data,5);

    %Time vs Set Acceleration
    ty = [data(:,2),data(:,4)];
    
    %Filter any data above set threshold
    ty(abs(ty(:,2))>threshold,:) = [];


    t = ty(:,1);
    y = ty(:,2);
    
    %Acceleration Plot
    figure()
    plot(t,y)
    title("Wrist y-accel during a 37 minute game of " + game);
    xlabel('time (sec)')
    
    %Perform fourier transform
    fourier = fftshift(fft(y));
    N = length(y);
    Fs = 1/(t(2) - t(1));
    low = (-pi+(pi/N))*Fs;
    high = (pi-(pi/N))*Fs;
    frequencies_shifted = linspace(low, high, N)';
    
    %Frequency Plot
    figure()
    stem(frequencies_shifted,abs(real(fourier)))
    title("Frequency plot of a 37 minute game of " + game);
    xlabel('Frequencies')
end

