function [ranked, matchCount, bestMatchedTokens] = rechercherEtClasser(files, contents, r, query)
    % - pertinence = nb de mots distincts de la requête trouvés
    % - tri : (1) pertinence desc, (2) PageRank desc
    %

    N = numel(files);

    % Tokeniser la requête
    qTokens = unique(tokeniserTexte(query));
    if isempty(qTokens)
        ranked = [];
        matchCount = zeros(N,1);
        bestMatchedTokens = {};
        return;
    end

    matchCount = zeros(N,1);

    % Calcul du score pour chaque doc
    for i = 1:N
        docTokens = unique(tokeniserTexte(contents{i}));
        present = ismember(qTokens, docTokens);
        matchCount(i) = sum(present);
    end

    % Filtrer
    candidates = find(matchCount > 0);
    if isempty(candidates)
        ranked = [];
        bestMatchedTokens = {};
        return;
    end

    % Trier (score puis PageRank)
    keys = [-matchCount(candidates), -r(candidates)];
    [~, ord] = sortrows(keys);
    ranked = candidates(ord);

    % Extraire les mots matchés dans le meilleur doc (ranked(1))
    topIdx = ranked(1);
    topTokens = unique(tokeniserTexte(contents{topIdx}));
    presentTop = ismember(qTokens, topTokens);
    bestMatchedTokens = qTokens(presentTop);
end

