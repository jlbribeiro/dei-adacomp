function [ X_normalized ] = scalestd( X )
	[n_features, ~] = size(X);

    X_normalized = zeros(size(X));
	for i = 1 : n_features
	    mu = mean(X(i, :));
	    sig = std(X(i, :));
	    X_normalized(i, :) = (X(i, :) - mu) / sig; % scaling each feature to the unit range
	end
end