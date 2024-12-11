% MATLAB script for Von Karman nose cone profile with plotting

% Parameters
R = 1.5; % Base radius in cm
L = 6.7; % Cone length in cm

% Number of intervals
n_points = 50;

% Generate x values (divide L into intervals)
x_values = linspace(0, L, n_points);

% Initialize y values
y_values = zeros(size(x_values));

% Calculate the Von Karman profile
theta = @(x) acos(1 - 2 * x / L); % Function for theta
y = @(theta) R * sqrt((theta - sin(2 * theta) / 2) / pi); % Function for y

for i = 1:length(x_values)
    t = theta(x_values(i));
    y_values(i) = y(t);
end

% Save to Excel
file_path = 'Von_Karman_Profile.xlsx';
table_data = table(x_values', y_values', 'VariableNames', {'x_cm', 'y_cm'});
writetable(table_data, file_path);

% Plot the profile
figure;
plot(x_values, y_values, 'b-', 'LineWidth', 1.5);
hold on;
plot(x_values, -y_values, 'b-', 'LineWidth', 1.5); % Symmetric bottom half
xlabel('x (cm)');
ylabel('y (cm)');
title('Von Karman Nose Cone Profile');
grid on;
axis equal;
disp(['Profile data saved to ', file_path]);
