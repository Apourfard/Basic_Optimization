% Modeling Problem 2,section 1.7,page 16.
% Alternative solution

car_profit = 1300;
truck_profit = 1500;

max_cars = 80;
max_trucks = 65;

best_profit = -inf;
best_cars = 0;
best_trucks = 0;

for cars = 0:max_cars
    for trucks = 0:max_trucks
        painting_time = cars/500 + trucks/400;
        assembly_time = cars/80 + trucks/65;
        
        if painting_time <= 1 && assembly_time <= 1
            profit = car_profit * cars + truck_profit * trucks;
            
            if profit > best_profit
                best_profit = profit;
                best_cars = cars;
                best_trucks = trucks;
            end
        end
    end
end

fprintf('--- Résultat optimal ---\n');
fprintf('Voitures: %d\n', best_cars);
fprintf('Camions: %d\n', best_trucks);
fprintf('Profit max: $%d\n', best_profit);
