classdef wasd_c
    %Class representing the Game Data
    %Initialize by inputting raw game acceleration data
    properties
        game
        tx
        ty
        tz
    end
    methods
        function game_object =  wasd_c(data)
            game_object.tx = [data(:,2),data(:,5)];
            game_object.ty = [data(:,2),data(:,4)];
            game_object.tz = [data(:,2),data(:,3)];
        end
        function game_plot(obj,which)
            switch which
                case 'x'
                    accel_t = obj.tx;
                case 'y'
                    accel_t = obj.ty;
                case 'z'
                    accel_t = obj.tz;
            end
            figure()
            plot(accel_t(:,1),accel_t(:,2))
            title("Wrist y-accel during a 37 minute game of " + obj.game);
            xlabel('Time (sec)')
            ylabel('y-Acceleration (m/s^2)')
        end
        function freq_plot(obj,which)
            switch which
                case 'x'
                    accel_t = obj.tx;
                case 'y'
                    accel_t = obj.ty;
                case 'z'
                    accel_t = obj.tz;
            end
            t = accel_t(:,1);
            accel = accel_t(:,2);
            
            fourier = fftshift(fft(accel));
            N = length(accel);
            Fs = 1/(t(2) - t(1));
            low = (-pi+(pi/N))*Fs;
            high = (pi-(pi/N))*Fs;
            frequencies_shifted = linspace(low, high, N)';
            
            figure()
            stem(frequencies_shifted,abs(real(fourier)))
            title("Frequency plot of a 37 minute game of " + obj.game);
            xlabel('Frequencies')
            ylabel('Amplitude')
        end
    end
    methods(Static)
        function data = trim(data,threshold)
            arguments
               data
               threshold {mustBeNonempty} = 0.4
            end
            data(abs(data(:,2))>threshold,:) = [];
        end
    end
end