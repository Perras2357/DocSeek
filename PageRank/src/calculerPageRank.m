function r = calculerPageRank(G)
    % calculerPageRank - calcule le vecteur stationnaire via eig
    % Attention : O(N^3), ok pour petits N

    [E, D] = eig(G);
    lambda = diag(D);

    % vecteur propre associé à lambda ~ 1
    [~, idx] = min(abs(lambda - 1));

    r = E(:, idx);
    r = real(r);        % nettoie bruit imaginaire

    if sum(r) < 0
        r = -r;         % corrige signe global
    end

    r(r < 0) = 0;       % sécurité
    r = r / sum(r);     % normalise pour somme = 1
end

