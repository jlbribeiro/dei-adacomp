function [ X_normalized ] = dataset_normalize_input( X )
    % X_normalized = zeros(size(X));
    % for i = 1 : size(X, 1)
    %     X_normalized(i, :) = X(i, :) / max(X(i, :));
    % end

    X_normalized = scalestd(X);
end

