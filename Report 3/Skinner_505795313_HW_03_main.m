%% Skinner_505795313_HW_01_main.m
% Colin Skinner
% UID: 505975313
% Problem 1 outputs anglular position, angular velocity, and acceleration of a pendulum over time
% Problem 2 outputs statistics about the codons within a length of DNA

%% Clearing cache and switch statement
clc
clear all
close all
clc

problem = input("Which problem to test?");
switch(problem)
    case 1
    %% The Pendulum Physics Problem

    dt = 0.005;
    tf = 20;
    iter = tf/dt;
    theta = zeros(1,iter);
    omega = zeros(1,iter);
    alpha = zeros(1,iter);
    E = zeros(1,iter);
    time = zeros(1,iter);
    
    theta(1) = pi/3;
    omega(1) = 0;
    alpha(1) = 0;
    %     disp(length(time))
    L = 1;
    g = 9.81;
    % Explicit %------------------------------------------------
    for k=1:1:(iter) % For loop from 0 to final time; iterates by the desired time slices
            omega(k+1) = omega(k) + dt*(-g/L*sin(theta(k)));
            theta(k+1) = theta(k) + dt*omega(k);
            alpha(k+1) = -g/L*sin(theta(k));
    
            E(k+1) = g*L*(1-cos(theta(k+1))) + .5*(L*omega(k+1))^2;
            time(k + 1) = dt * k;
    
    end
    figure;
    set(gcf,'Position',[75 75 1275 750])
    
    %------------------------------------------------
    subplot(2,2,1)
    hold on
    plot(time, theta,'r', 'LineWidth', 1)
    plot(time, omega, 'b', 'LineWidth', 1)
    plot(time, alpha,'g', 'LineWidth', 1);
    
    xlabel('Time(s)')
    ylabel('Radians')
    title('Angular Position, Velocity and Acceleration over Time (Explicit)')
    legend('Angular Position (rad)', 'Angular Velocity (rad/s)', 'Angular Acceleration (rad/s^2)');
    hold off
    %------------------------------------------------
    subplot(2,2,2)
    % figure;
    plot(time, E, 'k', 'LineWidth', 1);
    xlabel('Time(s)')
    ylabel('Energy (J)')
    title('Energy over Time (Explicit)')
    legend('Energy (J)')
    
    % Semi-implicit %------------------------------------------------
    for k=1:1:(iter) % For loop from 0 to final time; iterates by the desired time slices
            omega(k+1) = omega(k) + dt*(-g/L*sin(theta(k)));
            theta(k+1) = theta(k) + dt*(omega(k+1));
            alpha(k+1) = -g/L*sin(theta(k));
    
            E(k+1) = g*L*(1-cos(theta(k+1))) + .5*(L*omega(k+1))^2;
    
    end
    
    %------------------------------------------------
    % figure;
    subplot(2,2,3)
    hold on
    
    plot(time, theta,'r', 'LineWidth', 1)
    plot(time, omega, 'b', 'LineWidth', 1)
    plot(time, alpha,'g', 'LineWidth', 1);
    
    xlabel('Time(s)')
    ylabel('Radians')
    title('Angular Position, Velocity and Acceleration over Time (Semi-implicit)')
    legend('Angular Position (rad)', 'Angular Velocity (rad/s)', 'Angular Acceleration (rad/s^2)');
    hold off
    %------------------------------------------------
    % figure;
    subplot(2,2,4)
    plot(time, E, 'k', 'LineWidth', 1);
    xlabel('Time(s)')
    ylabel('Energy (J)')
    title('Energy over Time (Semi-implicit)')
    legend('Energy (J)')

    

    case 2
    %% DNA Analysis
    load('chr1_sect.mat');
    
    numBases = length(dna); % Size of DNA
    

    startPoint = -1; % -1 means startPoint is not set

    maxLength = 0; % Starts at a small maximum to then increase
    minLength = numBases; % Starts at a large minimum to shrink down
    totalLength = 0;
    totalProteins = 0;

    TAA = 0; % Stores number of times each stop codon is used
    TAG = 0;
    TGA = 0;

   
    for k = 1:3:numBases-2 % Iterates over array, stopping two from the end to prevent out of bounds error
        
        if startPoint == -1 
            if isequal(dna(k:k+2),[1; 4; 3]) % Initializes start codon
                 startPoint = k;
            end
        
        % if group of 3 is a end codon, then adds 1 to variable it represents
        elseif (isequal(dna(k:k+2),[4; 1; 1]) || isequal(dna(k:k+2),[4;1;3]) || isequal(dna(k:k+2),[4; 3;1])) && k-startPoint >= 3
            
            if isequal(dna(k:k+2),[4; 1; 1])
                TAA = TAA + 1;
            
            elseif isequal(dna(k:k+2),[4;1;3])
                TAG = TAG + 1;

            elseif isequal(dna(k:k+2),[4; 3;1])
                TGA = TGA + 1;
            end


            len = k-startPoint+3; 
            
            if len < minLength % If variable is smaller, then set it to minLength
                minLength = len;
            end

            if len > maxLength % If variable is larger, then set it to maxLength
                maxLength = len;
            end
            
            totalLength = totalLength + len; % Adds length to total combined length of protein-coding codons
            startPoint = -1; % Resets start point
            totalProteins = totalProteins + 1; % Increments number of protein-coding codons

        end % if 
    end % for loop
    
    % Initialized most used variable to mostUsedStop
    if TAA > TGA && TAA > TAG
        mostUsedStop = "TAA";
    elseif TGA > TAG
        mostUsedStop = "TGA";
    else
        mostUsedStop = "TAG";
    end

    
    averageLength = totalLength/totalProteins; % Calculates average length and displays it, along with other information
    fprintf("Total Protein-Coding Segments: %i\n",totalProteins);
    fprintf("Average Length: %.2f\n",averageLength);
    fprintf("Maximum Length: %.i\n",maxLength);
    fprintf("Minimum Length: %.i\n",minLength);

    percentUsed = totalLength/numBases*100; % Calculates and outputs percent of bases used
    fprintf("Percent of DNA used in protein-coding process: %.2f\n",percentUsed)
    fprintf("Stop codon used most: %s with %i uses.\n", mostUsedStop,max([TAA,TAG,TGA]))
    
end
