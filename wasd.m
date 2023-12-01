classdef wasd
    %Class representing the Game Data
    %Initialize by inputting raw game acceleration data
    properties
        game
        tx
        ty
        tz
    end
    methods
        function game_object =  wasd(path)
            data = ParseMatlabApp(path);
            game_object.tx = [data.t_Accel,data.Accel(:,1)];
            game_object.ty = [data.t_Accel,data.Accel(:,2)];
            game_object.tz = [data.t_Accel,data.Accel(:,3)];
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
            t = accel_t(:,1);
            duration = round(t(end)/60);
            
            figure()
            plot(accel_t(:,1),accel_t(:,2))
            title("Wrist y-accel during a "+ duration+ " minute game of " + obj.game);
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
            
            duration = round(t(end)/60);
            figure()
            stem(frequencies_shifted,abs(real(fourier)))
            title("Frequency plot of a "+ duration +" minute game of " + obj.game);
            xlabel('Frequencies (Hz)')
            ylabel('Amplitude')
            xlim([-5 5])
            ylim([0 1000])
        end
    end
    methods(Static)
        function data = trim(data,threshold)
            arguments
                data
                threshold {mustBeNonempty} = 0.4
            end
            data((data(:,2))>threshold,:) = [];
        end
    end
end