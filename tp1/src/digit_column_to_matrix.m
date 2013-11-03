function [ digit_matrix ] = digit_column_to_matrix( digit_size, digit_column )
% DIGIT_COLUMN_TO_MATRIX Convert a digit_column (as return by mpaper) into a
% height x width human-readable matrix of a digit.

    digit_matrix = zeros(digit_size.height, digit_size.width);
    for i = 1 : digit_size.height
        for j = 1 : digit_size.width
            digit_matrix(i, j) = digit_column((j - 1) * digit_size.width + i, 1);
        end
    end
    
end

