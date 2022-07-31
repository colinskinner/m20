function [ xs ] = splitPts( x )
%   splitPts Subdivides an array
%       returns array with twice the values, with
%       averages in between original numbers
    xs = zeros(1,length(x)*2);
    for i=1:(length(xs)-1)
%         disp(i)
        if mod(i,2) ~= 0
            xs(i) = x((i+1)/2);
        else
            xs(i) = (x(i/2)+x(1+i/2))/2;
        end
    end
    xs(end) = (x(1)+x(end))/2;
end

