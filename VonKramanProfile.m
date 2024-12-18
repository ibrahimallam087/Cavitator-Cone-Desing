% MATLAB script for Von Karman nose cone profile with plotting

% Parameters
R = 8 / 2; % Base radius in cm
L = 31.1743; % Cone length in cm

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

% Save to .txt file
file_path = 'Von_Karman_Profile.txt';
file_id = fopen(file_path, 'w');

% Write fixed header lines
fprintf(file_id, '3d = True\n');
fprintf(file_id, 'Fit = True\n');

% Write data in the format: z x y
for i = 1:length(x_values)
    fprintf(file_id, '0\t%.6f\t%.6f\n', x_values(i), y_values(i));
end

fclose(file_id);

% Plot the profile
figure;
plot(x_values, y_values, 'b-', 'LineWidth', 1.5);
xlabel('x (cm)');
ylabel('y (cm)');
title('Von Karman Nose Cone Profile');
grid on;
axis equal;

disp(['Profile data saved to ', file_path]);
