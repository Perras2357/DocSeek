function [outLinks, indexMap] = construireOutLinks(files, contents)
    % construireOutLinks - extrait les liens [pointeur](fileX)
    %
    N = numel(files);

    % 1) indexMap : "file2" -> 2
    indexMap = struct();
    for i = 1:N
        key = strrep(files{i}, '.txt', '');

        indexMap.(key) = i;
    end

    % 2) outLinks
    outLinks = cell(N,1);

    for i = 1:N
        contenu = contents{i};

        raw = regexp(contenu, '\[pointeur\]\(([^)]+)\)', 'tokens');

        if isempty(raw)
            outLinks{i} = [];
            continue;
        end

        idx = [];
        for k = 1:numel(raw)
            t = strtrim(raw{k}{1}); %token unique

            % si quelqu'un écrit file2.txt dans le lien, on retire .txt
            if endsWith(t, ".txt")
                t = strrep(t, ".txt", "");
            end

            if isfield(indexMap, t)
                idx(end+1) = indexMap.(t);
            end
        end

        outLinks{i} = unique(idx);
    end
end

