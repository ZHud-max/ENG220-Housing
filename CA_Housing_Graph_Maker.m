% Load cleaned data sets
cl_data_1990 = readtable('cleaned_california_housing_1990.csv');
cl_data_updated = readtable('cleaned_california_housing_updated.csv');

summary(cl_data_1990);
summary(cl_data_updated);

%% --- Pie Charts for "ocean_proximity" ---
figure;
subplot(1, 2, 1);
pie(categorical(cl_data_1990.ocean_proximity));
title('Ocean Proximity - 1990 Data');

subplot(1, 2, 2);
pie(categorical(cl_data_updated.ocean_proximity));
title('Ocean Proximity - Updated Data');

%% --- Grouped Bar Chart: Median House Value by Age Range ---
edges = [0 10 20 30 40 50 60 70 80 100];

[~,~,bins_1990] = histcounts(cl_data_1990.housing_median_age, edges);
[~,~,bins_updated] = histcounts(cl_data_updated.average_house_age, edges);

mean_value_1990 = accumarray(bins_1990(~isnan(bins_1990)), ...
    cl_data_1990.median_house_value(~isnan(bins_1990)), [], @mean);
mean_value_updated = accumarray(bins_updated(~isnan(bins_updated)), ...
    cl_data_updated.median_house_value(~isnan(bins_updated)), [], @mean);

xlabels = {'0-9','10-19','20-29','30-39','40-49','50-59','60-69','70-79','80+'};

len = min(length(mean_value_1990), length(mean_value_updated));
mean_value_1990 = mean_value_1990(1:len);
mean_value_updated = mean_value_updated(1:len);
xlabels = xlabels(1:len);

figure;
bar(categorical(xlabels), [mean_value_1990 mean_value_updated], 'grouped');
xlabel('Housing Age Range');
ylabel('Average Median House Value ($)');
title('Comparison of Housing Median Age and Value');
legend('1990 Data', 'Updated Data', 'Location', 'northoutside', 'Orientation', 'horizontal');
colormap([0.2 0.4 0.8; 0.9 0.4 0.2]);
set(gca, 'YGrid', 'on', 'Box', 'off');

%% --- Box Plot: Distribution Comparison ---
figure;
boxplot([cl_data_1990.median_house_value; cl_data_updated.median_house_value], ...
        [repmat({'1990'}, height(cl_data_1990), 1);
         repmat({'Updated'}, height(cl_data_updated), 1)]);
title('Comparison of Median House Value Distributions');
ylabel('Median House Value ($)');
