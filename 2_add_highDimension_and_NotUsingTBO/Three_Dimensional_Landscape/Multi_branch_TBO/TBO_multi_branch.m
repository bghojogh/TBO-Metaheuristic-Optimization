%% Tree-Based Optimization (TBO) Algorithm

%% MATLAB initializations:
clc
clear all
close all

%% Creating benchmark:
numberOfBenchmark = input('Please enter the number of Benchmark (1, 2, 3, 4): ');
cd('./benchmarks');
[x, z, step, min_of_z, x_of_min_of_z, y_of_min_of_z, w_of_min_of_z] = LandScape (numberOfBenchmark);
cd('..');
x_min = min(x);
x_max = max(x);
y_min = x_min;
y_max = x_max;
y = x;
w = y;
w_min = y_min;
w_max = y_max;

[z_min,ind] = min(z(:));
[ii,jj,kk] = ind2sub(size(z),ind);

ParticlesNumEntered = input('Please enter number of Particles: ');
% surf(x,y,z,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
% xlabel('x');
% ylabel('y');
% zlabel('z');
% set(gcf, 'Color', [1 1 1]);  % backgroundcolor white
sub_algorithm = input('Please choose sub-algorithm (3 for GA): ');

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
min_3d = w_min;
max_3d = w_max;
%split_type = 'horizontal';

%%%%%%% initializations (for plotting):
bestFitnessArray = 0;
betterAnswerFoundFlag = 0;

%%%%%%% global iterations (after each end of all local searches):
for globalIteration = 1:GlobalIterationNum
    betterAnswerFoundFlag = 0;
    
%     disp('globalIteration:');
%     
%     disp(globalIteration);
        
    %%%%%%% choose splitting point:
    % vertical split:
        L1_vertical = min_vertical + 0.3*(max_vertical - min_vertical);
        L2_vertical = min_vertical + 0.7*(max_vertical - min_vertical);
        splitting_point_vertical = L1_vertical + (L2_vertical - L1_vertical)*rand;
    % horizontal split:
        L1_horizontal = min_horizontal + 0.3*(max_horizontal - min_horizontal);
        L2_horizontal = min_horizontal + 0.7*(max_horizontal - min_horizontal);
        splitting_point_horizontal = L1_horizontal + (L2_horizontal - L1_horizontal)*rand;
    % 3d split:
        L1_3d = min_3d + 0.3*(max_3d - min_3d);
        L2_3d = min_3d + 0.7*(max_3d - min_3d);
        splitting_point_3d = L1_3d + (L2_3d - L1_3d)*rand;
    
    %%%%%%% plot the splitting lines:
%     if globalIteration == 1
%         fig = figure;
%     end
%     surf(x,y,z,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
%     xlabel('x');
%     ylabel('y');
%     zlabel('z');
%     view(0, 90);  % view the surface from directly overhead
%     set(gcf, 'Color', [1 1 1]);  % backgroundcolor white
%     hold on
%     temp_height = (max(max(z)) + 100000) * ones(1,2);
%     % vertical split:
%         plot3([splitting_point_vertical, splitting_point_vertical],[min_horizontal, max_horizontal],temp_height,'-w', 'LineWidth', 3, 'MarkerFaceColor', [1,1,1]);
%     % horizontal split:
%         plot3([min_vertical, max_vertical],[splitting_point_horizontal, splitting_point_horizontal],temp_height,'-w', 'LineWidth', 3, 'MarkerFaceColor', [1,1,1]);
% 
% %     hold off
    
    %%%%%%% search in each region:
    iterationLocalSearch_simpleLocalSearch = 30;
    GlobalIterationNum_PSO = 30;
    iterationLocalSearch_PSO = 30;
    GlobalIterationNum_GA = 100;
    disp_figures_and_results = 0;
    
        if sub_algorithm == 1
            cd('./subAlgorithms');
            %%%% up-right region:
            [GlobalBestFitness_1, GlobalBestCoordinate_1] = SimpleLocalSearch(ParticlesNum, x, y, z, splitting_point_vertical, max_vertical, splitting_point_horizontal, max_horizontal, step, iterationLocalSearch_simpleLocalSearch);
            %%%% up-left region:
            [GlobalBestFitness_2, GlobalBestCoordinate_2] = SimpleLocalSearch(ParticlesNum, x, y, z, splitting_point_vertical, max_vertical, min_horizontal, splitting_point_horizontal, step, iterationLocalSearch_simpleLocalSearch);
            %%%% down-right region:
            [GlobalBestFitness_3, GlobalBestCoordinate_3] = SimpleLocalSearch(ParticlesNum, x, y, z, min_vertical, splitting_point_vertical, splitting_point_horizontal, max_horizontal, step, iterationLocalSearch_simpleLocalSearch);
            %%%% down-left region:
            [GlobalBestFitness_4, GlobalBestCoordinate_4] = SimpleLocalSearch(ParticlesNum, x, y, z, min_vertical, splitting_point_vertical, min_horizontal, splitting_point_horizontal, step, iterationLocalSearch_simpleLocalSearch);
            cd('..');
        elseif sub_algorithm == 2
            cd('./subAlgorithms');
            %%%% up-right region:
            [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = PSO(x,y,z, ParticlesNum, step, splitting_point_vertical, max_vertical, splitting_point_horizontal, max_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
            %%%% up-left region:
            [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = PSO(x,y,z, ParticlesNum, step, splitting_point_vertical, max_vertical, min_horizontal, splitting_point_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
            %%%% down-right region:
            [~, ~, GlobalBestFitness_3, GlobalBestCoordinate_3] = PSO(x,y,z, ParticlesNum, step, min_vertical, splitting_point_vertical, splitting_point_horizontal, max_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
            %%%% down-left region:
            [~, ~, GlobalBestFitness_4, GlobalBestCoordinate_4] = PSO(x,y,z, ParticlesNum, step, min_vertical, splitting_point_vertical, min_horizontal, splitting_point_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
            cd('..');
        elseif sub_algorithm == 3
            cd('./subAlgorithms');
            %%%% up-right region:
            [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = GA(x,y,w,z, ParticlesNum, step, splitting_point_vertical, max_vertical, splitting_point_horizontal, max_horizontal, min_3d, splitting_point_3d, GlobalIterationNum_GA, disp_figures_and_results);
            %%%% up-left region:
            [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = GA(x,y,w,z, ParticlesNum, step, splitting_point_vertical, max_vertical, min_horizontal, splitting_point_horizontal, min_3d, splitting_point_3d, GlobalIterationNum_GA, disp_figures_and_results);
            %%%% down-right region:
            [~, ~, GlobalBestFitness_3, GlobalBestCoordinate_3] = GA(x,y,w,z, ParticlesNum, step, min_vertical, splitting_point_vertical, splitting_point_horizontal, max_horizontal, min_3d, splitting_point_3d, GlobalIterationNum_GA, disp_figures_and_results);
            %%%% down-left region:
            [~, ~, GlobalBestFitness_4, GlobalBestCoordinate_4] = GA(x,y,w,z, ParticlesNum, step, min_vertical, splitting_point_vertical, min_horizontal, splitting_point_horizontal, min_3d, splitting_point_3d, GlobalIterationNum_GA, disp_figures_and_results);
            
            %%%% up-right region --> second layer:
            [~, ~, GlobalBestFitness_5, GlobalBestCoordinate_5] = GA(x,y,w,z, ParticlesNum, step, splitting_point_vertical, max_vertical, splitting_point_horizontal, max_horizontal, splitting_point_3d, max_3d, GlobalIterationNum_GA, disp_figures_and_results);
            %%%% up-left region --> second layer:
            [~, ~, GlobalBestFitness_6, GlobalBestCoordinate_6] = GA(x,y,w,z, ParticlesNum, step, splitting_point_vertical, max_vertical, min_horizontal, splitting_point_horizontal, splitting_point_3d, max_3d, GlobalIterationNum_GA, disp_figures_and_results);
            %%%% down-right region --> second layer:
            [~, ~, GlobalBestFitness_7, GlobalBestCoordinate_7] = GA(x,y,w,z, ParticlesNum, step, min_vertical, splitting_point_vertical, splitting_point_horizontal, max_horizontal, splitting_point_3d, max_3d, GlobalIterationNum_GA, disp_figures_and_results);
            %%%% down-left region --> second layer:
            [~, ~, GlobalBestFitness_8, GlobalBestCoordinate_8] = GA(x,y,w,z, ParticlesNum, step, min_vertical, splitting_point_vertical, min_horizontal, splitting_point_horizontal, splitting_point_3d, max_3d, GlobalIterationNum_GA, disp_figures_and_results);
            
            cd('..');
        end
    
    
    %%%%%%% updating global best, if better answer has been found:
    if globalIteration == 1
        [GlobalBestFitness, index] = min([GlobalBestFitness_1, GlobalBestFitness_2, GlobalBestFitness_3, GlobalBestFitness_4, GlobalBestFitness_5, GlobalBestFitness_6, GlobalBestFitness_7, GlobalBestFitness_8]);
        switch index
            case 1
                GlobalBestCoordinate = GlobalBestCoordinate_1;
            case 2
                GlobalBestCoordinate = GlobalBestCoordinate_2;
            case 3
                GlobalBestCoordinate = GlobalBestCoordinate_3;
            case 4
                GlobalBestCoordinate = GlobalBestCoordinate_4;
            case 5
                GlobalBestCoordinate = GlobalBestCoordinate_5;
            case 6
                GlobalBestCoordinate = GlobalBestCoordinate_6;
            case 7
                GlobalBestCoordinate = GlobalBestCoordinate_7;
            case 8
                GlobalBestCoordinate = GlobalBestCoordinate_8;
        end
        %%%% for plot:
        bestFitnessArray = [GlobalBestFitness; GlobalBestCoordinate; globalIteration];
    elseif GlobalBestFitness > min([GlobalBestFitness_1, GlobalBestFitness_2, GlobalBestFitness_3, GlobalBestFitness_4, GlobalBestFitness_5, GlobalBestFitness_6, GlobalBestFitness_7, GlobalBestFitness_8])
        [GlobalBestFitness, index] = min([GlobalBestFitness_1, GlobalBestFitness_2, GlobalBestFitness_3, GlobalBestFitness_4, GlobalBestFitness_5, GlobalBestFitness_6, GlobalBestFitness_7, GlobalBestFitness_8]);
        switch index
            case 1
                GlobalBestCoordinate = GlobalBestCoordinate_1;
            case 2
                GlobalBestCoordinate = GlobalBestCoordinate_2;
            case 3
                GlobalBestCoordinate = GlobalBestCoordinate_3;
            case 4
                GlobalBestCoordinate = GlobalBestCoordinate_4;
            case 5
                GlobalBestCoordinate = GlobalBestCoordinate_5;
            case 6
                GlobalBestCoordinate = GlobalBestCoordinate_6;
            case 7
                GlobalBestCoordinate = GlobalBestCoordinate_7;
            case 8
                GlobalBestCoordinate = GlobalBestCoordinate_8;
        end
        %%%% for plot:
        bestFitnessArray = [bestFitnessArray [GlobalBestFitness; GlobalBestCoordinate; globalIteration]];
    end
        
    %%%%%%% enter a region:
    if (GlobalBestFitness_1 > 0) && (GlobalBestFitness_2 > 0) && (GlobalBestFitness_3 > 0) && (GlobalBestFitness_4 > 0) && (GlobalBestFitness_5 > 0) && (GlobalBestFitness_6 > 0) && (GlobalBestFitness_7 > 0) && (GlobalBestFitness_8 > 0)
        Probability1 = GlobalBestFitness_1 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability2 = GlobalBestFitness_2 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability3 = GlobalBestFitness_3 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability4 = GlobalBestFitness_4 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability5 = GlobalBestFitness_5 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability6 = GlobalBestFitness_6 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability7 = GlobalBestFitness_7 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability8 = GlobalBestFitness_8 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability1 = 1 - Probability1; %% because we are finding minimum and not maximum!
        Probability2 = 1 - Probability2; %% because we are finding minimum and not maximum!
        Probability3 = 1 - Probability3; %% because we are finding minimum and not maximum!
        Probability4 = 1 - Probability4; %% because we are finding minimum and not maximum!
        Probability5 = 1 - Probability5; %% because we are finding minimum and not maximum!
        Probability6 = 1 - Probability6; %% because we are finding minimum and not maximum!
        Probability7 = 1 - Probability7; %% because we are finding minimum and not maximum!
        Probability8 = 1 - Probability8; %% because we are finding minimum and not maximum!
    elseif (GlobalBestFitness_1 < 0) && (GlobalBestFitness_2 < 0) && (GlobalBestFitness_3 < 0) && (GlobalBestFitness_4 < 0) && (GlobalBestFitness_5 < 0) && (GlobalBestFitness_6 < 0) && (GlobalBestFitness_7 < 0) && (GlobalBestFitness_8 < 0)
        Probability1 = GlobalBestFitness_1 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability2 = GlobalBestFitness_2 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability3 = GlobalBestFitness_3 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability4 = GlobalBestFitness_4 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability5 = GlobalBestFitness_5 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability6 = GlobalBestFitness_6 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability7 = GlobalBestFitness_7 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability8 = GlobalBestFitness_8 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
    else
        GlobalBestFitness_1_backup = GlobalBestFitness_1;
        GlobalBestFitness_2_backup = GlobalBestFitness_2;
        GlobalBestFitness_3_backup = GlobalBestFitness_3;
        GlobalBestFitness_4_backup = GlobalBestFitness_4;
        GlobalBestFitness_5_backup = GlobalBestFitness_5;
        GlobalBestFitness_6_backup = GlobalBestFitness_6;
        GlobalBestFitness_7_backup = GlobalBestFitness_7;
        GlobalBestFitness_8_backup = GlobalBestFitness_8;
        GlobalBestFitness_1 = GlobalBestFitness_1_backup + abs(min([GlobalBestFitness_1_backup, GlobalBestFitness_2_backup, GlobalBestFitness_3_backup, GlobalBestFitness_4_backup, GlobalBestFitness_5_backup, GlobalBestFitness_6_backup, GlobalBestFitness_7_backup, GlobalBestFitness_8_backup])) + 1;
        GlobalBestFitness_2 = GlobalBestFitness_2_backup + abs(min([GlobalBestFitness_1_backup, GlobalBestFitness_2_backup, GlobalBestFitness_3_backup, GlobalBestFitness_4_backup, GlobalBestFitness_5_backup, GlobalBestFitness_6_backup, GlobalBestFitness_7_backup, GlobalBestFitness_8_backup])) + 1;
        GlobalBestFitness_3 = GlobalBestFitness_3_backup + abs(min([GlobalBestFitness_1_backup, GlobalBestFitness_2_backup, GlobalBestFitness_3_backup, GlobalBestFitness_4_backup, GlobalBestFitness_5_backup, GlobalBestFitness_6_backup, GlobalBestFitness_7_backup, GlobalBestFitness_8_backup])) + 1;
        GlobalBestFitness_4 = GlobalBestFitness_4_backup + abs(min([GlobalBestFitness_1_backup, GlobalBestFitness_2_backup, GlobalBestFitness_3_backup, GlobalBestFitness_4_backup, GlobalBestFitness_5_backup, GlobalBestFitness_6_backup, GlobalBestFitness_7_backup, GlobalBestFitness_8_backup])) + 1;
        GlobalBestFitness_5 = GlobalBestFitness_5_backup + abs(min([GlobalBestFitness_1_backup, GlobalBestFitness_2_backup, GlobalBestFitness_3_backup, GlobalBestFitness_4_backup, GlobalBestFitness_5_backup, GlobalBestFitness_6_backup, GlobalBestFitness_7_backup, GlobalBestFitness_8_backup])) + 1;
        GlobalBestFitness_6 = GlobalBestFitness_6_backup + abs(min([GlobalBestFitness_1_backup, GlobalBestFitness_2_backup, GlobalBestFitness_3_backup, GlobalBestFitness_4_backup, GlobalBestFitness_5_backup, GlobalBestFitness_6_backup, GlobalBestFitness_7_backup, GlobalBestFitness_8_backup])) + 1;
        GlobalBestFitness_7 = GlobalBestFitness_7_backup + abs(min([GlobalBestFitness_1_backup, GlobalBestFitness_2_backup, GlobalBestFitness_3_backup, GlobalBestFitness_4_backup, GlobalBestFitness_5_backup, GlobalBestFitness_6_backup, GlobalBestFitness_7_backup, GlobalBestFitness_8_backup])) + 1;
        GlobalBestFitness_8 = GlobalBestFitness_8_backup + abs(min([GlobalBestFitness_1_backup, GlobalBestFitness_2_backup, GlobalBestFitness_3_backup, GlobalBestFitness_4_backup, GlobalBestFitness_5_backup, GlobalBestFitness_6_backup, GlobalBestFitness_7_backup, GlobalBestFitness_8_backup])) + 1;
        Probability1 = GlobalBestFitness_1 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability2 = GlobalBestFitness_2 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability3 = GlobalBestFitness_3 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability4 = GlobalBestFitness_4 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability5 = GlobalBestFitness_5 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability6 = GlobalBestFitness_6 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability7 = GlobalBestFitness_7 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability8 = GlobalBestFitness_8 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4 + GlobalBestFitness_5 + GlobalBestFitness_6 + GlobalBestFitness_7 + GlobalBestFitness_8);
        Probability1 = 1 - Probability1; %% because we are finding minimum and not maximum!
        Probability2 = 1 - Probability2; %% because we are finding minimum and not maximum!
        Probability3 = 1 - Probability3; %% because we are finding minimum and not maximum!
        Probability4 = 1 - Probability4; %% because we are finding minimum and not maximum!
        Probability5 = 1 - Probability5; %% because we are finding minimum and not maximum!
        Probability6 = 1 - Probability6; %% because we are finding minimum and not maximum!
        Probability7 = 1 - Probability7; %% because we are finding minimum and not maximum!
        Probability8 = 1 - Probability8; %% because we are finding minimum and not maximum!
    end

    
    [a,b] = sort([Probability1, Probability2, Probability3, Probability4, Probability5, Probability6, Probability7, Probability8],'descend');
    while 1
        a_rand = rand;
        if a_rand < a(1)
            switch b(1)
                case 1  % it is probability1
                    enter_to = 'up-right-layer1';
                case 2  % it is probability2
                    enter_to = 'up-left-layer1';
                case 3  % it is probability3
                    enter_to = 'down-right-layer1';
                case 4  % it is probability4
                    enter_to = 'down-left-layer1';
                case 5  % it is probability5
                    enter_to = 'up-right-layer2';
                case 6  % it is probability6
                    enter_to = 'up-left-layer2';
                case 7  % it is probability7
                    enter_to = 'down-right-layer2';
                case 8  % it is probability8
                    enter_to = 'down-left-layer2';
            end
        break;
        else
            a_rand = rand;
            if a_rand < a(2)
                switch b(2)
                    case 1  % it is probability1
                        enter_to = 'up-right-layer1';
                    case 2  % it is probability2
                        enter_to = 'up-left-layer1';
                    case 3  % it is probability3
                        enter_to = 'down-right-layer1';
                    case 4  % it is probability4
                        enter_to = 'down-left-layer1';
                    case 5  % it is probability5
                        enter_to = 'up-right-layer2';
                    case 6  % it is probability6
                        enter_to = 'up-left-layer2';
                    case 7  % it is probability7
                        enter_to = 'down-right-layer2';
                    case 8  % it is probability8
                        enter_to = 'down-left-layer2';
                end
            break;
            else
                a_rand = rand;
                if a_rand < a(3)
                    switch b(3)
                        case 1  % it is probability1
                            enter_to = 'up-right-layer1';
                        case 2  % it is probability2
                            enter_to = 'up-left-layer1';
                        case 3  % it is probability3
                            enter_to = 'down-right-layer1';
                        case 4  % it is probability4
                            enter_to = 'down-left-layer1';
                        case 5  % it is probability5
                            enter_to = 'up-right-layer2';
                        case 6  % it is probability6
                            enter_to = 'up-left-layer2';
                        case 7  % it is probability7
                            enter_to = 'down-right-layer2';
                        case 8  % it is probability8
                            enter_to = 'down-left-layer2';
                    end
                break;
                else
                    a_rand = rand;
                    if a_rand < a(4)
                        switch b(4)
                            case 1  % it is probability1
                                enter_to = 'up-right-layer1';
                            case 2  % it is probability2
                                enter_to = 'up-left-layer1';
                            case 3  % it is probability3
                                enter_to = 'down-right-layer1';
                            case 4  % it is probability4
                                enter_to = 'down-left-layer1';
                            case 5  % it is probability5
                                enter_to = 'up-right-layer2';
                            case 6  % it is probability6
                                enter_to = 'up-left-layer2';
                            case 7  % it is probability7
                                enter_to = 'down-right-layer2';
                            case 8  % it is probability8
                                enter_to = 'down-left-layer2';
                        end
                        break;
                    else
                        a_rand = rand;
                        if a_rand < a(5)
                            switch b(5)
                                case 1  % it is probability1
                                    enter_to = 'up-right-layer1';
                                case 2  % it is probability2
                                    enter_to = 'up-left-layer1';
                                case 3  % it is probability3
                                    enter_to = 'down-right-layer1';
                                case 4  % it is probability4
                                    enter_to = 'down-left-layer1';
                                case 5  % it is probability5
                                    enter_to = 'up-right-layer2';
                                case 6  % it is probability6
                                    enter_to = 'up-left-layer2';
                                case 7  % it is probability7
                                    enter_to = 'down-right-layer2';
                                case 8  % it is probability8
                                    enter_to = 'down-left-layer2';
                            end
                        break;
                        else
                            a_rand = rand;
                                if a_rand < a(6)
                                    switch b(6)
                                        case 1  % it is probability1
                                            enter_to = 'up-right-layer1';
                                        case 2  % it is probability2
                                            enter_to = 'up-left-layer1';
                                        case 3  % it is probability3
                                            enter_to = 'down-right-layer1';
                                        case 4  % it is probability4
                                            enter_to = 'down-left-layer1';
                                        case 5  % it is probability5
                                            enter_to = 'up-right-layer2';
                                        case 6  % it is probability6
                                            enter_to = 'up-left-layer2';
                                        case 7  % it is probability7
                                            enter_to = 'down-right-layer2';
                                        case 8  % it is probability8
                                            enter_to = 'down-left-layer2';
                                    end
                                break;
                                else
                                    a_rand = rand;
                                    if a_rand < a(7)
                                        switch b(7)
                                            case 1  % it is probability1
                                                enter_to = 'up-right-layer1';
                                            case 2  % it is probability2
                                                enter_to = 'up-left-layer1';
                                            case 3  % it is probability3
                                                enter_to = 'down-right-layer1';
                                            case 4  % it is probability4
                                                enter_to = 'down-left-layer1';
                                            case 5  % it is probability5
                                                enter_to = 'up-right-layer2';
                                            case 6  % it is probability6
                                                enter_to = 'up-left-layer2';
                                            case 7  % it is probability7
                                                enter_to = 'down-right-layer2';
                                            case 8  % it is probability8
                                                enter_to = 'down-left-layer2';
                                        end
                                    break;
                                    else
                                        a_rand = rand;
                                        if a_rand < a(8)
                                            switch b(8)
                                                case 1  % it is probability1
                                                    enter_to = 'up-right-layer1';
                                                case 2  % it is probability2
                                                    enter_to = 'up-left-layer1';
                                                case 3  % it is probability3
                                                    enter_to = 'down-right-layer1';
                                                case 4  % it is probability4
                                                    enter_to = 'down-left-layer1';
                                                case 5  % it is probability5
                                                    enter_to = 'up-right-layer2';
                                                case 6  % it is probability6
                                                    enter_to = 'up-left-layer2';
                                                case 7  % it is probability7
                                                    enter_to = 'down-right-layer2';
                                                case 8  % it is probability8
                                                    enter_to = 'down-left-layer2';
                                            end
                                        break;
                                        end
                                    end
                                end
                        end
                    end
                end
            end 
        end
    end
    
    %%%%%%% updating the limits of vertical and horizontal regions:
        if strcmp(enter_to, 'up-right-layer1')
            min_vertical = splitting_point_vertical;
            min_horizontal = splitting_point_horizontal;
            max_3d = splitting_point_3d;
        elseif strcmp(enter_to, 'up-left-layer1')
            min_vertical = splitting_point_vertical;
            max_horizontal = splitting_point_horizontal;
            max_3d = splitting_point_3d;
        elseif strcmp(enter_to, 'down-right-layer1')
            max_vertical = splitting_point_vertical;
            min_horizontal = splitting_point_horizontal;
            max_3d = splitting_point_3d;
        elseif strcmp(enter_to, 'down-left-layer1')
            max_vertical = splitting_point_vertical;
            max_horizontal = splitting_point_horizontal;
            max_3d = splitting_point_3d;
        elseif strcmp(enter_to, 'up-right-layer2')
            min_vertical = splitting_point_vertical;
            min_horizontal = splitting_point_horizontal;
            min_3d = splitting_point_3d;
        elseif strcmp(enter_to, 'up-left-layer2')
            min_vertical = splitting_point_vertical;
            max_horizontal = splitting_point_horizontal;
            min_3d = splitting_point_3d;
        elseif strcmp(enter_to, 'down-right-layer2')
            max_vertical = splitting_point_vertical;
            min_horizontal = splitting_point_horizontal;
            min_3d = splitting_point_3d;
        elseif strcmp(enter_to, 'down-left-layer2')
            max_vertical = splitting_point_vertical;
            max_horizontal = splitting_point_horizontal;
            min_3d = splitting_point_3d;
        end
    
end % (Error <= 0.1 || iterationNum == 50)  --> should we put error, too? -> I don't think so!

str = sprintf('GlobalBestFitness: %f, GlobalBestCoordinate: (%f,%f,%f)', GlobalBestFitness, GlobalBestCoordinate(1), GlobalBestCoordinate(2), GlobalBestCoordinate(3));
% title(str);

%% Plotting results:
% figure
% plot([bestFitnessArray(4,:) ,GlobalIterationNum], [bestFitnessArray(1,:), bestFitnessArray(1,length(bestFitnessArray(1,:)))]);
% str = sprintf('best fittness found: %f\nbest fitness coordinate found: (%.3f;%.3f)\nbest fitness found in iteration number: %d\nbest fitness found in time: %f seconds', ...
%                 GlobalBestFitness, GlobalBestCoordinate(1,1), GlobalBestCoordinate(2,1), bestFitnessArray(4,length(bestFitnessArray(4,:))), time_betterSolutionFound);
disp('*****************************');
disp(str);
% title(str);
% xlabel('number of iterations');
% ylabel('best (least) found fitness value');

str = sprintf('min_of_z: %f:', min_of_z);
disp(str);
str = sprintf('coordinate of min_of_z: (%f,%f,%f):', x_of_min_of_z, y_of_min_of_z, w_of_min_of_z);
disp(str);

%% Run GA alone on whiole landscape:
cd('./subAlgorithms');
[~, ~, GlobalBestFitness_alone, GlobalBestCoordinate_alone] = GA(x,y,w,z, ParticlesNum, step, x_min, x_max, y_min, y_max, w_min, w_max, GlobalIterationNum_GA, disp_figures_and_results);
cd('..');
disp('*****************************');
disp('Alone GA:');
str = sprintf('GlobalBestFitness: %f, GlobalBestCoordinate: (%f,%f,%f)', GlobalBestFitness_alone, GlobalBestCoordinate_alone(1), GlobalBestCoordinate_alone(2), GlobalBestCoordinate_alone(3));
disp(str);

%% error:
error_TBO = sqrt((GlobalBestCoordinate(1) - x_of_min_of_z)^2 + (GlobalBestCoordinate(2) - y_of_min_of_z)^2 + (GlobalBestCoordinate(3) - w_of_min_of_z)^2);
disp('*****************************');
disp('error of TBO:');
disp(error_TBO);
error_alone = sqrt((GlobalBestCoordinate_alone(1) - x_of_min_of_z)^2 + (GlobalBestCoordinate_alone(2) - y_of_min_of_z)^2 + (GlobalBestCoordinate_alone(3) - w_of_min_of_z)^2);
disp('*****************************');
disp('error of Alone:');
disp(error_alone);


