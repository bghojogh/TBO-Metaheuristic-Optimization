%% Tree-Based Optimization (TBO) Algorithm

%% MATLAB initializations:
clc
clear all
close all

%% Creating benchmark:
numberOfBenchmark = input('Please enter the number of Benchmark (1, 2, 3, 4 or 5): ');
cd('./benchmarks');
[x, z, step] = LandScape (numberOfBenchmark);
cd('..');
x_min = min(x);
x_max = max(x);
y_min = x_min;
y_max = x_max;
y = x;
ParticlesNumEntered = input('Please enter number of Particles: ');
surf(x,y,z,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
xlabel('x');
ylabel('y');
zlabel('z');
set(gcf, 'Color', [1 1 1]);  % backgroundcolor white
sub_algorithm = input('Please choose sub-algorithm (1 for simpleLocalSearch, 2 for PSO, 3 for GA): ');

%% Algorithm:
tic
%%%%%%% initializations:
if sub_algorithm == 1
    GlobalIterationNum = 10;
elseif sub_algorithm == 2
    GlobalIterationNum = 10;
elseif sub_algorithm == 3
    GlobalIterationNum = 10;
end
ParticlesNum = ParticlesNumEntered;
GlobalBestCoordinate = zeros(2,1);
GlobalBestFitness = 0;
min_vertical = x_min;
max_vertical = x_max;
min_horizontal = y_min;
max_horizontal = y_max;
split_type = 'horizontal';

%%%%%%% initializations (for plotting):
bestFitnessArray = 0;
betterAnswerFoundFlag = 0;

%%%%%%% global iterations (after each end of all local searches):
for globalIteration = 1:GlobalIterationNum
    betterAnswerFoundFlag = 0;
    
    %%%%%%% choose vertical or horizontal split:
    if strcmp(split_type, 'vertical')
        split_type = 'horizontal';
    else
        split_type = 'vertical';
    end
        
    %%%%%%% choose splitting point:
    if strcmp(split_type, 'vertical')
        L1_vertical = min_vertical + 0.3*(max_vertical - min_vertical);
        L2_vertical = min_vertical + 0.7*(max_vertical - min_vertical);
        splitting_point = L1_vertical + (L2_vertical - L1_vertical)*rand;
    else
        L1_horizontal = min_horizontal + 0.3*(max_horizontal - min_horizontal);
        L2_horizontal = min_horizontal + 0.7*(max_horizontal - min_horizontal);
        splitting_point = L1_horizontal + (L2_horizontal - L1_horizontal)*rand;
    end
    
    %%%%%%% plot the splitting lines:
    if globalIteration == 1
        fig = figure;
    end
    surf(x,y,z,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
    xlabel('x');
    ylabel('y');
    zlabel('z');
    view(0, 90);  % view the surface from directly overhead
    set(gcf, 'Color', [1 1 1]);  % backgroundcolor white
    hold on
    temp_height = (max(max(z)) + 100000) * ones(1,2);
    if strcmp(split_type, 'vertical')
        plot3([splitting_point, splitting_point],[min_horizontal, max_horizontal],temp_height,'-w', 'LineWidth', 3, 'MarkerFaceColor', [1,1,1]);
    else
        plot3([min_vertical, max_vertical],[splitting_point, splitting_point],temp_height,'-w', 'LineWidth', 3, 'MarkerFaceColor', [1,1,1]);
    end
%     hold off
    
    %%%%%%% search in each region:
    iterationLocalSearch_simpleLocalSearch = 30;
    GlobalIterationNum_PSO = 30;
    iterationLocalSearch_PSO = 30;
    GlobalIterationNum_GA = 100;
    disp_figures_and_results = 0;
    if strcmp(split_type, 'vertical')
        if sub_algorithm == 1
            cd('./subAlgorithms');
            %%%% right region:
            [GlobalBestFitness_1, GlobalBestCoordinate_1] = SimpleLocalSearch(ParticlesNum, x, y, z, splitting_point, max_vertical, min_horizontal, max_horizontal, step, iterationLocalSearch_simpleLocalSearch);
            %%%% left region:
            [GlobalBestFitness_2, GlobalBestCoordinate_2] = SimpleLocalSearch(ParticlesNum, x, y, z, min_vertical, splitting_point, min_horizontal, max_horizontal, step, iterationLocalSearch_simpleLocalSearch);
            cd('..');
        elseif sub_algorithm == 2
            cd('./subAlgorithms');
            %%%% right region:
            [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = PSO(x,y,z, ParticlesNum, step, splitting_point, max_vertical, min_horizontal, max_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
            %%%% left region:
            [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = PSO(x,y,z, ParticlesNum, step, min_vertical, splitting_point, min_horizontal, max_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
            cd('..');
        elseif sub_algorithm == 3
            cd('./subAlgorithms');
            %%%% right region:
            [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = GA(x,y,z, ParticlesNum, step, splitting_point, max_vertical, min_horizontal, max_horizontal, GlobalIterationNum_GA, disp_figures_and_results);
            %%%% left region:
            [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = GA(x,y,z, ParticlesNum, step, min_vertical, splitting_point, min_horizontal, max_horizontal, GlobalIterationNum_GA, disp_figures_and_results);
            cd('..');
        end
    else
        if sub_algorithm == 1
            cd('./subAlgorithms');
            %%%% up region:
            [GlobalBestFitness_1, GlobalBestCoordinate_1] = SimpleLocalSearch(ParticlesNum, x, y, z, min_vertical, max_vertical, splitting_point, max_horizontal, step, iterationLocalSearch_simpleLocalSearch);
            %%%% down region:
            [GlobalBestFitness_2, GlobalBestCoordinate_2] = SimpleLocalSearch(ParticlesNum, x, y, z, min_vertical, max_vertical, min_horizontal, splitting_point, step, iterationLocalSearch_simpleLocalSearch);
            cd('..');
        elseif sub_algorithm == 2
            cd('./subAlgorithms');
            %%%% up region:
            [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = PSO(x,y,z, ParticlesNum, step, min_vertical, max_vertical, splitting_point, max_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
            %%%% down region:
            [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = PSO(x,y,z, ParticlesNum, step, min_vertical, max_vertical, min_horizontal, splitting_point, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
            cd('..');
        elseif sub_algorithm == 3
            cd('./subAlgorithms');
            %%%% up region:
            [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = GA(x,y,z, ParticlesNum, step, min_vertical, max_vertical, splitting_point, max_horizontal, GlobalIterationNum_GA, disp_figures_and_results);
            %%%% down region:
            [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = GA(x,y,z, ParticlesNum, step, min_vertical, max_vertical, min_horizontal, splitting_point, GlobalIterationNum_GA, disp_figures_and_results);
            cd('..');
        end
    end
    
    %%%%%%% updating global best, if better answer has been found:
    if globalIteration == 1
        GlobalBestFitness = min(GlobalBestFitness_1, GlobalBestFitness_2);
        if GlobalBestFitness_1 < GlobalBestFitness_2
            GlobalBestCoordinate = GlobalBestCoordinate_1;
        else
            GlobalBestCoordinate = GlobalBestCoordinate_2;
        end
        %%%% for plot:
        bestFitnessArray = [GlobalBestFitness; GlobalBestCoordinate; globalIteration];
    elseif GlobalBestFitness > min(GlobalBestFitness_1, GlobalBestFitness_2)
        GlobalBestFitness = min(GlobalBestFitness_1, GlobalBestFitness_2);
        if GlobalBestFitness_1 < GlobalBestFitness_2
            GlobalBestCoordinate = GlobalBestCoordinate_1;
        else
            GlobalBestCoordinate = GlobalBestCoordinate_2;
        end
        %%%% for plot:
        bestFitnessArray = [bestFitnessArray [GlobalBestFitness; GlobalBestCoordinate; globalIteration]];
    end
        
    %%%%%%% enter a region:
    if (GlobalBestFitness_1 > 0) && (GlobalBestFitness_2 > 0)
        Probability = GlobalBestFitness_1 / (GlobalBestFitness_1 + GlobalBestFitness_2);
        Probability = 1 - Probability; %% because we are finding minimum and not maximum!
    elseif (GlobalBestFitness_1 < 0) && (GlobalBestFitness_2 < 0)
        Probability = GlobalBestFitness_1 / (GlobalBestFitness_1 + GlobalBestFitness_2);
    else
        GlobalBestFitness_1 = GlobalBestFitness_1 + abs(min(GlobalBestFitness_1, GlobalBestFitness_2)) + 1;
        GlobalBestFitness_2 = GlobalBestFitness_2 + abs(min(GlobalBestFitness_1, GlobalBestFitness_2)) + 1;
        Probability = GlobalBestFitness_1 / (GlobalBestFitness_1 + GlobalBestFitness_2);
        Probability = 1 - Probability; %% because we are finding minimum and not maximum!
    end
%     Probability
    a_rand = rand;
    if a_rand < Probability
        enter_to = 'right / up';
    else
        enter_to = 'left / down';
    end
    
    %%%%%%% updating the limits of vertical and horizontal regions:
    if strcmp(split_type, 'vertical')
        if strcmp(enter_to, 'right / up')
            min_vertical = splitting_point;
        else
            max_vertical = splitting_point;
        end
    else
        if strcmp(enter_to, 'right / up')
            min_horizontal = splitting_point;
        else
            max_horizontal = splitting_point;
        end
    end
    
end % (Error <= 0.1 || iterationNum == 50)  --> should we put error, too? -> I don't think so!

str = sprintf('GlobalBestFitness: %.1f, GlobalBestCoordinate: (%.1f,%.1f)', GlobalBestFitness, GlobalBestCoordinate(1), GlobalBestCoordinate(2));
title(str);

%% Plotting results:
figure
plot([bestFitnessArray(4,:) ,GlobalIterationNum], [bestFitnessArray(1,:), bestFitnessArray(1,length(bestFitnessArray(1,:)))]);
% str = sprintf('best fittness found: %f\nbest fitness coordinate found: (%.3f;%.3f)\nbest fitness found in iteration number: %d\nbest fitness found in time: %f seconds', ...
%                 GlobalBestFitness, GlobalBestCoordinate(1,1), GlobalBestCoordinate(2,1), bestFitnessArray(4,length(bestFitnessArray(4,:))), time_betterSolutionFound);
disp(str);
title(str);
xlabel('number of iterations');
ylabel('best (least) found fitness value');

