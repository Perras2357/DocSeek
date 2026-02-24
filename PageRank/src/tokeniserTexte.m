function tokens = tokeniserTexte(txt, stopWords)
    % tokeniserTexte - normalise et découpe un texte en mots (tokens)
    %
    % Règles :
    % - minuscule
    % - remplace toute ponctuation et caractères non-alphanumérique par un espace
    % - supprimer les tokens vides
    %

    if isempty(txt)
        tokens = {};
        return;
    end

    % nombre arguments de la fonction
    if nargin < 2 || isempty(stopWords)
        stopWords = {};
    end

    txt = lower(txt);

    % Remplace tout ce qui n'est pas [a-z0-9] par des espaces.
    txt = regexprep(txt, '[^a-z0-9]+', ' ');

    % Découpe en tokens
    tokens = strsplit(strtrim(txt));

    % enlever les vides
    tokens = tokens(~cellfun('isempty', tokens));

    % Filtre les stop words
    if ~isempty(stopWords)
        tokens = tokens(~ismember(tokens, stopWords));
    end
end

