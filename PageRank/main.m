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
r = calculerPageRank(G);  % version eig ou power iteration, au choix

% 6) Chargement des mots indésirables (stop words)
%    Le fichier stopwords.txt doit se trouver à la racine du projet.
stopWordsFile = fullfile(projectRoot, 'stopwords.txt');
stopWords = chargerStopWords(stopWordsFile);

% 7) Recherche + tri
query = input('Mot recherché (vide pour ignorer) : ', 's');

if ~isempty(strtrim(query))
    [ranked, matchCount, bestMatchedTokens] = rechercherEtClasser(files, contents, r, query, stopWords);

    if isempty(ranked)
        disp("Aucun fichier ne correspond à cette requête.");
    else
        qTokens = unique(tokeniserTexte(query, stopWords));
        disp("=== Résultats (triés par nb mots matchés puis PageRank) ===");
        for k = 1:numel(ranked)
            i = ranked(k);

            % tokens du doc
            docTokens = unique(tokeniserTexte(contents{i}, stopWords));

            % mots de la requête présents dans ce doc
            present = ismember(qTokens, docTokens);
            matchedTokensDoc = qTokens(present);

            fprintf('%d) %s\n', k, files{i});

            fragmant = extraireFragmant(contents{i}, matchedTokensDoc, 17);
            disp(fragmant);
            disp(" "); % ligne vide pour lisibilité
        end

    end
end

