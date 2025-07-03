% A Blending Example, section 1.3, page 5

% Coût (objectif à minimiser)
f = [200; 250; 150; 220; 300; 310; 165]; % coûts des 7 matières

% Variables : x = [x1 x2 x3 x4 x5 x6 x7]'
% T = x1 + x2 + x3 + x4 + x5 + x6 + x7
% Pour l’instant, on écrit les contraintes directement en linéaire

% -------- Contraintes (A*x <= b) ---------

A = [];
b = [];

% 1. Contraintes sur le % de Carbone : 0.005*T <= C <= 0.0125*T
% C = 0.03x1 + 0.025x2 + 0.012x4 + 0.9x7

% a. Carbone min : 0.03x1 + 0.025x2 + 0.012x4 + 0.9x7 >= 0.005*T
% ⇨ -0.03x1 - 0.025x2 - 0.012x4 - 0.9x7 + 0.005*(x1+x2+...+x7) <= 0
A1 = -[0.03 0.025 0 0.012 0 0 0.9] + 0.005 * ones(1, 7);
b1 = 0;

% b. Carbone max : 0.03x1 + 0.025x2 + 0.012x4 + 0.9x7 <= 0.0125*T
A2 = [0.03 0.025 0 0.012 0 0 0.9] - 0.0125 * ones(1, 7);
b2 = 0;

% 2. Silicon : 0.003*T <= Si <= 0.005*T
% Si = 0.9x5 + 0.96x6

% a. Si min
A3 = -[0 0 0 0 0.9 0.96 0] + 0.003 * ones(1, 7);
b3 = 0;

% b. Si max
A4 = [0 0 0 0 0.9 0.96 0] - 0.005 * ones(1, 7);
b4 = 0;

% 3. Soufre ≤ 0.0005*T
A5 = [0.00013 0.00008 0.00011 0.00002 0.00004 0.00012 0.00002] - 0.0005 * ones(1, 7);
b5 = 0;

% 4. Phosphore ≤ 0.0004*T
A6 = [0.00015 0.00001 0.0005 0.00008 0.00002 0.00003 0.0001] - 0.0004 * ones(1, 7);
b6 = 0;

% 5. Total T ≥ 50 ⇨ -T <= -50
A7 = -ones(1, 7);
b7 = -50;

% Regrouper toutes les contraintes
A = [A1; A2; A3; A4; A5; A6; A7];
b = [b1; b2; b3; b4; b5; b6; b7];

% Bornes inférieures et supérieures
lb = [0; 0; 0; 0; 0; 0; 0];
ub = [40; 30; 60; 50; 20; 30; 25];

% Appel à linprog
options = optimoptions('linprog','Display','iter');
[x, cost, exitflag, output] = linprog(f, A, b, [], [], lb, ub, options);

% Affichage du résultat
disp('Quantité optimale (en tonnes) pour chaque matière :');
disp(array2table(x', 'VariableNames', {'limonite', 'taconite', 'hematite', 'magnetite', 'silicon1', 'silicon2', 'coke'}));

disp(['Coût total minimal : $', num2str(cost)]);
