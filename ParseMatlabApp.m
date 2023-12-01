function [MotionData]=ParseMatlabApp(filename)
%Script reads in files saved from the Matlab App and parses the data from
%the matlab "timetable" format, to a simple ".mat" file. This code assumes
%you have saved Acceleration, Orientation, and Angular Velocity.

%load data file that was collected using the Matlab app
load(filename,'Acceleration')

function [t_seconds]=CreateTimeVector(t_app)
t_seconds=datevec(t_app);
t_seconds=t_seconds(:,4).*60*60+t_seconds(:,5).*60+t_seconds(:,6);
t_seconds=t_seconds-t_seconds(1);
end

%create time vector in seconds for the acceleration data
t_Accel=CreateTimeVector(Acceleration.Properties.RowTimes);

%Find the data collection frequency for each measurement
Accel_rate=1/mean(diff(t_Accel));
%Extract the acceleration, orientation, and angular velocity values
MotionData.Accel=table2array(timetable2table(Acceleration,'ConvertRowTimes',false));

%Package the data into a structure for easy access
MotionData.t_Accel=t_Accel;
MotionData.accel_rate=Accel_rate;
end