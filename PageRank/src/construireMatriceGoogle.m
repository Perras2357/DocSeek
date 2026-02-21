function G = construireMatriceGoogle(M, d)
    % construireMatriceGoogle
    % G = d*M + (1-d)*(1/N)*11^T

    N = size(M,1);
    G = d * M + (1 - d) * (ones(N,N) / N);
end

