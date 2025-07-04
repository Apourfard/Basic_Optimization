% Modeling task schedule. Chapitre 1, page 8
% Model creates agenda and graph of tasks

% ==== Project Task Data ====
tasks = {
    1, 'Relocate artwork',       4, [];
    2, 'Site preparation',       2, [1];
    3, 'Excavation',            16, [2];
    4, 'Entrance tunnel',       10, [3];
    5, 'Foundation work',       40, [3];
    6, 'Entrance pavilion',     12, [4];
    7, 'Facade',                 4, [2];
    8, 'Grand staircase',        6, [5];
    9, 'Teaching gallery',       6, [2];
    10, 'Terrace repair',        3, [5, 7];
    11, 'Electrical system',     4, [6, 9, 16, 18];
    12, 'Climate control',       3, [11, 14];
    13, 'Lighting',              5, [11];
    14, 'Windows',               6, [7, 10];
    15, 'Loading zone',          4, [2];
    16, 'Offices',               7, [2];
    17, 'Landscaping',           4, [6, 14, 15];
    18, 'Storage space',         3, [2];
    19, 'Reinstall artwork',     5, [7, 9, 12, 13, 14, 15, 16, 18];
};

n = size(tasks, 1);
G = digraph();
durations = zeros(n, 1);

% ==== Build Graph ====
for i = 1:n
    id = tasks{i,1};
    durations(id) = tasks{i,3};
    preds = tasks{i,4};
    for j = 1:length(preds)
        G = addedge(G, preds(j), id);
    end
end

% ==== Topological Sort ====
order = toposort(G);

% ==== Compute Earliest Start/Finish Times ====
EST = zeros(n,1);  % Earliest Start
EFT = zeros(n,1);  % Earliest Finish

for i = 1:length(order)
    task = order(i);
    preds = predecessors(G, task);
    if isempty(preds)
        EST(task) = 0;
    else
        EST(task) = max(EFT(preds));
    end
    EFT(task) = EST(task) + durations(task);
end

% ==== Project Duration ====
project_duration = max(EFT);

% ==== Prepare Agenda Strings ====
agenda = cell(n,1);
for i = 1:n
    agenda{i} = sprintf('%2d. %-22s  Start: %2d  End: %2d', ...
        i, tasks{i,2}, EST(i), EFT(i));
end

% ==== Create Figure with Two Panels ====
figure('Position', [100, 100, 1000, 600]);
tiledlayout(1,2);

% ==== Left Panel: Task Dependency Graph ====
nexttile(1);
h = plot(G, 'Layout', 'layered');
title(sprintf('📈 Project Task Dependency Graph (Duration: %d weeks)', project_duration));
h.NodeLabel = arrayfun(@num2str, 1:n, 'UniformOutput', false);

% ==== Right Panel: Agenda (Text Display) ====
nexttile(2);
axis off;
title('📋 Project Schedule (Agenda View)', 'FontWeight', 'bold');

% Display agenda as text
text(0, 1, strjoin(agenda, '\n'), 'VerticalAlignment', 'top', 'FontName', 'Courier', 'FontSize', 10);
