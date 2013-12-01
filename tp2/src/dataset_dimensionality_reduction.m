function [ X_reduced ] = dataset_dimensionality_reduction( X )
    [~, scores, latent] = princomp(X);
    cumpercs = cumsum(latent) ./ sum(latent);

    % Use the features that have 95% of the total variance
    for i = 1 : length(cumpercs)
        if cumpercs(i) >= 0.95
            break;
        end
    end
    
    X_reduced = scores(:, 1 : i);
end