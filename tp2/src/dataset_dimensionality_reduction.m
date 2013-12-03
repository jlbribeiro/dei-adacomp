function [ X_reduced ] = dataset_dimensionality_reduction( varargin )
    X = varargin{1};

    [~, scores, latent] = princomp(X);
    cumpercs = cumsum(latent) ./ sum(latent);

    if nargin == 2
        n_features = varargin{2};
    else
        % Use the features that have 95% of the total variance
        for n_features = 1 : length(cumpercs)
            if cumpercs(n_features) >= 0.95
                break;
            end
        end
    end
    
    X_reduced = scores(:, 1 : n_features);
end