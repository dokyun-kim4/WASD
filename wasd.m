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
            %Organize Time vs [x,y,z] data
            data = ParseMatlabApp(path);
            game_object.tx = [data.t_Accel,data.Accel(:,1)];
            game_object.ty = [data.t_Accel,data.Accel(:,2)];
            game_object.tz = [data.t_Accel,data.Accel(:,3)];
        end
        function game_plot(obj,which)
            %Plot Acceleration of [x,y,z] vs Time
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
            plot(t,accel_t(:,2))
            title("Wrist y-Accel Of A "+ duration+ " Minute Game Of " + obj.game);
            xlabel('Time (sec)')
            ylabel('Acceleration (m/s^2)')
        end
        function max_freq = freq_plot(obj,which)
            %Plot Frequency of [x,y,z]
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

            % Find indices corresponding to frequencies above 0.05 Hz
            index_range = find(frequencies_shifted > 0.2);
            
            % Extract data for frequencies above 0.05 Hz
            freq_above_0_05 = frequencies_shifted(index_range);
            fourier_above_0_05 = fourier(index_range);
            
            [max_amp, index] = max(abs(real(fourier_above_0_05)));
            max_freq = freq_above_0_05(index);
            
            duration = round(t(end)/60);
            hold on
            stem(frequencies_shifted,abs(real(fourier)))
            plot(max_freq,max_amp,'ro')
            text(max_freq, max_amp, ['Max freq: ', num2str(round(max_freq,3))], 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left')            
            title("Frequency Plot Of A "+ duration +" Minute Game of " + obj.game);
            xlabel('Frequencies (Hz)')
            ylabel('Magnitude')
            xlim([-0.5 0.5])
            ylim([0 1000])
        end
        function max_freq = subplots(obj,axis)
            figure()
            subplot(2,1,1)
            obj.game_plot(axis)
            subplot(2,1,2)
            max_freq=obj.freq_plot(axis);
        end
    end
    methods(Static)
        function data = trim(data,threshold_low,threshold_high)
            arguments
                data
                threshold_low {mustBeNonempty} = -0.4
                threshold_high {mustBeNonempty} = 0.4
            end
            data((data(:,2))<threshold_low,:) = [];
            data((data(:,2))>threshold_high,:) = [];
        end
        function score = strain_score(freq)
            if freq >= 0.2 && freq < 0.3
                score = 1;
            elseif freq >= 0.3 && freq < 0.4
                score = 2;
            elseif freq >= 0.4 && freq < 0.5
                score = 3;
            elseif freq >= 0.5
                score = 4;
            else
                % Handle cases where the input is outside the specified ranges
                error('Input value must be between 0.2 and above.');
            end
        end
    end
end