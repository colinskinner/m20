%% Skinner_505795313_HW_01_main.m
% Colin Skinner
% UID: 505975313
% Problem 1: Averages numbers in a vector
% Problem 2: Runge-Kutta Radioactivity

%% Clearing cache and switch statement
clear all
close all
clc

problem = input("Which problem to test?\n");
switch(problem)
    case 1
    %% The Split-and-Average Problem

    x = [0, 0, 1, 1];
    y = [0, 1, 0, 1];

    hold on
    plot(x, y, 'b.', 'MarkerSize', 30) % Plots initial values in array

    error = 1; % Initial error is above the stop condition value
    count = 0; % Iteration counter

    a = 1; % Sets weights for easy testing
    b = 2;
    c = 1;

    

    while error > 1*10^(-3) && count < 8 % If error is less than 1e-3 OR iterations is more than 100 
        % (prevents infinite loop if convergence unattainable)
        
        % Calculates split and average points for the X and Y axes
        x = splitPts(x); 
        xa = averagePts(x,[a,b,c]);
        y = splitPts(y);
        ya = averagePts(y,[a,b,c]);

        error = max(sqrt((x-xa).^2+(y-ya).^2)); % Compares both values to determine the maximum error
        
        x = xa; % Iterates variables for next loop
        y = ya;
        count = count+1;
    end
    
    plot(xa, ya, 'r.', 'MarkerSize', 30) % Plots new graph
%     fprintf("Iterations: %i",count) % Displays number of iterations
    hold off


    

    case 2
    % Runge-Kutta Radioactivity
    
    y0 = 1; % Initial condition
    dt = [1,0.1,0.01]; % Array of time slices

    fprintf("   dt       RK1        RK2        RK4\n")
    


    for i=1:length(dt)
        t = 0:dt(i):15; % Time array with slices that are each time slice long
        exact = y0*exp(-log(2)/2.45*t); % exact function results at each point in time

            
        y1 = zeros(1,15/dt(i)); % Preallocates arrays to save space on computer
        y2 = zeros(1,15/dt(i));
        y4 = zeros(1,15/dt(i));
        
        y1(1) = y0; % Sets initial conditions
        y2(1) = y0;
        y4(1) = y0;
        
        
        % Loops over all values in the time array after t=0 (one less than its length)
        for k=1:length(t)-1
            y1(k+1) = advanceRK(y1(k),dt(i),1); % Calls each RK method and puts result into respective array
            y2(k+1) = advanceRK(y2(k),dt(i),2);
            y4(k+1) = advanceRK(y4(k),dt(i),4);
        end

        % Prints the average errors for each RK method
        fprintf("%.2f:  %.2d   %.2d   %.2d\n",dt(i),mean(abs(y1 - exact)),mean(abs(y2 - exact)),mean(abs(y4 - exact)))

        figure;
        hold on
        plot(t,exact,'g','LineWidth',2) % Plotting exact function vs. all 3 RK methods
        plot(t,y1,'b','LineWidth',2)
        plot(t,y2,'r','LineWidth',2)
        plot(t,y4,'m','LineWidth',2)
        xlabel("Time (s)")
        ylabel("Amount of Carbon-15")
        title(sprintf('Timesteps of RK functions with dt = %.2f', dt(i)), 'FontSize', 18)
        legend('Exact Solution', 'RK1', 'RK2', 'RK4')
        hold off
        
        % Calculates logarithmic array of error values and plots them
%         g = log10(abs(y1 - exact));
%         h = log10(abs(y2 - exact));
%         k = log10(abs(y4 - exact));
%         figure;
%         hold on
%         plot(t,g,'b','LineWidth',3)
%         plot(t,h,'r','LineWidth',3)
%         plot(t,k,'m','LineWidth',3)
%         title(sprintf('FE and RK Error with dt = %.2f',dt(i)),'FontSize',24) 
%         legend('RK1', 'RK2', 'RK4')
%         grid on


    end

end
