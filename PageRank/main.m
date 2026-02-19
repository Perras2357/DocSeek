%% main.m - Point d'entrée
%clear; clc;

data_dir = fullfile(pwd, 'data'); % dossier data/ au même niveau que main.m
d = 0.85;

% 1) Charger les fichiers
[files, contents] = chargerFichiers(data_dir);

% 2) Construire outLinks + indexMap
[outLinks, indexMap] = construireOutLinks(files, contents);
[outLinks, indexMap] = construireOutLinks(files, contents);
disp(outLinks);
disp(fieldnames(indexMap));


% 3) Matrice de transition
M = construireMatriceTransition(outLinks, numel(files));

% 4) Matrice Google
G = construireMatriceGoogle(M, d);

% 5) PageRank
r = calculerPageRank(G);  % version eig ou power iteration, au choix



% 7) Recherche + tri
query = input('Mot recherché (vide pour ignorer) : ', 's');
if ~isempty(strtrim(query))
    ranked = rechercherEtClasser(files, contents, r, query);
    if isempty(ranked)
        disp("Aucun fichier ne contient ce mot.");
    else
        disp("=== Résultats (filtrés + triés par PageRank) ===");
        for k = 1:numel(ranked)
            i = ranked(k);
            fprintf('%d) %s  score=%.6f\n', k, files{i}, r(i));
        end
    end
end

