% Newton's method to minimize function f23 (equation 2.3)

function newton_monthly_payment()
    % Initial guess (x should never be zero to avoid division by zero)
    xk = 10;  
    yk = 5;

    % Stopping criteria parameters
    tol = 1e-6;       % tolerance on Newton step norm
    max_iter = 30;    % max iterations allowed
    h = 1e-5;         % finite difference step size for numerical derivatives

    fprintf('Starting Newton optimization...\n');

    for k = 1:max_iter
        % Compute gradient at current point numerically
        grad = numerical_gradient(@f23, xk, yk, h);

        % Compute Hessian at current point numerically
        H = numerical_hessian(@f23, xk, yk, h);

        % Suppress warnings for nearly singular matrix during inversion
        warning('off', 'MATLAB:singularMatrix');
        warning('off', 'MATLAB:nearlySingularMatrix');

        % Compute Newton step: delta = -inv(H)*grad
        try
            delta = -H \ grad;
        catch
            warning('on', 'MATLAB:singularMatrix');
            warning('on', 'MATLAB:nearlySingularMatrix');
            fprintf('Hessian is not invertible. Stopping.\n');
            return;
        end

        warning('on', 'MATLAB:singularMatrix');
        warning('on', 'MATLAB:nearlySingularMatrix');

        % Check if delta or current variables have NaNs (invalid values)
        if any(isnan(delta)) || isnan(xk) || isnan(yk)
            fprintf('NaN encountered in delta or variables before update. Stopping.\n');
            return;
        end

        % Update variables
        xk = xk + delta(1);
        yk = yk + delta(2);

        % Check NaNs after update
        if isnan(xk) || isnan(yk)
            fprintf('NaN encountered after update. Stopping.\n');
            return;
        end

        % Display progress
        if k == 1
            fprintf('\n%-8s %-16s %-16s %-16s\n', 'Iter', 'x', 'y', '||step||');
        end
        fprintf('%-8d %-16.6f %-16.6f %-16.2e\n', k, xk, yk, norm(delta));

        % Convergence test
        if norm(delta) < tol
            fprintf('Converged in %d iterations.\n', k);
            fprintf('Minimum approx. at (x, y) = (%.6f, %.6f)\n', xk, yk);
            fprintf('f(x, y) = %.6f\n', f23(xk, yk));
            return;
        end
    end

    % If maximum iterations reached without convergence
    fprintf('Stopped: maximum iterations (%d) reached without convergence.\n', max_iter);
    fprintf('Last iterate: (x, y) = (%.6f, %.6f)\n', xk, yk);
    fprintf('f(x, y) = %.6f\n', f23(xk, yk));
end

% Function 2.3: monthly payment function
function val = f23(x, y)
    % Protect against division by zero or invalid denominators
    if x == 0 || (108 - x)^2 == 0 || (30 - y)^5 == 0
        val = Inf;
        return;
    end
    base = 1 + 109 / ((108 - x)^2 * (30 - y)^5);
    val = ((30 - y) * base^(x/12)) / x;
end

% Numerical gradient using central differences
function g = numerical_gradient(f, x, y, h)
    fx = (f(x + h, y) - f(x - h, y)) / (2*h);
    fy = (f(x, y + h) - f(x, y - h)) / (2*h);
    g = [fx; fy];
end

% Numerical Hessian using finite differences
function H = numerical_hessian(f, x, y, h)
    fxx = (f(x + h, y) - 2*f(x, y) + f(x - h, y)) / h^2;
    fyy = (f(x, y + h) - 2*f(x, y) + f(x, y - h)) / h^2;
    fxy = (f(x + h, y + h) - f(x + h, y - h) - f(x - h, y + h) + f(x - h, y - h)) / (4*h^2);
    H = [fxx, fxy; fxy, fyy];
end
