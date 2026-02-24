%% Importation du fichier txt

%Repertoire où se trouve les fichiers
currentFile = mfilename('fullpath');
[projectRoot,~,~] = fileparts(currentFile);
data_dir = fullfile(projectRoot, 'data');

d = 0.85; % Damping google

%Recherche des fichiers ayant pour extension .txt
pattern = fullfile(data_dir,"*.txt");
listeStruct = dir(pattern);

%Extraction du nom des fichiers
files = {listeStruct.name};
N = length(files);

if N == 0
  error('Aucun fichier .txt trouvé dans le repertoire : %s', data_dir);
end

%fprintf('%d fichiers trouvés pour traitement.\n', N);

% Initialisation du dictionnaire
indexMap = struct();

for i = 1:N
    % Nom du fichier (ex: "file1.txt")
    fname = files{i};

    % Normalisation pour en faire un champ valide
    % "file1.txt" -> "file1_txt"
    key = strrep(fname, '.txt', '');

    % Stockage de la correspondance
    indexMap.(key) = i;
end

% structure de tableaux variant
outLinks = cell(N,1);

%on construit le dictionnaire fichier1(pointeur) -> fichier2(pointé)
for i = 1:N

    %on charge tous les fichiers d'un repertoire
    contenu = fileread(fullfile(data_dir, files{i}));

     %on récupère les noms des fichiers pointés
    raw = regexp(contenu, '\[pointeur\]\(([^)]+)\)', 'tokens');
    if isempty(raw)
        outLinks{i} = [];
        continue;
    end

    targets = [raw{:}];             %liste des fichiers pointés
    idx = [];

    %on parcours le contenu de la liste de fichiers
    for k = 1:numel(targets)
        t = strtrim(targets{k});  % on enlève espaces

        % on vérifie si chaque fichier pointé existe dans le tableau d'indexation
        if isfield(indexMap, t)
            idx(end+1) = indexMap.(t);
        end
    end

    outLinks{i} = unique(idx);    %on ne considère pas deux fois le même fichier pointé
end


% Construction de la matrice de transition
% M_transition(i,j) : probabilité d’aller vers le fichier i quand on est sur j
M_transition = zeros(N,N);

for j = 1:N
  %index des fichiers pointés par le fichier j
  index_dest = outLinks{j};

  %nombre de liens sortants du fichier j
  k = numel(index_dest);

  if k == 0             % cas où le fichier ne pointe sur aucun autre
    % On considère que le fichier j pointe sur tous les fichiers
    M_transition(:,j) = 1/N;
  else
    M_transition(index_dest,j) = 1/k; %j pointe sur k fichier
  end
end

% construction de la matrice de google
M_google = (d * M_transition) + ((1-d)/N);

%construction du vecteur propre
[E,D] = eig(M_google);

% indice de la valeur propre ≈ 1
lambda = diag(D);
[~, idx] = min(abs(lambda - 1));
r = E(:, idx);
r = r / sum(r);
[maxScore, bestIndex] = max(r);

files(bestIndex);

% 1. Trier les scores (r) par ordre décroissant
% sortedScores contiendra les valeurs, sortedIdx contiendra l'ordre des indices
[sortedScores, sortedIdx] = sort(r, 'descend');

% 2. Affichage des résultats en console
fprintf('\n======================================\n');
fprintf('   CLASSEMENT PAGERANK (Damping = %.2f)\n', d);
fprintf('======================================\n');

for i = 1:N
    % On récupère le nom du fichier correspondant à l'indice trié
    fileName = files{sortedIdx(i)};
    score = sortedScores(i);

    % Affichage formaté : Rang. Nom du fichier : Score (en %)
    fprintf('%d. %-15s : %.2f%%\n', i, fileName, score * 100);
end
fprintf('======================================\n');
