% Section 1.7 Modeling Problem 1, page 16
%This script uses linprog to solve the linear program.
% Revenue = (yield of soy * price) * acres of soy + (yield of oats * price) * acres of oats
% Maximize Z=(10⋅3)x1+(20⋅4)x2=30x1+ 80x2
% x1: acres of soy
% x2: acres of oats
% Constraints:
%   Land constraint: x1+ x2 ≤ 100
%   Labor constraint: 5x1 + 7x2 ≤ 400
%   Soy regulation: 10x1≥30⇒x1≥3
%   Non-negativity: x1,x2 ≥ 0

% Objective function coefficients (maximize 30x1 + 80x2)
f = [-30; -80];  % Negative because linprog does minimization

% Inequality constraints matrix A * x <= b
A = [1 1;       % land constraint
     5 7];      % labor constraint

b = [100;       % max land
     400];      % max labor

% Lower bounds (x1 >= 3, x2 >= 0)
lb = [3; 0];

% Solve the linear program
options = optimoptions('linprog','Display','off');
[x, fval] = linprog(f, A, b, [], [], lb, [], options);

% Output results
fprintf('Optimal acres of soy: %.2f\n', x(1));
fprintf('Optimal acres of oats: %.2f\n', x(2));
fprintf('Maximum revenue: $%.2f\n', -fval);
