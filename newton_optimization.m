% Chapter 3, page 40

function newton_optimization()
    % Initial guess
    xk = 1.0;
    yk = 1.0;

    % Parameters
    tol = 1e-6;
    max_iter = 20;

fprintf('\n%-6s %-12s %-12s %-12s\n', 'Iter', 'x', 'y', '||step||');

    for k = 1:max_iter
        % Gradient
        fx = 3*xk^2 - yk^2;
        fy = -2*xk*yk + 3*yk^2 - 1;
        grad = [fx; fy];

        % Hessian
        fxx = 6*xk;
        fxy = -2*yk;
        fyy = -2*xk + 6*yk;
        H = [fxx, fxy; fxy, fyy];

        % Newton step vector (d)
        try
            delta = -H \ grad;
        catch
            disp('Hessian is not invertible.');
            return
        end

        % Update
        xk = xk + delta(1);
        yk = yk + delta(2);

        % Display iteration
        fprintf('%-6d %-12.6f %-12.6f %-12.2e\n', k, xk, yk, norm(delta));

        % Check convergence
        if norm(delta) < tol
            fprintf('Converged in %d iterations.\n', k);
            break
        end
    end

    fprintf('Approximate minimum at (x, y) = (%.6f, %.6f)\n', xk, yk);
end


% -----------------------------------------------
% Explanation of ||step||:
% -----------------------------------------------
% The "step" vector in Newton's method is:
%     delta = [Δx; Δy] = -H \ grad

% The notation ||step|| refers to the Euclidean norm
% (also called the 2-norm) of the step vector:

%     ||step|| = sqrt((Δx)^2 + (Δy)^2)

% This value measures how much the optimization point
% is moving during each iteration.

% We use ||step|| to check convergence:
%     If ||step|| < tolerance, we assume that the
%     method has reached a local minimum, and we stop.

% In MATLAB, this is calculated using:
%     norm(delta)
% -----------------------------------------------
