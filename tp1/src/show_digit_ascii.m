function [ digit_ascii ] = show_digit_ascii( DIGIT_SIZE, digit_column )
    digit_ascii = char(digit_column_to_matrix(DIGIT_SIZE, digit_column) * ('0' - '.') + '.');
end

