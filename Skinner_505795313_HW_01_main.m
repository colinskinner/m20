%% Skinner_505795313_HW_01_main.m
% Colin Skinner
% UID: 505975313
% Problem 1 compares MATLAB value of pi and 3.14 to with oblate spheroid calculation.
% Problom 2 outputs neighbors of a cell in a 2D array that is linearly-indexed. 

%% Clearing cache

clear all
close all
clc

problem = input("Which problem to test?");
switch(problem)
    case 1
        %% Problem 1: Oblate Spheroid
        
        % Input values for r1 and r2
        r1 = input("Enter number for Equatorial (larger) radius in km (r1): "); % Test value 6378.137
        r2 = input("Enter number for Polar (smaller) radius in km (r2): "); % Test value 6356.752 
       
        % Error code:
        % Ensures that r1 and r2 are not strings, NULL, negative or zero, or complex
        % Also ensures that r1 != r2 and that r1 is larger than r2
        if isstring(r1) || isstring(r2) 
            error("Error: Enter numbers for both radii")
        end
        if size(r1,1) == 0 || size(r2,1) == 0
            error("Error: You did not enter anything for one or more of the radii")
        end
        if r1 <= 0 || r2 <= 0
            error("Error: Input non-zero, positive real radii")
        end
        if ~isreal(r1) || ~isreal(r2)
        error("Error: Input both radii as real numbers")
        end
        if r1 == r2 
            error("You have input a circle")
        end   
        if r1 < r2
            error("Error: You input the equatorial axis is smaller than the polar.")
        end
        
        gamma = acos(r2/r1); % Helper cosine function 
        
        calc = 2*pi*(r1^2 + (r2^2)/(sin(gamma))*log((cos(gamma))/(1-sin(gamma)))); % Calculates surface area 
        approx = 4*pi*((r1+r2)/2)^2; % Approximates surface area
        
        % Displays results
        disp("For the input value of " + r1 + " km as r1 and " + r2 + " km as r2:") 
        disp("- The surface area calculation (rounded to 5 sig figs) yielded " + round(calc, 5, "significant") + " km^2")
        disp("- The surface area approximation (rounded to 5 sig figs) yielded " + round(approx, 5, "significant") + " km^2")
        
        % Displays difference and percent difference
        error = 100 * abs((calc-approx)/((calc+approx)/2));
        disp("The approximate difference is " + round(calc-approx, 5, "significant") + " km, and the percent difference is " + error + "%")

    case 2
        %% Problem 2: Neighbor Identification
        
        % Input values for MxN array with cell P
        M = input("Enter an integer for the number of rows (M): ");
        N = input("Enter an integer for the number of columns (N): ");
        P = input("Enter an integer for the cell (P): ");
        neighbors = [P-M-1 P-M P-M+1 P-1 P+1 P+M-1 P+M P+M+1]; % Array of possible neighbors (to be edited later in code)
        
        % Errors:
        % Ensures integers, dimensions larger than 1, and that P is in the array
        if mod(M,1) ~= 0 || mod(N,1) ~= 0 || mod(P,1) ~= 0
            error("Error: Enter integers")
        elseif M < 2 || N < 2
            error("Error: Numbers of Rows and Columns has to be greater than 1")
        elseif P <= 0 || P >= M*N
            error("Error: P must be inside the array")
        end 
        
        
        
        if mod(P-1,M) == 0
            top = 1;
        %     disp("Top")
            neighbors(1) = -1;
            neighbors(4) = -1;
            neighbors(6) = -1;
        end
        if mod(P,M) == 0
            bottom = 1;
        %     disp("Bottom")
            neighbors(3) = -1;
            neighbors(5) = -1;
            neighbors(8) = -1;
        end
        if P <= M
            left = 1;
        %     disp("Left")
            neighbors(1) = -1;
            neighbors(2) = -1;
            neighbors(3) = -1;
        end
        if P > M*(N-1)
            right = 1;
        %     disp("Right")
            neighbors(6) = -1;
            neighbors(7) = -1;
            neighbors(8) = -1;
        end
        
        
        neighbors = neighbors(neighbors>-1);
        fprintf("Cell ID: %i\n", P)
        fprintf("Neighbors: ")
        fprintf('%i ', neighbors);
        
        % At top if P-1 is divisible by M
        % At bottom is P is divisible by M
        % Left if P <= M
        % Right if P > M(N-1)
    
    otherwise
        error("Invalid problem number")
    
end % ends switch