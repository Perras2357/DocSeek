function fragmant = extraireFragmant(contenu, highlightTokens, windowSize)
    % extrait un fagmant de mots autour de la meilleure zone
    % contenant le plus de mots de la requête.
    %
    % on cherche la fenêtre (en caractères) qui maximise le nb de mots
    %   de la requête présents dans cette fenêtre
    % on met en évidence les mots trouvés avec **mot**
    %


    % si la requête est vide ou composée uniquement d’espaces en ne return rien
    if isempty(contenu) || isempty(strtrim(highlightTokens))
        fragmant = "";
        return;
    end

   anchor = highlightTokens{1}; % ancre = 1er mot matché

    lowerText = lower(contenu);
    lowerAnchor = lower(anchor);
    pos = strfind(lowerText, lowerAnchor);

    if isempty(pos)
        startIdx = 1;
        endIdx = min(length(contenu), 2*windowSize);
    else
        p = pos(1);
        startIdx = max(1, p - windowSize);
        endIdx = min(length(contenu), p + length(anchor) + windowSize);
    end

    fragmant = contenu(startIdx:endIdx);

    if startIdx > 1
        fragmant = ["..." fragmant];
    end
    if endIdx < length(contenu)
        fragmant = [fragmant "..."];
    end

    % surlignage de tous les tokens
    for i = 1:numel(highlightTokens)
        w = highlightTokens{i};
        if isempty(w), continue; end

        pattern = ['(?i)\b' regexptranslate('escape', w) '\b'];
        fragmant = regexprep(fragmant, pattern, '**$0**');
    end
end

