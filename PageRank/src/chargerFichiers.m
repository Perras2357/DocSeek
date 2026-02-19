function [files, contents, indexMap, N] = chargerFichiers(data_dir)
    % Liste des fichiers .txt
    listeStruct = dir(fullfile(data_dir, "*.txt"));
    files = {listeStruct.name};
    N = numel(files);

    if N == 0
        error('Aucun fichier .txt trouvé dans : %s', data_dir);
    end

    % Pour des tests reproductibles : ordre stable
    files = sort(files);

    % Lire le contenu de chaque fichier
    contents = cell(N, 1);
    for i = 1:N
        path = fullfile(data_dir, files{i});
        contents{i} = fileread(path);
    end

    % Construire le mapping "nom sans extension" -> index
    indexMap = struct();
    for i = 1:N
        key = strrep(files{i}, ".txt", "");  % ex: "file1"
        indexMap.(key) = i;
    end
end

