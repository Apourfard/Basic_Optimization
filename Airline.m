% Airline Assignment Problem with data from Table 1.4 in Chapter 1, page 10

% Passenger matrix A (rows = origins, cols = destinations)
A = [
    16 12  6  8  3 10;   % Portland
    35 27 19 22 11 30;   % Bangor
    15  9 10 17  6 13;   % Manchester
    16  5  0 13  2 12;   % Hartford
    12 12  7 21  0 15;   % Providence
     2  0  0  5  8  9    % Hyannis
];

% Convert to cost matrix for minimization (negate A)
C = -A;

% Flatten cost matrix into vector
f = C(:);

n = 6;
N = n * n;

intcon = 1:N;
lb = zeros(N,1);
ub = ones(N,1);

% Constraint 1: each origin assigned to exactly one destination
Aeq1 = kron(eye(n), ones(1, n));
beq1 = ones(n,1);

% Constraint 2: each destination served by exactly one origin
Aeq2 = kron(ones(1, n), eye(n));
beq2 = ones(n,1);

Aeq = [Aeq1; Aeq2];
beq = [beq1; beq2];

% Solve integer linear program
[x_opt, fval, exitflag] = intlinprog(f, intcon, [], [], Aeq, beq, lb, ub);

% Reshape solution vector to matrix
X = reshape(x_opt, n, n);

% Calculate number of passengers who stay on original plane
passengers_on_same_plane = sum(sum(A .* X));

% Total passengers arriving
total_passengers = sum(A, 'all');

% Passengers who must switch planes
passengers_switch = total_passengers - passengers_on_same_plane;

% Display with city names
origins = {'Portland', 'Bangor', 'Manchester', 'Hartford', 'Providence', 'Hyannis'};
destinations = {'New York', 'Philadelphia', 'Detroit', 'Chicago', 'Atlanta', 'Washington D.C.'};

disp('Optimal assignment matrix (1 = assigned flight from origin to destination):');
disp(array2table(X, 'VariableNames', destinations, 'RowNames', origins));

fprintf('\nMaximum number of passengers who do NOT switch planes: %d\n', passengers_on_same_plane);
fprintf('Number of passengers who must switch planes: %d\n', passengers_switch);
fprintf('Total passengers: %d\n', total_passengers);
