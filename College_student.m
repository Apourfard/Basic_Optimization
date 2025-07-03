% College student, Page 2
% Define the distance matrix
% Order of towns: Portland, Brunswick, Lewiston, Waterville
dist = [
    0  26  34  78;
   26   0  18  52;
   34  18   0  51;
   78  52  51   0
];

% Indices for towns (excluding Portland which is fixed start/end)
towns = [2, 3, 4];  % Brunswick, Lewiston, Waterville

% Generate all permutations of the 3 towns
permsList = perms(towns);

% Initialize minimum distance and best route
minDist = Inf;
bestRoute = [];

% Evaluate each permutation
for i = 1:size(permsList, 1)
    route = [1, permsList(i,:), 1];  % Full route: start and end at Portland
    totalDist = 0;
    
    % Calculate total distance for this route
    for j = 1:length(route)-1
        totalDist = totalDist + dist(route(j), route(j+1));
    end
    
    % Check if this is the shortest route so far
    if totalDist < minDist
        minDist = totalDist;
        bestRoute = route;
    end
end

% Display results
townNames = {'Portland', 'Brunswick', 'Lewiston', 'Waterville'};
fprintf('Shortest route: ');
for i = 1:length(bestRoute)
    fprintf('%s', townNames{bestRoute(i)});
    if i < length(bestRoute)
        fprintf(' -> ');
    else
        fprintf('\n');
    end
end
fprintf('Total distance: %d miles\n', minDist);