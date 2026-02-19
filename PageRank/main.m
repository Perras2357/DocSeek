data_dir = "../data";
[files, contents, indexMap, N] = chargerFichiers(data_dir);

assert(N > 0);
assert(numel(files) == N);
assert(numel(contents) == N);

% Chaque contenu doit être une chaîne non vide (au moins existante)
for i = 1:N
    assert(ischar(contents{i}) || isstring(contents{i}));
end

