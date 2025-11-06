% Load cleaned data sets
cl_data_1990 = readtable('cleaned_california_housing_1990.csv');
cl_data_updated = readtable('cleaned_california_housing_updated.csv');

% Two pie charts for each data set for column "ocean_proximity" 
% data type: catagorical
% Create pie charts for the "ocean_proximity" column
figure;
subplot(1, 2, 1);
pie(categorical(cl_data_1990.ocean_proximity));
title('Ocean Proximity - 1990 Data');
subplot(1, 2, 2);
pie(categorical(cl_data_updated.ocean_proximity));
title('Ocean Proximity - Updated Data');

% Whisker plot comparing the "housing_median_age" column in "cl_data_1990"
% and the "median_house_value" column in "cl_data_updated"
% for every entry that has a "average_house_age" of 30 or greater
filteredData = cl_data_1990(cl_data_1990.housing_median_age >= 30, :);
whiskerData = [filteredData.housing_median_age, cl_data_updated.median_house_value(cl_data_updated.average_house_age >= 30)];
figure;
boxplot(whiskerData, 'Labels', {'1990 Housing Median Age', 'Updated Median House Value'});
title('Whisker Plot Comparison');
% Create a second boxplot for the filtered data
hold on; % Retain current plot
boxplot(cl_data_updated.median_house_value(cl_data_updated.average_house_age >= 30), 'Labels', {'Updated Median House Value'});
hold off; % Release the plot hold
% Add labels and legend to the boxplot
ylabel('Values');
legend({'1990 Housing Median Age', 'Updated Median House Value'}, 'Location', 'Best');
