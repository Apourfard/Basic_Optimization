% Modeling Problem 2,section 1.7,page 16.
% This script uses linprog to solve the linear program.
% It will return the optimal number of cars and trucks the factory should produce per day to maximize profit.

% Étape 1 : Définir les variables
% x = nombre de voitures produites par jour
% y = nombre de camions produits par jour

% Étape 2 : Fonction objectif
% Maximiser le profit : Profit = 1300*x + 1500*y

% Étape 3 : Contraintes
% Contraintes de peinture :
%   Chaque voiture utilise 1/500 de la capacité de peinture
%   Chaque camion utilise 1/400 de la capacité de peinture
%   (1/500)*x + (1/400)*y <= 1

% Contraintes d'assemblage :
%   Chaque voiture utilise 1/80 de la capacité d'assemblage
%   Chaque camion utilise 1/65 de la capacité d'assemblage
%   (1/80)*x + (1/65)*y <= 1

% Contraintes de non-négativité :
%   x >= 0, y >= 0

%=========================================================================
% Define max possible numbers based on the constraints
max_cars = 500;   % From painting constraint
max_trucks = 400;

best_profit = 0;
best_x = 0;
best_y = 0;

% Try all combinations of cars (x) and trucks (y)
for x = 0:max_cars
    for y = 0:max_trucks
        
        % Check constraints
        if (x/500 + y/400 <= 1) && (x/80 + y/65 <= 1)
            
            % Compute profit
            profit = 1300 * x + 1500 * y;
            
            % Update best solution if profit is higher
            if profit > best_profit
                best_profit = profit;
                best_x = x;
                best_y = y;
            end
        end
    end
end

% Convert to int64 (as requested)
best_x = int64(best_x);
best_y = int64(best_y);
best_profit = int64(best_profit);

% Display results
fprintf('Optimal number of cars: %d\n', best_x);
fprintf('Optimal number of trucks: %d\n', best_y);
fprintf('Maximum profit: $%d\n', best_profit);
