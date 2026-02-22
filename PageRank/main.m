%% main.m - Point d'entrée
clear; clc;

addpath('src'); % Ajoute le dossier contenant les fonctions

% récupération de l'emplacement du main et fonction récupère le repertoire data
currentFile = mfilename('fullpath');
[projectRoot,~,~] = fileparts(currentFile);
data_dir = fullfile(projectRoot, 'data');

d = 0.85;

% 1) Charger les fichiers
[files, contents] = chargerFichiers(data_dir);

% 2) Construire outLinks + indexMap
[outLinks, indexMap] = construireOutLinks(files, contents);


% 3) Matrice de transition
M = construireMatriceTransition(outLinks, numel(files));

% 4) Matrice Google
G = construireMatriceGoogle(M, d);

% 5) PageRank
r = calculerPageRank(G);

% 6) Recherche + tri
query = input('Mot recherché (vide pour ignorer) : ', 's');

if ~isempty(strtrim(query))
    [ranked, matchCount, bestMatchedTokens] = rechercherEtClasser(files, contents, r, query);

    if isempty(ranked)
        disp("Aucun fichier ne correspond à cette requête.");
    else
        qTokens = unique(tokeniserTexte(query));
        disp("=== Fichiers contenant les mots recherchés classés ===");
        for k = 1:numel(ranked)
            i = ranked(k);

            % tokens du doc
            docTokens = unique(tokeniserTexte(contents{i}));

            % mots de la requête présents dans ce doc
            present = ismember(qTokens, docTokens);
            matchedTokensDoc = qTokens(present);

            fprintf('file -> %d) %s \n', k, files{i});

            fragmant = extraireFragmant(contents{i}, matchedTokensDoc, 17);
            disp(fragmant);
            disp(" "); % ligne vide pour lisibilité
        end

    end
end

