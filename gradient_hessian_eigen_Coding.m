% ===== Main script =====
% This program computes the gradient vector and Hessian matrix of f(x, y), and the eigenvalues of the Hessian.
% Modify the expression after f = @(x, y) to use a different function
% Try different values for x and y as well ==================

% Define the scalar function f(x, y)
f = @(x, y) x^3 - x*y^2 + y^3 - y + 1;

% Define evaluation point
x = 1;
y = 2;

% Compute the gradient of f
grad = compute_gradient(f, x, y);
disp('Gradient of f(x,y):');
disp(grad);

% Compute the Hessian of f
H = compute_hessian(f, x, y);
disp('Hessian of f(x,y):');
disp(H);

% Compute eigenvalues
eigenvalues = eig(H);
disp('Eigenvalues of Hessian:');
disp(eigenvalues);

% Determine definiteness
if all(eigenvalues > 0)
    definiteness = 'H is positive definite → local minimum.';
elseif all(eigenvalues < 0)
    definiteness = 'H is negative definite → local maximum.';
elseif any(eigenvalues > 0) && any(eigenvalues < 0)
    definiteness = 'H is indefinite → saddle point.';
else
    definiteness = 'H has zero eigenvalue → inconclusive.';
end

% Prepare all results in one text block
results_text = sprintf([ ...
    'Point evaluated: (x, y) = (%.2f, %.2f)\n\n', ...
    'Gradient:\n  [%.6f ; %.6f]\n\n', ...
    'Hessian:\n  [%.6f  %.6f;\n   %.6f  %.6f]\n\n', ...
    'Eigenvalues:\n  [%.6f ; %.6f]\n\n', ...
    '%s'], ...
    x, y, ...
    grad(1), grad(2), ...
    H(1,1), H(1,2), H(2,1), H(2,2), ...
    eigenvalues(1), eigenvalues(2), ...
    definiteness);

% Display all results in a single figure
figure;
axis off;
text(0.05, 0.5, results_text, 'FontSize', 12, 'FontName', 'Courier');

% ===== Local function to compute gradient =====
function grad = compute_gradient(f, x, y, step)
    if nargin < 4
        step = 1e-5;
    end
    dfdx = (f(x + step, y) - f(x - step, y)) / (2 * step);
    dfdy = (f(x, y + step) - f(x, y - step)) / (2 * step);
    grad = [dfdx; dfdy];
end

% ===== Local function to compute Hessian =====
function H = compute_hessian(f, x, y, step)
    if nargin < 4
        step = 1e-5;
    end
    f_xx = (f(x + step, y) - 2*f(x, y) + f(x - step, y)) / step^2;
    f_yy = (f(x, y + step) - 2*f(x, y) + f(x, y - step)) / step^2;
    f_xy = (f(x + step, y + step) - f(x + step, y - step) - ...
            f(x - step, y + step) + f(x - step, y - step)) / (4 * step^2);
    H = [f_xx, f_xy; f_xy, f_yy];
end


results_text = sprintf([ ...
    'Function:\n  f(x, y) = x^3 - x*y^2 + y^3 - y + 1\n\n', ...
    'Point evaluated: (x, y) = (%.2f, %.2f)\n\n', ...
    'Gradient:\n  [%.6f ; %.6f]\n\n', ...
    'Hessian:\n  [%.6f  %.6f;\n   %.6f  %.6f]\n\n', ...
    'Eigenvalues:\n  [%.6f ; %.6f]\n\n', ...
    '%s'], ...
    x, y, ...
    grad(1), grad(2), ...
    H(1,1), H(1,2), H(2,1), H(2,2), ...
    eigenvalues(1), eigenvalues(2), ...
    definiteness);



% Add plot of f(x,y) on the left side
clf; % Clear current figure
subplot(1,2,1); % Left side for the graph
[x_vals, y_vals] = meshgrid(linspace(x-5,x+5,100), linspace(y-5,y+5,100));
z_vals = arrayfun(f, x_vals, y_vals);
surf(x_vals, y_vals, z_vals);
xlabel('x'); ylabel('y'); zlabel('f(x, y)');
title('Surface Plot of f(x, y)');
shading interp;
hold on;
plot3(x, y, f(x,y), 'ro', 'MarkerSize', 10, 'LineWidth', 2); % Mark the evaluation point

% Right side for text results
subplot(1,2,2);
axis off;
text(0.05, 0.5, results_text, 'FontSize', 12, 'FontName', 'Courier');

