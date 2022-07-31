function [ xa ] = averagePts( xs, w )
%   averagePts Averages point and two nearest neighbors
%       Uses weights specified in w
    if sum(w) == 0
        error("Sum of weights cannot be 0")
    end
    w = w./sum(w);

    xa = zeros(1,length(xs));
    xa(1) = w(1)*xs(end)+w(2)*xs(1)+w(3)*xs(2);
    xa(end) = w(1)*xs(end-1)+w(2)*xs(end)+w(3)*xs(1);

    for i=2:length(xs)-1
        xa(i) = w(1)*xs(i-1)+w(2)*xs(i)+w(3)*xs(i+1);
    end

end