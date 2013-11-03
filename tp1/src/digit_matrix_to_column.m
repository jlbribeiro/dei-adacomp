function [ digit_column ] = digit_matrix_to_column( digit_size, digit_matrix )
% DIGIT_MATRIX_TO_COLUMN Convert a digit_matrix (the human-readable format)
% into a digit_column (as returned by mpaper).

    digit_column = zeros(digit_size.height * digit_size.width, 1);
    for i = 1 : digit_size.height
        for j = 1 : digit_size.width
            digit_column((j - 1) * digit_size.width + i, 1) = digit_matrix(i, j);
        end
    end
    
end

