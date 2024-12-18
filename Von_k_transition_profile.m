% MATLAB script for Von Karman nose cone profile with smooth transition to the base

% Parameters
R = 8 / 2; % Base radius in cm
L = 31.2; % Cone length in cm

% Number of intervals
n_points = 500;

% Generate x values (divide L into intervals)
x_values = linspace(0, L, n_points);

% Initialize y values
y_values = zeros(size(x_values));

% Calculate the Von Karman profile
theta = @(x) acos(1 - 2 * x / L); % Function for theta
y = @(theta) R * sqrt((theta - sin(2 * theta) / 2) / pi); % Function for y

% Transition parameters
transition_length = 3.4843; % Length over which the transition happens
transition_start_index = round(n_points * (L - transition_length) / L); % Starting index for transition

% Calculate the Von Karman profile with a smooth transition to the base
for i = 1:length(x_values)
    t = theta(x_values(i));
    if i >= transition_start_index
        % Smooth transition: blend from the Von Karman profile to a straight line (tangent at the base)
        transition_factor = (x_values(i) - x_values(transition_start_index)) / transition_length;
        % Smooth blend between Von Karman profile and a straight line with radius R
        y_values(i) = y(t) * (1 - transition_factor) + R * transition_factor;
    else
        % For the cone region, use the Von Karman profile
        y_values(i) = y(t);
    end
end

% Save to .txt file
file_path = 'Von_Karman_Profile_Transition.txt';
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
title('Von Karman Nose Cone Profile with Smooth Transition');
grid on;
axis equal;

disp(['Profile data saved to ', file_path]);
