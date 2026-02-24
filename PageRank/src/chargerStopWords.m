function stopWords = chargerStopWords(filePath)
    % chargerStopWords - charge un fichier de mots indésirables (stop words)

    stopWords = {};

    if ~isfile(filePath)
        % Pas d'erreur bloquante : on continue sans filtrage
        disp('chargerStopWords: fichier introuvable');
        return;
    end

    raw = fileread(filePath);

    % Découpe ligne par ligne
    lignes = strsplit(raw, {'\n', '\r\n'});

    stopWords = {};
    for i = 1:numel(lignes)
        mot = strtrim(lower(lignes{i}));

        % Ignore les lignes vides
        if isempty(mot)
            continue;
        end

        stopWords{end+1} = mot;
    end

    stopWords = unique(stopWords);  % dédoublonne
end

