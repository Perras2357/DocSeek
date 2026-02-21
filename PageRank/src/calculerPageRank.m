function r = calculerPageRank(G)
    % calculerPageRank - calcule le vecteur stationnaire via eig

    [E, D] = eig(G);
    lambda = diag(D);

    % vecteur propre associé à lambda ~ 1
    [~, idx] = min(abs(lambda - 1));

    r = E(:, idx);
    r = real(r);        % nettoie bruit

    if sum(r) < 0
        r = -r;         % corrige signe
    end

    r(r < 0) = 0;
    r = r / sum(r);     % normalise pour somme = 1
end

