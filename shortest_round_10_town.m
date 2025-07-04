% Shortest Round Trip Finder with Random Distances. Chapter 1, page 4
% Set number of cities (including home_town as city 1): n = 10

n = 10;  % You can change this to any number >= 2

% Generate random symmetric distance matrix
base = 100;  % Scaling factor for random distances
A = base * rand(n);                % Random upper triangle
dist = triu(A, 1) + triu(A, 1)';   % Symmetric matrix
dist(1:n+1:end) = 0;               % Set diagonals to 0 (distance to self)

% Display the distance matrix
fprintf('Random Distance Matrix:\n');
disp(dist);

% Generate all possible permutations of cities excluding home_town (city 1)
cities = 2:n;
permsList = perms(cities);

% Initialize variables for shortest route tracking
minDist = Inf;
bestRoute = [];

% Evaluate each permutation
for i = 1:size(permsList, 1)
    route = [1, permsList(i,:), 1];  % Round trip: start/end at home_town
    totalDist = 0;

    % Calculate total distance for the route
    for j = 1:length(route)-1
        totalDist = totalDist + dist(route(j), route(j+1));
    end

    % Update minimum distance and best route if found
    if totalDist < minDist
        minDist = totalDist;
        bestRoute = route;
    end
end

% Display the shortest route and its total distance
fprintf('Shortest Round Trip:\n');
fprintf('Route: ');
fprintf('%d -> ', bestRoute(1:end-1));
fprintf('%d\n', bestRoute(end));
fprintf('Total Distance: %.2f\n', minDist);
