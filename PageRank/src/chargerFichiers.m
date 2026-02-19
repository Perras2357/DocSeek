function [files, contents] = chargerFichiers(data_dir)
    % chargerFichiers - liste les .txt et charge leur contenu
    %
    % OUTPUT:
    %   files    : cell array {"file1.txt","file2.txt",...}
    %   contents : cell array contenu texte correspondant

    pattern = fullfile(data_dir, "*.txt");
    listeStruct = dir(pattern);

    files = {listeStruct.name};
    N = numel(files);

    if N == 0
        error('Aucun fichier .txt trouvé dans : %s', data_dir);
    end

    contents = cell(N,1);
    for i = 1:N
        path = fullfile(data_dir, files{i});
        contents{i} = fileread(path);
    end
end

