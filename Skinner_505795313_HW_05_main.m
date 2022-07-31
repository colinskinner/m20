%% Skinner_505795313_HW_01_main.m
% Colin Skinner
% UID: 505975313
% Problem 1: Median number of people to have shared birthday week
% Problem 2: 

%% Clearing cache and switch statement
clear all
close all
clc
rng('shuffle')

problem = input("Which problem to test?\n");
switch(problem)
    case 1
    %% The Shared Birthday Problem
    
    trials = zeros(1,10e4);

    for i=1:10e4
        birthdaysdays(1) = ceil(rand(1,1)*365);
        common = [linspace(birthdaysdays(1)-6,birthdaysdays(1)+6,13)];
        found = 0;
        count = 1;
        while(found == 0)
            count = count + 1;
            birthdaysdays(count) = ceil(rand(1,1)*365);

            if sum(common==birthdaysdays(count))>0 || sum(common==(birthdaysdays(count)+365))>0 || sum(common==(birthdaysdays(count)-365))>0
                found = 1;         
            else
                common = [common linspace(birthdaysdays(count)-6,birthdaysdays(count)+6,13)];
            end
%             end
    
        end
        trials(i) = count;
    end
    
    fprintf("Median Number of People = %i\n",median(trials))
    histogram(trials)
    xlabel("Number of people")
    ylabel("Occurances")
    title("Number of People Required for Same-Week Birthdays")
    grid on
    set(gcf,'Position',[100 100 1000 600])
    set(gca,'LineWidth',3,'FontSize',20)


    % Sum of array of numbers in common


    

    case 2
    % Random Walk Collisions
    trials = zeros(1,5000);
    BC = [-5, 5];
    for i=1:5000
        a = [-5; 0];
        b = [5; 0];
        p = .2;
        a_path = a;
        b_path = b;
        collide = 0;
        moves = 0;
    
        while moves< 1000 && ~collide
            
            if rand>(1-4*p)
                a = RandomWalk2D(a,BC);
            end
    
            if rand>(1-4*p)
                b = RandomWalk2D(b,BC);
            end
            
            a_path = [a_path a];
            b_path = [b_path b];
    
            if a==b
                collide = 1;
            end
    
            moves = moves + 1;
            
        end
        trials(i) = moves;
    end

    fprintf("Median = %1.1f",ceil(median(trials)))
%     disp(trials)
    histogram(trials,100)
    xlabel("Number of moves")
    ylabel("Occurances")
    title("Number of Moves Required for a Collision with Both People Moving")
    
    
%     figure (1)
%     clf reset
%     hold on
%     grid on
%     axis equal
%     axis([-5 6 -5 6])
%     xticks(-5:1:6)
%     yticks(-5:1:6)
    

%   Without b moving

    trials = zeros(1,5000);
    for i=1:5000
        a = [-5; 0];
        b = [5; 0];
        p = 0.2;
        a_path = a;
        b_path = b;
        collide = 0;
        moves = 0;
    
        while moves< 1000 && ~collide
            
            if rand>(1-4*p)
                a = RandomWalk2D(a,BC);
            end

%             if rand>(1-4*p)
%                 b = RandomWalk2D(b,BC);
%             end
    
            
            
            a_path = [a_path a];
            b_path = [b_path b];
    
            if a==b
                collide = 1;
            end
    
            moves = moves + 1;
            
        end
        trials(i) = moves;
    end
    fprintf("\nMedian = %1.1f",ceil(median(trials)))
%     disp(trials)
    figure;
    histogram(trials,100)
    xlabel("Number of moves")
    ylabel("Occurances")
    title("Number of Moves Required for a Collision with One Person Moving")
end

%% ------------------------------------------------------------------------------------------

function F = RandomWalk2D(P,BC)
% randomwalk2D takes in P, the coordinate points of the person, and n, the dimensions of the 2D array the person is in
    x = P(1);
    y = P(2);
    
    
    
    if rand < .5
        if rand < .5
            x = x+1;
        else
            x = x-1;
        end
    else
        if rand < .5
            y = y+1;
        else
            y = y-1;
        end
    end

    
    if y > BC(2) % Top
        y = BC(2);
    end

    if y < BC(1) % Bottom
        y = BC(1);
    end
    
    if x > BC(2) % Right
        x = BC(2);
    end
    
    if x < BC(1) % Left
        x = BC(1);
    end
    
    F = [x; y];
    
end

