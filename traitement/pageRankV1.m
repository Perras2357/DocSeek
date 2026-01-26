%% Importation du fichier txt

%Repertoire où se trouve les fichiers
data_dir = "../data/";
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

txt = cell(1, N);
for i = 1:N
  txt{i} = fileread(fullfile(data_dir, files{i}));
end

txt

