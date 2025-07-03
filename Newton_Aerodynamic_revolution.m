% Problem 2.3, page 30
% Sketches of three surfaces of revolution
% The result is shown as 2D graphs and 3D revolution surfaces around the X-axis
% Inext to each graph is respective value of Newton’s integral
% Compute the integral:
% ∫₀¹ [x(t) * (ẋ(t))^3] / [1 + (ẋ(t))^2] dt
% where:
% x(t) is a function of t
% ẋ(t) is the derivative of x(t) with respect to t
%============================

% Define parameter t
t = linspace(0, 1, 500);

% Define each function x(t)
x1 = t;
x2 = t + (1/pi) * sin(2*pi*t);
x3 = t.^2;

% Plotting curves
figure;
hold on;
plot(t, x1, 'r', 'LineWidth', 2);           % x(t) = t
plot(t, x2, 'b', 'LineWidth', 2);           % x(t) = t + (1/pi) * sin(2πt)
plot(t, x3, 'g', 'LineWidth', 2);           % x(t) = t^2

% Annotations
legend('x(t) = t', 'x(t) = t + (1/\pi)sin(2\pi t)', 'x(t) = t^2', 'Location', 'northwest');
xlabel('t');
ylabel('x(t)');
title('Curves x(t) in the (t, x) Plane');
grid on;
axis tight;

%================================
% Compute Newton's integrals
f1 = @(t) t;
df1 = @(t) 1;
f2 = @(t) t + (1/pi)*sin(2*pi*t);
df2 = @(t) 1 + 2*cos(2*pi*t);
f3 = @(t) t.^2;
df3 = @(t) 2*t;

I = @(f, df) integral(@(t) (f(t).*(df(t)).^3)./(1 + (df(t)).^2), 0, 1);
I1 = I(f1, df1);
I2 = I(f2, df2);
I3 = I(f3, df3);

% Parameters for revolution
t = linspace(0, 1, 200);
theta = linspace(0, 2*pi, 200);
[T, Theta] = meshgrid(t, theta);

X1 = T;
X2 = T + (1/pi) * sin(2*pi*T);
X3 = T.^2;

% Convert to Cartesian
Y1 = X1 .* cos(Theta); Z1 = X1 .* sin(Theta); Z1z = T;
Y2 = X2 .* cos(Theta); Z2 = X2 .* sin(Theta); Z2z = T;
Y3 = X3 .* cos(Theta); Z3 = X3 .* sin(Theta); Z3z = T;

% Plotting revolution surfaces (The value of Newton’s integral)
figure;

% Subplot (x = t)
subplot(1,3,1)
surf(Y1, Z1, Z1z, 'EdgeColor', 'none')
title('Surface: x(t) = t')
xlabel('x'); ylabel('y'); zlabel('z')
axis equal; camlight; lighting gouraud
text(0, -2.2, -0.3, sprintf('I_1 = %.4f', I1), ...
    'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold');

% Subplot (x = t + (1/pi)sin(2pi t))
subplot(1,3,2)
surf(Y2, Z2, Z2z, 'EdgeColor', 'none')
title('Surface: x(t) = t + (1/\pi)sin(2\pi t)')
xlabel('x'); ylabel('y'); zlabel('z')
axis equal; camlight; lighting gouraud
text(0, -2.2, -0.3, sprintf('I_2 = %.4f', I2), ...
    'Color', 'b', 'FontSize', 12, 'FontWeight', 'bold');

% Subplot (x = t^2)
subplot(1,3,3)
surf(Y3, Z3, Z3z, 'EdgeColor', 'none')
title('Surface: x(t) = t^2')
xlabel('x'); ylabel('y'); zlabel('z')
axis equal; camlight; lighting gouraud
text(0, -2.2, -0.3, sprintf('I_3 = %.4f', I3), ...
    'Color', 'g', 'FontSize', 12, 'FontWeight', 'bold');
