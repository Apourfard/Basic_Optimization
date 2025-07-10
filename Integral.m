%Discretization of the Integral — Single Variable Function
% Formula (6.1-c), chapitre 6, page 84:
% Integral from 0 to 1 of [t / (1 + (x'(t))^2)] dt
%% Section 1
% Define variables for general expression
syms x0 xm x1

t = [0; 1/2; 1];
X = [x0; xm; x1];
X_prime = [2*(xm - x0); (x1 - x0); 2*(x1 - xm)];

T = table(t, X, X_prime, ...
    'VariableNames', {'t', 'x(t)', 'x_prime(t)'});

disp(T) 
%% Section 2

% Discretize the integral using the trapezoidal rule as before:
%     ∫_0^1 [ t / (1 + (x'(t))^2) ] dt ≈ (1/4) * [ 1 / (1 + (x1 - x0)^2) + 1 / (1 + 4*(x1 - xm)^2) ]

% Fix two of the values and vary the third to get a function of one variable.
% x0 = 0
% x1 = 1
% xm = a
% Then:
% F(a) = (1/4) * [ 1 / (1 + 1^2) + 1 / (1 + 4*(1 - a)^2) ]
% F(a) = (1/4) * (1/2 + 1 / (1 + 4*(1 - a)^2))
% This is the single-variable function resulting from the discretization.

% -------------------------------------------------------------------------
% La règle des trapèzes (classique)
% Elle approxime une intégrale en remplaçant la courbe par un trapèze entre deux points.
% Soit une fonction f(t) sur un intervalle [a,b], avec deux points :
%     t0 = a
%     t1 = b
% Alors : integral_a^b f(t) dt ≈ (h/2) * [f(t0) + f(t1)]
% où h = b - a, la largeur du trapèze.

% Quand on a trois points (comme ici)
%     t0 = 0
%     tm = 0.5
%     t1 = 1
% Le pas h = 0.5 entre les points successifs.
% la règle des trapèzes étendue devient :
%  integral_0^1 f(t) dt ≈ (h/2) * [f(t0) + 2*f(tm) + f(t1)]
%  integral_0^1 f(t) dt ≈ (0.5/2) * [f(t0) + 2*f(tm) + f(t1)] = (1/4) * [f(t0) + 2*f(tm) + f(t1)]
% -------------------------------------------------------------------------
%% Section 3
function integral = F(a)
% Single-variable function from discretized integral

integral = (1/4) * (1/2 + 1 / (1 + 4 * (1 - a)^2));

end

%% Constraint Explanation

% The constraint x'(t) ≥ 0 translates into:
%     2a       ≥ 0   →   a ≥ 0        (from x'(0) ≈ 2*(a - x0), with x0 = 0)
%     1        ≥ 0   →   always true  (from x'(0.5) ≈ x1 - x0 = 1, with x0 = 0, x1 = 1)
%     2*(1 - a) ≥ 0  →   a ≤ 1        (from x'(1) ≈ 2*(x1 - a), with x1 = 1)

% Therefore, the constraint x'(t) ≥ 0 implies:
%     0 ≤ a ≤ 1

% This is the range of admissible values for the single variable a = x(1/2)
% to ensure the original constraint is respected in the discretized setting.
