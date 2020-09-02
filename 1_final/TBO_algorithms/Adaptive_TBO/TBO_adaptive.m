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
        if globalIteration == 1
            L1_vertical = min_vertical + 0.1*(max_vertical - min_vertical);
            L2_vertical = min_vertical + 0.2*(max_vertical - min_vertical);
            splitting_point = L1_vertical + (L2_vertical - L1_vertical)*rand;
            L1_vertical = min_vertical + 0.3*(max_vertical - min_vertical);
            L2_vertical = min_vertical + 0.7*(max_vertical - min_vertical);
            splitting_point2 = L1_vertical + (L2_vertical - L1_vertical)*rand;
            L1_vertical = min_vertical + 0.8*(max_vertical - min_vertical);
            L2_vertical = min_vertical + 0.9*(max_vertical - min_vertical);
            splitting_point3 = L1_vertical + (L2_vertical - L1_vertical)*rand;
        elseif globalIteration == 2
            L1_vertical = min_vertical + 0.2*(max_vertical - min_vertical);
            L2_vertical = min_vertical + 0.4*(max_vertical - min_vertical);
            splitting_point = L1_vertical + (L2_vertical - L1_vertical)*rand;
            L1_vertical = min_vertical + 0.5*(max_vertical - min_vertical);
            L2_vertical = min_vertical + 0.7*(max_vertical - min_vertical);
            splitting_point2 = L1_vertical + (L2_vertical - L1_vertical)*rand;
        else
            L1_vertical = min_vertical + 0.3*(max_vertical - min_vertical);
            L2_vertical = min_vertical + 0.7*(max_vertical - min_vertical);
            splitting_point = L1_vertical + (L2_vertical - L1_vertical)*rand;
        end
    else
        if globalIteration == 1
            L1_horizontal = min_horizontal + 0.1*(max_horizontal - min_horizontal);
            L2_horizontal = min_horizontal + 0.2*(max_horizontal - min_horizontal);
            splitting_point = L1_horizontal + (L2_horizontal - L1_horizontal)*rand;
            L1_horizontal = min_horizontal + 0.3*(max_horizontal - min_horizontal);
            L2_horizontal = min_horizontal + 0.7*(max_horizontal - min_horizontal);
            splitting_poin2 = L1_horizontal + (L2_horizontal - L1_horizontal)*rand;
            L1_horizontal = min_horizontal + 0.8*(max_horizontal - min_horizontal);
            L2_horizontal = min_horizontal + 0.9*(max_horizontal - min_horizontal);
            splitting_poin3 = L1_horizontal + (L2_horizontal - L1_horizontal)*rand;
        elseif globalIteration == 2   
            L1_horizontal = min_horizontal + 0.2*(max_horizontal - min_horizontal);
            L2_horizontal = min_horizontal + 0.4*(max_horizontal - min_horizontal);
            splitting_point = L1_horizontal + (L2_horizontal - L1_horizontal)*rand;
            L1_horizontal = min_horizontal + 0.5*(max_horizontal - min_horizontal);
            L2_horizontal = min_horizontal + 0.7*(max_horizontal - min_horizontal);
            splitting_poin2 = L1_horizontal + (L2_horizontal - L1_horizontal)*rand;
        else
            L1_horizontal = min_horizontal + 0.3*(max_horizontal - min_horizontal);
            L2_horizontal = min_horizontal + 0.7*(max_horizontal - min_horizontal);
            splitting_point = L1_horizontal + (L2_horizontal - L1_horizontal)*rand;
        end
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
        if globalIteration == 1
            plot3([splitting_point, splitting_point],[min_horizontal, max_horizontal],temp_height,'-w', 'LineWidth', 3, 'MarkerFaceColor', [1,1,1]);
            plot3([splitting_point2, splitting_point2],[min_horizontal, max_horizontal],temp_height,'-w', 'LineWidth', 3, 'MarkerFaceColor', [1,1,1]);
            plot3([splitting_point3, splitting_point3],[min_horizontal, max_horizontal],temp_height,'-w', 'LineWidth', 3, 'MarkerFaceColor', [1,1,1]);
        elseif globalIteration == 2
            plot3([splitting_point, splitting_point],[min_horizontal, max_horizontal],temp_height,'-w', 'LineWidth', 3, 'MarkerFaceColor', [1,1,1]);
            plot3([splitting_point2, splitting_point2],[min_horizontal, max_horizontal],temp_height,'-w', 'LineWidth', 3, 'MarkerFaceColor', [1,1,1]);
        else
            plot3([splitting_point, splitting_point],[min_horizontal, max_horizontal],temp_height,'-w', 'LineWidth', 3, 'MarkerFaceColor', [1,1,1]);
        end
    else
        if globalIteration == 1
            plot3([min_vertical, max_vertical],[splitting_point, splitting_point],temp_height,'-w', 'LineWidth', 3, 'MarkerFaceColor', [1,1,1]);
            plot3([min_vertical, max_vertical],[splitting_point2, splitting_point2],temp_height,'-w', 'LineWidth', 3, 'MarkerFaceColor', [1,1,1]);
            plot3([min_vertical, max_vertical],[splitting_point3, splitting_point3],temp_height,'-w', 'LineWidth', 3, 'MarkerFaceColor', [1,1,1]);
        elseif globalIteration == 2
            plot3([min_vertical, max_vertical],[splitting_point, splitting_point],temp_height,'-w', 'LineWidth', 3, 'MarkerFaceColor', [1,1,1]);
            plot3([min_vertical, max_vertical],[splitting_point2, splitting_point2],temp_height,'-w', 'LineWidth', 3, 'MarkerFaceColor', [1,1,1]);
        else
            plot3([min_vertical, max_vertical],[splitting_point, splitting_point],temp_height,'-w', 'LineWidth', 3, 'MarkerFaceColor', [1,1,1]);
        end
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
            if globalIteration == 1
                cd('./subAlgorithms');
                %%%% region 1:
                [GlobalBestFitness_4, GlobalBestCoordinate_4] = SimpleLocalSearch(ParticlesNum, x, y, z, splitting_point3, max_vertical, min_horizontal, max_horizontal, step, iterationLocalSearch_simpleLocalSearch);
                %%%% region 2:
                [GlobalBestFitness_3, GlobalBestCoordinate_3] = SimpleLocalSearch(ParticlesNum, x, y, z, splitting_point2, splitting_point3, min_horizontal, max_horizontal, step, iterationLocalSearch_simpleLocalSearch);
                %%%% region 3:
                [GlobalBestFitness_2, GlobalBestCoordinate_2] = SimpleLocalSearch(ParticlesNum, x, y, z, splitting_point, splitting_point2, min_horizontal, max_horizontal, step, iterationLocalSearch_simpleLocalSearch);
                %%%% region 4:
                [GlobalBestFitness_1, GlobalBestCoordinate_1] = SimpleLocalSearch(ParticlesNum, x, y, z, min_vertical, splitting_point, min_horizontal, max_horizontal, step, iterationLocalSearch_simpleLocalSearch);
                cd('..');
            elseif globalIteration == 2
                cd('./subAlgorithms');
                %%%% region 1:
                [GlobalBestFitness_3, GlobalBestCoordinate_3] = SimpleLocalSearch(ParticlesNum, x, y, z, splitting_point2, max_vertical, min_horizontal, max_horizontal, step, iterationLocalSearch_simpleLocalSearch);
                %%%% region 2:
                [GlobalBestFitness_2, GlobalBestCoordinate_2] = SimpleLocalSearch(ParticlesNum, x, y, z, splitting_point, splitting_point2, min_horizontal, max_horizontal, step, iterationLocalSearch_simpleLocalSearch);
                %%%% region 3:
                [GlobalBestFitness_1, GlobalBestCoordinate_1] = SimpleLocalSearch(ParticlesNum, x, y, z, min_vertical, splitting_point, min_horizontal, max_horizontal, step, iterationLocalSearch_simpleLocalSearch);
                cd('..');
            else
                cd('./subAlgorithms');
                %%%% right region:
                [GlobalBestFitness_1, GlobalBestCoordinate_1] = SimpleLocalSearch(ParticlesNum, x, y, z, splitting_point, max_vertical, min_horizontal, max_horizontal, step, iterationLocalSearch_simpleLocalSearch);
                %%%% left region:
                [GlobalBestFitness_2, GlobalBestCoordinate_2] = SimpleLocalSearch(ParticlesNum, x, y, z, min_vertical, splitting_point, min_horizontal, max_horizontal, step, iterationLocalSearch_simpleLocalSearch);
                cd('..');
            end
        elseif sub_algorithm == 2
            if globalIteration == 1
                cd('./subAlgorithms');
                %%%% region 1:
                [~, ~, GlobalBestFitness_4, GlobalBestCoordinate_4] = PSO(x,y,z, ParticlesNum, step, splitting_point3, max_vertical, min_horizontal, max_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                %%%% region 2:
                [~, ~, GlobalBestFitness_3, GlobalBestCoordinate_3] = PSO(x,y,z, ParticlesNum, step, splitting_point2, splitting_point3, min_horizontal, max_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                %%%% region 3:
                [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = PSO(x,y,z, ParticlesNum, step, splitting_point, splitting_point2, min_horizontal, max_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                %%%% region 4:
                [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = PSO(x,y,z, ParticlesNum, step, min_vertical, splitting_point, min_horizontal, max_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                cd('..');
            elseif globalIteration == 2
                cd('./subAlgorithms');
                %%%% region 1:
                [~, ~, GlobalBestFitness_3, GlobalBestCoordinate_3] = PSO(x,y,z, ParticlesNum, step, splitting_point2, max_vertical, min_horizontal, max_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                %%%% region 2:
                [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = PSO(x,y,z, ParticlesNum, step, splitting_point, splitting_point2, min_horizontal, max_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                %%%% region 3:
                [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = PSO(x,y,z, ParticlesNum, step, min_vertical, splitting_point, min_horizontal, max_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                cd('..');
            else
                cd('./subAlgorithms');
                %%%% right region:
                [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = PSO(x,y,z, ParticlesNum, step, splitting_point, max_vertical, min_horizontal, max_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                %%%% left region:
                [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = PSO(x,y,z, ParticlesNum, step, min_vertical, splitting_point, min_horizontal, max_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                cd('..');
            end
        elseif sub_algorithm == 3
            if globalIteration == 1
                cd('./subAlgorithms');
                %%%% region 1:
                [~, ~, GlobalBestFitness_4, GlobalBestCoordinate_4] = GA(x,y,z, ParticlesNum, step, splitting_point3, max_vertical, min_horizontal, max_horizontal, GlobalIterationNum_GA, disp_figures_and_results);
                %%%% region 2:
                [~, ~, GlobalBestFitness_3, GlobalBestCoordinate_3] = GA(x,y,z, ParticlesNum, step, splitting_point2, splitting_point3, min_horizontal, max_horizontal, GlobalIterationNum_GA, disp_figures_and_results);
                %%%% region 3:
                [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = GA(x,y,z, ParticlesNum, step, splitting_point, splitting_point2, min_horizontal, max_horizontal, GlobalIterationNum_GA, disp_figures_and_results);
                %%%% region 4:
                [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = GA(x,y,z, ParticlesNum, step, min_vertical, splitting_point, min_horizontal, max_horizontal, GlobalIterationNum_GA, disp_figures_and_results);
                cd('..');
            elseif globalIteration == 2
                cd('./subAlgorithms');
                %%%% region 1:
                [~, ~, GlobalBestFitness_3, GlobalBestCoordinate_3] = GA(x,y,z, ParticlesNum, step, splitting_point2, max_vertical, min_horizontal, max_horizontal, GlobalIterationNum_GA, disp_figures_and_results);
                %%%% region 2:
                [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = GA(x,y,z, ParticlesNum, step, splitting_point, splitting_point2, min_horizontal, max_horizontal, GlobalIterationNum_GA, disp_figures_and_results);
                %%%% region 3:
                [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = GA(x,y,z, ParticlesNum, step, min_vertical, splitting_point, min_horizontal, max_horizontal, GlobalIterationNum_GA, disp_figures_and_results);
                cd('..');
            else
                cd('./subAlgorithms');
                %%%% right region:
                [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = GA(x,y,z, ParticlesNum, step, splitting_point, max_vertical, min_horizontal, max_horizontal, GlobalIterationNum_GA, disp_figures_and_results);
                %%%% left region:
                [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = GA(x,y,z, ParticlesNum, step, min_vertical, splitting_point, min_horizontal, max_horizontal, GlobalIterationNum_GA, disp_figures_and_results);
                cd('..');
            end
        end
    else
        if sub_algorithm == 1
            if globalIteration == 1
                cd('./subAlgorithms');
                %%%% region 1:
                [GlobalBestFitness_4, GlobalBestCoordinate_4] = SimpleLocalSearch(ParticlesNum, x, y, z, min_vertical, max_vertical, splitting_point3, max_horizontal, step, iterationLocalSearch_simpleLocalSearch);
                %%%% region 2:
                [GlobalBestFitness_3, GlobalBestCoordinate_3] = SimpleLocalSearch(ParticlesNum, x, y, z, min_vertical, max_vertical, splitting_point2, splitting_point3, step, iterationLocalSearch_simpleLocalSearch);
                %%%% region 3:
                [GlobalBestFitness_2, GlobalBestCoordinate_2] = SimpleLocalSearch(ParticlesNum, x, y, z, min_vertical, max_vertical, splitting_point, splitting_point2, step, iterationLocalSearch_simpleLocalSearch);
                %%%% region 4:
                [GlobalBestFitness_1, GlobalBestCoordinate_1] = SimpleLocalSearch(ParticlesNum, x, y, z, min_vertical, max_vertical, min_horizontal, splitting_point, step, iterationLocalSearch_simpleLocalSearch);
                cd('..');
            elseif globalIteration == 2
                cd('./subAlgorithms');
                %%%% region 1:
                [GlobalBestFitness_3, GlobalBestCoordinate_3] = SimpleLocalSearch(ParticlesNum, x, y, z, min_vertical, max_vertical, splitting_point2, max_horizontal, step, iterationLocalSearch_simpleLocalSearch);
                %%%% region 2:
                [GlobalBestFitness_2, GlobalBestCoordinate_2] = SimpleLocalSearch(ParticlesNum, x, y, z, min_vertical, max_vertical, splitting_point, splitting_point2, step, iterationLocalSearch_simpleLocalSearch);
                %%%% region 3:
                [GlobalBestFitness_1, GlobalBestCoordinate_1] = SimpleLocalSearch(ParticlesNum, x, y, z, min_vertical, max_vertical, min_horizontal, splitting_point, step, iterationLocalSearch_simpleLocalSearch);
                cd('..');
            else
                cd('./subAlgorithms');
                %%%% up region:
                [GlobalBestFitness_1, GlobalBestCoordinate_1] = SimpleLocalSearch(ParticlesNum, x, y, z, min_vertical, max_vertical, splitting_point, max_horizontal, step, iterationLocalSearch_simpleLocalSearch);
                %%%% down region:
                [GlobalBestFitness_2, GlobalBestCoordinate_2] = SimpleLocalSearch(ParticlesNum, x, y, z, min_vertical, max_vertical, min_horizontal, splitting_point, step, iterationLocalSearch_simpleLocalSearch);
                cd('..');
            end
        elseif sub_algorithm == 2
            if globalIteration == 1
                cd('./subAlgorithms');
                %%%% region 1:
                [~, ~, GlobalBestFitness_4, GlobalBestCoordinate_4] = PSO(x,y,z, ParticlesNum, step, min_vertical, max_vertical, splitting_point3, max_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                %%%% region 2:
                [~, ~, GlobalBestFitness_3, GlobalBestCoordinate_3] = PSO(x,y,z, ParticlesNum, step, min_vertical, max_vertical, splitting_point2, splitting_point3, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                %%%% region 3:
                [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = PSO(x,y,z, ParticlesNum, step, min_vertical, max_vertical, splitting_point, splitting_point2, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                %%%% region 4:
                [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = PSO(x,y,z, ParticlesNum, step, min_vertical, max_vertical, min_horizontal, splitting_point, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                cd('..');
            elseif globalIteration == 2
                cd('./subAlgorithms');
                %%%% region 1:
                [~, ~, GlobalBestFitness_3, GlobalBestCoordinate_3] = PSO(x,y,z, ParticlesNum, step, min_vertical, max_vertical, splitting_point2, max_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                %%%% region 2:
                [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = PSO(x,y,z, ParticlesNum, step, min_vertical, max_vertical, splitting_point, splitting_point2, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                %%%% region 3:
                [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = PSO(x,y,z, ParticlesNum, step, min_vertical, max_vertical, min_horizontal, splitting_point, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                cd('..');
            else
                cd('./subAlgorithms');
                %%%% up region:
                [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = PSO(x,y,z, ParticlesNum, step, min_vertical, max_vertical, splitting_point, max_horizontal, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                %%%% down region:
                [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = PSO(x,y,z, ParticlesNum, step, min_vertical, max_vertical, min_horizontal, splitting_point, GlobalIterationNum_PSO, iterationLocalSearch_PSO, disp_figures_and_results);
                cd('..');
            end
        elseif sub_algorithm == 3
            if globalIteration == 1
                cd('./subAlgorithms');
                %%%% region 1:
                [~, ~, GlobalBestFitness_4, GlobalBestCoordinate_4] = GA(x,y,z, ParticlesNum, step, min_vertical, max_vertical, splitting_point3, max_horizontal, GlobalIterationNum_GA, disp_figures_and_results);
                %%%% region 2:
                [~, ~, GlobalBestFitness_3, GlobalBestCoordinate_3] = GA(x,y,z, ParticlesNum, step, min_vertical, max_vertical, splitting_point2, splitting_point3, GlobalIterationNum_GA, disp_figures_and_results);
                %%%% region 3:
                [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = GA(x,y,z, ParticlesNum, step, min_vertical, max_vertical, splitting_point, splitting_point2, GlobalIterationNum_GA, disp_figures_and_results);
                %%%% region 4:
                [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = GA(x,y,z, ParticlesNum, step, min_vertical, max_vertical, min_horizontal, splitting_point, GlobalIterationNum_GA, disp_figures_and_results);
                cd('..');
            elseif globalIteration == 2
                cd('./subAlgorithms');
                %%%% region 1:
                [~, ~, GlobalBestFitness_3, GlobalBestCoordinate_3] = GA(x,y,z, ParticlesNum, step, min_vertical, max_vertical, splitting_point2, max_horizontal, GlobalIterationNum_GA, disp_figures_and_results);
                %%%% region 2:
                [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = GA(x,y,z, ParticlesNum, step, min_vertical, max_vertical, splitting_point, splitting_point2, GlobalIterationNum_GA, disp_figures_and_results);
                %%%% region 3:
                [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = GA(x,y,z, ParticlesNum, step, min_vertical, max_vertical, min_horizontal, splitting_point, GlobalIterationNum_GA, disp_figures_and_results);
                cd('..');
            else
                cd('./subAlgorithms');
                %%%% up region:
                [~, ~, GlobalBestFitness_1, GlobalBestCoordinate_1] = GA(x,y,z, ParticlesNum, step, min_vertical, max_vertical, splitting_point, max_horizontal, GlobalIterationNum_GA, disp_figures_and_results);
                %%%% down region:
                [~, ~, GlobalBestFitness_2, GlobalBestCoordinate_2] = GA(x,y,z, ParticlesNum, step, min_vertical, max_vertical, min_horizontal, splitting_point, GlobalIterationNum_GA, disp_figures_and_results);
                cd('..');
            end
        end
    end
    
    %%%%%%% updating global best, if better answer has been found:
    if globalIteration == 1
        [GlobalBestFitness, index] = min([GlobalBestFitness_1, GlobalBestFitness_2, GlobalBestFitness_3, GlobalBestFitness_4]);
        switch index
            case 1
                GlobalBestCoordinate = GlobalBestCoordinate_1;
            case 2
                GlobalBestCoordinate = GlobalBestCoordinate_2;
            case 3
                GlobalBestCoordinate = GlobalBestCoordinate_3;
            case 4
                GlobalBestCoordinate = GlobalBestCoordinate_4;
        end
        %%%% for plot:
        bestFitnessArray = [GlobalBestFitness; GlobalBestCoordinate; globalIteration];
    elseif globalIteration == 2
        if GlobalBestFitness > min([GlobalBestFitness_1, GlobalBestFitness_2, GlobalBestFitness_3])
            [GlobalBestFitness, index] = min([GlobalBestFitness_1, GlobalBestFitness_2, GlobalBestFitness_3]);
            switch index
                case 1
                    GlobalBestCoordinate = GlobalBestCoordinate_1;
                case 2
                    GlobalBestCoordinate = GlobalBestCoordinate_2;
                case 3
                    GlobalBestCoordinate = GlobalBestCoordinate_3;
            end
            %%%% for plot:
            bestFitnessArray = [bestFitnessArray [GlobalBestFitness; GlobalBestCoordinate; globalIteration]];
        end
    else
        if GlobalBestFitness > min(GlobalBestFitness_1, GlobalBestFitness_2)
            GlobalBestFitness = min(GlobalBestFitness_1, GlobalBestFitness_2);
            if GlobalBestFitness_1 < GlobalBestFitness_2
                GlobalBestCoordinate = GlobalBestCoordinate_1;
            else
                GlobalBestCoordinate = GlobalBestCoordinate_2;
            end
            %%%% for plot:
            bestFitnessArray = [bestFitnessArray [GlobalBestFitness; GlobalBestCoordinate; globalIteration]];
        end
    end
        
    %%%%%%% enter a region:
    if globalIteration == 1
        if (GlobalBestFitness_1 > 0) && (GlobalBestFitness_2 > 0) && (GlobalBestFitness_3 > 0) && (GlobalBestFitness_4 > 0)
            Probability1 = GlobalBestFitness_1 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4);
            Probability2 = GlobalBestFitness_2 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4);
            Probability3 = GlobalBestFitness_3 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4);
            Probability4 = GlobalBestFitness_4 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4);
            Probability1 = 1 - Probability1; %% because we are finding minimum and not maximum!
            Probability2 = 1 - Probability2; %% because we are finding minimum and not maximum!
            Probability3 = 1 - Probability3; %% because we are finding minimum and not maximum!
            Probability4 = 1 - Probability4; %% because we are finding minimum and not maximum!
        elseif (GlobalBestFitness_1 < 0) && (GlobalBestFitness_2 < 0) && (GlobalBestFitness_3 < 0) && (GlobalBestFitness_4 < 0)
            Probability1 = GlobalBestFitness_1 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4);
            Probability2 = GlobalBestFitness_2 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4);
            Probability3 = GlobalBestFitness_3 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4);
            Probability4 = GlobalBestFitness_4 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4);
        else
            GlobalBestFitness_1 = GlobalBestFitness_1 + abs(min([GlobalBestFitness_1, GlobalBestFitness_2, GlobalBestFitness_3, GlobalBestFitness_4])) + 1;
            GlobalBestFitness_2 = GlobalBestFitness_2 + abs(min([GlobalBestFitness_1, GlobalBestFitness_2, GlobalBestFitness_3, GlobalBestFitness_4])) + 1;
            GlobalBestFitness_3 = GlobalBestFitness_3 + abs(min([GlobalBestFitness_1, GlobalBestFitness_2, GlobalBestFitness_3, GlobalBestFitness_4])) + 1;
            GlobalBestFitness_4 = GlobalBestFitness_4 + abs(min([GlobalBestFitness_1, GlobalBestFitness_2, GlobalBestFitness_3, GlobalBestFitness_4])) + 1;
            Probability1 = GlobalBestFitness_1 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4);
            Probability2 = GlobalBestFitness_2 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4);
            Probability3 = GlobalBestFitness_3 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4);
            Probability4 = GlobalBestFitness_4 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3 + GlobalBestFitness_4);
            Probability1 = 1 - Probability1; %% because we are finding minimum and not maximum!
            Probability2 = 1 - Probability2; %% because we are finding minimum and not maximum!
            Probability3 = 1 - Probability3; %% because we are finding minimum and not maximum!
            Probability4 = 1 - Probability4; %% because we are finding minimum and not maximum!
        end
        
        [a,b] = sort([Probability1, Probability2, Probability3, Probability4],'descend');
        while 1
            a_rand = rand;
            if a_rand < a(1)
                switch b(1)
                    case 1  % it is probability1
                        enter_to = 'region1';
                    case 2  % it is probability2
                        enter_to = 'region2';
                    case 3  % it is probability3
                        enter_to = 'region3';
                    case 4  % it is probability4
                        enter_to = 'region4';
                end
            break;
            else
                a_rand = rand;
                if a_rand < a(2)
                    switch b(2)
                        case 1  % it is probability1
                            enter_to = 'region1';
                        case 2  % it is probability2
                            enter_to = 'region2';
                        case 3  % it is probability3
                            enter_to = 'region3';
                        case 4  % it is probability4
                            enter_to = 'region4';
                    end
                break;
                else
                    a_rand = rand;
                    if a_rand < a(3)
                        switch b(3)
                            case 1  % it is probability1
                                enter_to = 'region1';
                            case 2  % it is probability2
                                enter_to = 'region2';
                            case 3  % it is probability3
                                enter_to = 'region3';
                            case 4  % it is probability4
                                enter_to = 'region4';
                        end
                    break;
                    else
                        a_rand = rand;
                        if a_rand < a(4)
                            switch b(4)
                                case 1  % it is probability1
                                    enter_to = 'region1';
                                case 2  % it is probability2
                                    enter_to = 'region2';
                                case 3  % it is probability3
                                    enter_to = 'region3';
                                case 4  % it is probability4
                                    enter_to = 'region4';
                            end
                            break;
                        end
                    end
                end 
            end
        end
        %%--------------------------------------------------
    elseif globalIteration == 2
        if (GlobalBestFitness_1 > 0) && (GlobalBestFitness_2 > 0) && (GlobalBestFitness_3 > 0)
            Probability1 = GlobalBestFitness_1 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3);
            Probability2 = GlobalBestFitness_2 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3);
            Probability3 = GlobalBestFitness_3 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3);
            Probability1 = 1 - Probability1; %% because we are finding minimum and not maximum!
            Probability2 = 1 - Probability2; %% because we are finding minimum and not maximum!
            Probability3 = 1 - Probability3; %% because we are finding minimum and not maximum!
        elseif (GlobalBestFitness_1 < 0) && (GlobalBestFitness_2 < 0) && (GlobalBestFitness_3 < 0)
            Probability1 = GlobalBestFitness_1 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3);
            Probability2 = GlobalBestFitness_2 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3);
            Probability3 = GlobalBestFitness_3 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3);
        else
            GlobalBestFitness_1 = GlobalBestFitness_1 + abs(min([GlobalBestFitness_1, GlobalBestFitness_2, GlobalBestFitness_3])) + 1;
            GlobalBestFitness_2 = GlobalBestFitness_2 + abs(min([GlobalBestFitness_1, GlobalBestFitness_2, GlobalBestFitness_3])) + 1;
            GlobalBestFitness_3 = GlobalBestFitness_3 + abs(min([GlobalBestFitness_1, GlobalBestFitness_2, GlobalBestFitness_3])) + 1;
            Probability1 = GlobalBestFitness_1 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3);
            Probability2 = GlobalBestFitness_2 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3);
            Probability3 = GlobalBestFitness_3 / (GlobalBestFitness_1 + GlobalBestFitness_2 + GlobalBestFitness_3);
            Probability1 = 1 - Probability1; %% because we are finding minimum and not maximum!
            Probability2 = 1 - Probability2; %% because we are finding minimum and not maximum!
            Probability3 = 1 - Probability3; %% because we are finding minimum and not maximum!
        end
        
        [a,b] = sort([Probability1, Probability2, Probability3],'descend');
        while 1
            a_rand = rand;
            if a_rand < a(1)
                switch b(1)
                    case 1  % it is probability1
                        enter_to = 'region1';
                    case 2  % it is probability2
                        enter_to = 'region2';
                    case 3  % it is probability3
                        enter_to = 'region3';
                end
            break;
            else
                a_rand = rand;
                if a_rand < a(2)
                    switch b(2)
                        case 1  % it is probability1
                            enter_to = 'region1';
                        case 2  % it is probability2
                            enter_to = 'region2';
                        case 3  % it is probability3
                            enter_to = 'region3';
                    end
                break;
                else
                    a_rand = rand;
                    if a_rand < a(3)
                        switch b(3)
                            case 1  % it is probability1
                                enter_to = 'region1';
                            case 2  % it is probability2
                                enter_to = 'region2';
                            case 3  % it is probability3
                                enter_to = 'region3';
                        end
                        break;
                    end
                end 
            end
        end
        %%--------------------------------------------------
    else
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
        
    end
    
    %%%%%%% updating the limits of vertical and horizontal regions:
    if globalIteration == 1
        if strcmp(split_type, 'vertical')
            if strcmp(enter_to, 'region1')
                max_vertical = splitting_point;
            elseif strcmp(enter_to, 'region2')
                min_vertical = splitting_point;
                max_vertical = splitting_point2;
            elseif strcmp(enter_to, 'region3')
                min_vertical = splitting_point2;
                max_vertical = splitting_point3;
            elseif strcmp(enter_to, 'region4')
                min_vertical = splitting_point3;
            end
        else
            if strcmp(enter_to, 'region1')
                max_horizontal = splitting_point;
            elseif strcmp(enter_to, 'region2')
                min_horizontal = splitting_point;
                max_horizontal = splitting_point2;
            elseif strcmp(enter_to, 'region3')
                min_horizontal = splitting_point2;
                max_horizontal = splitting_point3;
            elseif strcmp(enter_to, 'region4')
                min_horizontal = splitting_point3;
            end
        end
    elseif globalIteration == 2
        if strcmp(split_type, 'vertical')
            if strcmp(enter_to, 'region1')
                max_vertical = splitting_point;
            elseif strcmp(enter_to, 'region2')
                min_vertical = splitting_point;
                max_vertical = splitting_point2;
            elseif strcmp(enter_to, 'region3')
                min_vertical = splitting_point2;
            end
        else
            if strcmp(enter_to, 'region1')
                max_horizontal = splitting_point;
            elseif strcmp(enter_to, 'region2')
                min_horizontal = splitting_point;
                max_horizontal = splitting_point2;
            elseif strcmp(enter_to, 'region3')
                min_horizontal = splitting_point2;
            end
        end
    else
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

