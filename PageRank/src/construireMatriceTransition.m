function M = construireMatriceTransition(outLinks, N)
    % construireMatriceTransition
    % M(i,j) = P(aller vers i | on est sur j)   => colonnes somment à 1

    M = zeros(N,N);

    for j = 1:N
        dest = outLinks{j};
        k = numel(dest);

        if k == 0
            % dangling node -> distribution uniforme
            M(:,j) = 1/N;
        else
            M(dest, j) = 1/k;
        end
    end

    % Check optionnel (débogage)
    colSums = sum(M, 1);
    if max(abs(colSums - 1)) > 1e-12
        warning("M_transition: certaines colonnes ne somment pas à 1.");
    end
end

