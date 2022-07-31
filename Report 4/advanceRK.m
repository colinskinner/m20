function [ y ] = advanceRK( y, dt, method)
%   advanceRK Advances Runge-Kutta Methods by orders
%       Initial conditions: y = input value, dt = time width, method = RK order
%       Outputs the result of respective RK method
%       Throws error if inappropriate method number is called
    if method == 1
        c1 = dt*(-log(2)/2.45*y);
        y = y + c1;
        
    elseif method == 2
        c1 = dt*(-log(2)/2.45*y);
        c2 = dt*(-log(2)/2.45*(y+c1/2));
        y = y + c2;
    elseif method == 4
        c1 = dt*(-log(2)/2.45*y);
        c2 = dt*(-log(2)/2.45*(y+c1/2));
        c3 = dt*(-log(2)/2.45*(y+c2/2));
        c4 = dt*(-log(2)/2.45*(y+c3));
        y = y + c1/6 + c2/3 + c3/3 + c4/6;
    else
        disp("%i is not within the appropriate methods",method)
        
    end
end