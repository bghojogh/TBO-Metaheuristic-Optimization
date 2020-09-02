function y = Sphere(x)
    %
    % Griewank function
    % Matlab Code by A. Hedar (Sep. 29, 2005).
    % The number of variables n should be adjusted below.
    % The default value of n =2.
    %
    n = 3;   % n=2 means that X and Y
    s = 0;
    for j = 1:n; s = s+x(j)^2; end
    y = s;
end