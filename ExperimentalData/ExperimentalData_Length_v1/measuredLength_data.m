
close all
clear
clc

% % Load data
data_upperLength = load('Figard_2013_Length_UpperBound.csv');
data_lowerLength = load('Figard_2013_Length_LowerBound.csv');
data_meanLength = load('Figard_2013_Length_Mean.csv');

% In vivo length data
XDataMn = data_meanLength(:,1);
YDataMn = data_meanLength(:,2);

XDataLwr = flip(data_lowerLength(:,1));
YDataLwr = flip(data_lowerLength(:,2));

XDataUpr = data_upperLength(:,1);
YDataUpr = data_upperLength(:,2);

% % Interpolate
x_interp = linspace(0,max(XDataLwr(end),XDataUpr(end)),5000);
y_interpLwr = interp1(XDataLwr,YDataLwr,x_interp);
y_interpUpr = interp1(XDataUpr,YDataUpr,x_interp);
y_interpMn = interp1(XDataMn,YDataMn,x_interp);

% y_mean = mean([y_interpLwr; y_interpUpr],1);

plot(x_interp,y_interpUpr,'--')
hold on
plot(x_interp,y_interpMn)
% plot(XDataUpr,YDataUpr)
% plot(XDataLwr,YDataLwr)
plot(x_interp,y_interpLwr,'--')
hold off

save("measuredLength_data.mat","x_interp","y_interpMn","y_interpLwr","y_interpUpr")