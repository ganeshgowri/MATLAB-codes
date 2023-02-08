clearvars;
clc

jan_2013=readtable('2013.xlsx','Sheet','Sheet1','Range','A99:AA44768');

jan_2013_TT = table2timetable(jan_2013);

jan_2013_TT_hourly=retime(jan_2013_TT,'hourly','mean');
a=1;


for i=1:1:32
%     rowTimes = (00:01:00:23:00:00);
% S = withtol(rowTimes,days(i));
subplot(5,7,i+2)
yyaxis left %yyaxis left activates the side of the current axes associated with the left y-axis. Subsequent graphics commands target the left side.

plot(jan_2013_TT_hourly.x01_01_201300_01_00(a:a+24),jan_2013_TT_hourly.x0(a:a+24));

hold on;

%ylim([0 5]);

% ylabel('G(W/m2)');

yyaxis right %yyaxis right activates the side of the current axes associated with the right y-axis. Subsequent graphics commands target the right side.

 % Plot into right axes
% ylabel('T(Deg.C)');


plot(jan_2013_TT_hourly.x01_01_201300_01_00(a:a+24),jan_2013_TT_hourly.x_82_3(a:a+24));
%         A([a a+24],1)=jan_2013_TT_hourly([a a+24],1);
%          A([a a+24],3)=jan_2013_TT_hourly([a a+24],3);
   a=a+24;
hold on
end
               
jan_2013_TT_daily=retime(jan_2013_TT_hourly,'daily','mean');

jan_2013_TT_daily_no_time=timetable2table(jan_2013_TT_daily,'ConvertRowTimes',false);

p_jan_2013=jan_2013_TT_daily_no_time(:,[15 5 3 17 23]); 

[p_jan_2013_Tamb,jan_2013_i_Tamb] =sortrows(p_jan_2013(:,1));

[p_jan_2013_dni,jan_2013_i_dni] =sortrows(p_jan_2013(:,2));

[p_jan_2013_ghi,jan_2013_i_ghi] =sortrows(p_jan_2013(:,3));

[p_jan_2013_rh,jan_2013_i_rh] =sortrows(p_jan_2013(:,4));

[p_jan_2013_dp,jan_2013_i_dp] =sortrows(p_jan_2013(:,5));

p_jan_2013_Table_sorted=[p_jan_2013_Tamb p_jan_2013_dni p_jan_2013_ghi p_jan_2013_rh p_jan_2013_dp];

jan_2013_array=[jan_2013_i_Tamb jan_2013_i_dni jan_2013_i_ghi jan_2013_i_rh jan_2013_i_dp];

jan_2013_array_sorted_mean=mean(jan_2013_array);

p_jan_2013_array_sorted=table2array(p_jan_2013_Table_sorted);

p_jan_2013_array_sorted_mean=mean(p_jan_2013_array_sorted,'omitnan');

%p_jan_2013_array_sorted_sd=sd(p_jan_2013_array_sorted,'omitnan',0,1);

F_jan_2013 = cdf('Normal',p_jan_2013_array_sorted,p_jan_2013_array_sorted_mean);


jan_2014=readtable('2014.xlsx','Sheet','Sheet1','Range','A99:AA44768');
jan_2014_TT = table2timetable(jan_2014);
jan_2014_TT_hourly=retime(jan_2014_TT,'hourly','mean');
jan_2014_TT_daily=retime(jan_2014_TT_hourly,'daily','mean');
F_jan_2014=cdf(jan_2014_TT_daily);
jan_2015=readtable('2015.xlsx','Sheet','Sheet1','Range','A99:AA44768');
jan_2015_TT = table2timetable(jan_2015);
jan_2015_TT_hourly=retime(jan_2015_TT,'hourly','mean');
jan_2015_TT_daily=retime(jan_2015_TT_hourly,'daily','mean');
F_jan_2015=cdf(jan_2015_TT_daily);