function ranked = rechercherEtClasser(files, contents, r, query)
    % rechercherEtClasser - filtre par mot, puis trie par PageRank

    N = numel(files);
    q = lower(strtrim(query));

    matched = false(N,1);
    for i = 1:N
        matched(i) = ~isempty(strfind(lower(contents{i}), q)); %#ok<STREMP>
    end

    candidates = find(matched);
    if isempty(candidates)
        ranked = [];
        return;
    end

    [~, ord] = sort(r(candidates), 'descend');
    ranked = candidates(ord);
end

