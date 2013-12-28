function [ error ] = quadratic_error( varargin )
%QUADRATIC_ERROR Quadratic error calculation.
    %
    % Synopsis:
    %   [error] = quadratic_error(expected_values, real_values)
    %   [error] = quadratic_error(values)
    %
    % Description:
    %   This function calculates the quadratic error given a single 
    %   vector or two vectors.
    %
    % Output:
    %   error [1x1] The computed error.
    %
    % Example
    %   expected_values = [5 6 7 8 9]; real_values = [5 6 8 9 9];
    %   [error] = quadratic_error(expected_values, real_values);
    
    if nargin==1
        vector1 = varargin{1};
        vector2 = varargin{1};
        vector1(1) = [];
        vector2(end) = [];
    elseif nargin>1
        vector1 = varargin{1};
        vector2 = varargin{2};
    end
    
    error = sum( (vector1 - vector2).^2 );
end

