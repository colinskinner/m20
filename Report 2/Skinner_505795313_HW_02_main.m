%% Skinner_505795313_HW_01_main.m
% Colin Skinner
% UID: 505975313
% Problem 1 outputs results from a three species example of the Lotka–Volterra equations
% Problem 2 outputs the average number of coins one can expect to receive in change after a cash transaction

%% Clearing cache
clc
clear all
close all
clc

problem = input("Which problem to test?");
switch(problem)
    case 1
        %% The Three Species Problem
      
        % Commented out because default code has automatic input
%         x_k = input("Enter nonzero integer for the population/area of X: "); % User input for x_0 initial condition
%         y_k = input("Enter nonzero integer for the population/area of Y: "); % User input for y_0 initial condition
%         z_k = input("Enter nonzero integer for the population/area of Z: "); % User input for z_0 initial condition

        % Sets initial values for the population/area of X,Y,Z
        x_k = 4.79; 
        y_k = 2.49;
        z_k = 1.50;
        
        % Commented out because default code has automatic input
%         dt = input("Enter number for dt: "); 
%         tf = input("Enter number for tf: "); 

        dt = 0.005; % Width of each time slice (default)
        tf = 12.000; % Final time when code stops (default)

        fprintf("Time\tX\tY\tZ\n") % Prints header text 

        tic % Tic for timing the code
        for t=0:dt:tf % For loop from 0 to final time; iterates by the desired time slices

            if mod(t,0.5)==0 % Displays populations every half second
                fprintf("%.1f\t%5.2f\t%5.2f\t%5.2f\n",t,x_k,y_k,z_k) % Prints populations and current time
            end

            % Calculates k+1 (next iteration) values of population/area with discretized formulas
          
            x_k1 = x_k*(1 + dt*(0.75*(1-x_k/20) - 1.5*y_k - .5*z_k));
            y_k1 = y_k*(1 + dt*((1-y_k/25) - .75*x_k - 1.25*z_k));
            z_k1 = z_k*(1 + dt*(1.5*(1-z_k/30) - x_k - y_k));
            
            % Sets current values to next values to prepare for next time
            x_k = x_k1;
            y_k = y_k1;
            z_k = z_k1;
        end

        % Prints total time taken to run the code
        timeTaken = toc;
        fprintf("Total time in loop: %.4f seconds",timeTaken)

    case 2
        %% Problem 2: The Pocket Change Problem
        
        sum = 0; % Sum of all coins across all iterations

        for i=0:1:99
            amtOwed = i;
            q = floor(amtOwed/25);
            amtOwed = amtOwed - 25*q;
            d = floor(amtOwed/10);
            amtOwed = amtOwed - 10*d;
            n = floor(amtOwed/5);
            amtOwed = amtOwed - 5*n;
            p = amtOwed;
            sum = sum + q + d + n + p;
        end
        
        fprintf("Average Number of Coins = %.2f",sum/100);




        
    
    otherwise
        error("Invalid problem number")
    
end % ends switch
