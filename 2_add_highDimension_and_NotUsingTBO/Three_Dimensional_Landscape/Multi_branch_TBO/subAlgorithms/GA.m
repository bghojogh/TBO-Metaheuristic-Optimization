%% Genetic Algorithm (GA):
function [time_betterSolutionFound, bestFitnessArray, bestFitness, bestFitnessCoordinate] = GA(x,y,w,z, ChromosomsNum, step, x_min, x_max, y_min, y_max, w_min, w_max, GlobalIterationNum, disp_figures_and_results)

tic
%%%%%%% initializations:
bestFitnessCoordinate = zeros(3,1);
bestFitness = 0;
ChromosomeLoc(1,:) = round(x_min + (x_max - x_min)*rand(1,ChromosomsNum));   %%% Chromosome => colomns: Gens, row1: Gen1 (x), row2: Gen2 (y)
ChromosomeLoc(2,:) = round(y_min + (y_max - y_min)*rand(1,ChromosomsNum));
ChromosomeLoc(3,:) = round(w_min + (w_max - w_min)*rand(1,ChromosomsNum));
ChromosomsFitness = zeros(1,ChromosomsNum);
ChromosomeLoc_nextIteration = zeros(size(ChromosomeLoc));
ChromosomsFitness_nextIteration = zeros(1,ChromosomsNum);

%%%%%%% initializations (for plotting):
bestFitnessArray = 0;
betterAnswerFoundFlag = 0;

%%%%%%% global iterations:
for globalIteration = 1:GlobalIterationNum
    betterAnswerFoundFlag = 0;
    
    %%%%%%% iteration to cross over and mutate:
    for i = 1:ChromosomsNum
        
        %%%%%%% updating locations of Particles:
        if globalIteration~=1  
            counter = 0;  % if iteration for finding location in the legal limit, takes long time, drop (break) the loop! ---> necessary for TBO
            while 1
                counter = counter + 1;
                % Proportional Selection:
                [~,index] = sort(ChromosomsFitness, 'descend');  % ranking the chromosoms inversly (because we have cost function)
                %%%% Parent 1:
                probability = 0;
                a_rand = rand;
                for kk = 1:ChromosomsNum
                    last_probability = probability;
                    probability = probability + kk/sum(1:ChromosomsNum);
                    if (a_rand > last_probability) && (a_rand <= probability)
                        parent1_Chromosome = ChromosomeLoc(:,index(kk));
                        parent1_fitness = ChromosomsFitness(:,index(kk));
                    end
                end
                %%%% Parent 2:
                probability = 0;
                a_rand = rand;
                for kk = 1:ChromosomsNum
                    last_probability = probability;
                    probability = probability + kk/sum(1:ChromosomsNum);
                    if (a_rand > last_probability) && (a_rand <= probability)
                        parent2_Chromosome = ChromosomeLoc(:,index(kk));
                        parent2_fitness = ChromosomsFitness(:,index(kk));
                    end
                end

                % floating point cross over => Wighted Avrage:
                Weight_crossOver = 0.75;
                if parent1_fitness <= parent2_fitness  %% if parent1_fitness is better (less) than parent2_fitness
                    child_Chromosome = (Weight_crossOver * parent1_Chromosome) + ((1-Weight_crossOver) * parent2_Chromosome);
                else
                    child_Chromosome = (Weight_crossOver * parent2_Chromosome) + ((1-Weight_crossOver) * parent1_Chromosome);
                end
                if (child_Chromosome(1,1) >= x_min && child_Chromosome(1,1) <= x_max ...
                    && child_Chromosome(2,1) >= y_min && child_Chromosome(2,1) <= y_max ...
                    && child_Chromosome(3,1) >= w_min && child_Chromosome(3,1) <= w_max)
                        break;
                end
                if counter == 200
                    child_Chromosome(1,1) = x_min + (x_max - x_min)*rand;
                    child_Chromosome(2,1) = y_min + (y_max - y_min)*rand;
                    child_Chromosome(3,1) = w_min + (w_max - w_min)*rand;
                    break
                end
            end

            % mutation:
            mutation_probability = 0.2;  % fixed mutation probability, to be simple
            if rand < mutation_probability
                while 1
                    x_temp = floor((x_min + (x_max - x_min)*rand) * (1/step)) / (1/step);  % (floor(number*(1/step))/(1/step)) --> truncates precision of number to step size --> example: step=10 -> precision of number is 0.1
                    y_temp = floor((y_min + (y_max - y_min)*rand) * (1/step)) / (1/step); 
                    w_temp = floor((w_min + (w_max - w_min)*rand) * (1/step)) / (1/step); 
                    a_rand = rand;
                    if a_rand < 0.25
                        child_Chromosome(1,1) = x_temp;   % mutate first gen
                    elseif a_rand < 0.5
                        child_Chromosome(2,1) = y_temp;   % mutate second gen
                    elseif a_rand < 0.75
                        child_Chromosome(3,1) = w_temp;   % mutate third gen
                    else
                        child_Chromosome(1,1) = x_temp;   % mutate all gens
                        child_Chromosome(2,1) = y_temp;
                        child_Chromosome(3,1) = w_temp;
                    end
                    break
                end
            end
            
            % set child as a new population:
            ChromosomeLoc_nextIteration(:,i) = child_Chromosome;
            
            x_Loc = floor(ChromosomeLoc_nextIteration(1,i) * (1/step)) / (1/step);  % (floor(number*(1/step))/(1/step)) --> truncates precision of number to step size --> example: step=10 -> precision of number is 0.1
            y_Loc = floor(ChromosomeLoc_nextIteration(2,i) * (1/step)) / (1/step);
            w_Loc = floor(ChromosomeLoc_nextIteration(3,i) * (1/step)) / (1/step);
            x_Loc_mapped = round(x_Loc / step) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
            y_Loc_mapped = round(y_Loc / step) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
            w_Loc_mapped = round(w_Loc / step) + (((length(w)-1)/2) + 1); % ((length(w)/2) + 1)) is mapping from [-w_min,w_max] to [1,length(w)]
            ChromosomsFitness_nextIteration(i) = z(x_Loc_mapped, y_Loc_mapped, w_Loc_mapped);
            
        else  % if globalIteration == 1
            x_Loc = floor(ChromosomeLoc(1,i) * (1/step)) / (1/step);  % (floor(number*(1/step))/(1/step)) --> truncates precision of number to step size --> example: step=10 -> precision of number is 0.1
            y_Loc = floor(ChromosomeLoc(2,i) * (1/step)) / (1/step);
            w_Loc = floor(ChromosomeLoc(3,i) * (1/step)) / (1/step);
            x_Loc_mapped = round(x_Loc / step) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
            y_Loc_mapped = round(y_Loc / step) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
            w_Loc_mapped = round(w_Loc / step) + (((length(w)-1)/2) + 1); % ((length(w)/2) + 1)) is mapping from [-w_min,w_max] to [1,length(w)]
            ChromosomsFitness(i) = z(x_Loc_mapped, y_Loc_mapped, w_Loc_mapped);
            
        end  
    end
    
    %%%%%%% copying Chromosoms_nextIteration to Chromosoms (changing "Nasl"):
    if globalIteration~=1
        ChromosomeLoc = ChromosomeLoc_nextIteration;
        ChromosomsFitness = ChromosomsFitness_nextIteration;
    end
    
%     ChromosomeLoc
    
    %%%%%%% updating best fitness:
    if globalIteration == 1
        [bestFitness, index_of_best_fitness] = min(ChromosomsFitness);
        bestFitnessCoordinate = ChromosomeLoc(:,index_of_best_fitness);
        time_betterSolutionFound = toc;
        %%%% for plot:
        bestFitnessArray = [bestFitness; bestFitnessCoordinate; globalIteration];
        betterAnswerFoundFlag = 1;
    elseif min(ChromosomsFitness) < bestFitness
        [bestFitness, index_of_best_fitness] = min(ChromosomsFitness);
        bestFitnessCoordinate = ChromosomeLoc(:,index_of_best_fitness);
        time_betterSolutionFound = toc;
        %%%% for plot:
        bestFitnessArray = [bestFitnessArray [bestFitness; bestFitnessCoordinate; globalIteration]];
        betterAnswerFoundFlag = 1;
    end
    
%     %%%%%%% plotting Particles and better Solution on the land scape, when a better solution is found:
%     if disp_figures_and_results == 1
%         %%% plotting Chromosoms
%         if betterAnswerFoundFlag == 1
%             figure
%             surf(x,y,z,'EdgeColor','none','LineStyle','none','FaceLighting','phong');
%             xlabel('x');
%             ylabel('y');
%             zlabel('z');
%             view(0, 90);  % view the surface from directly overhead
%             hold on
%             for index = 1:ChromosomsNum
%                 x_mapped = round(ChromosomeLoc(1,index) / step) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
%                 y_mapped = round(ChromosomeLoc(2,index) / step) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
%                 Point = z(x_mapped,y_mapped) + 100000;
%                 plot3(ChromosomeLoc(1,index),ChromosomeLoc(2,index),Point,'ow', 'MarkerSize', 10, 'MarkerFaceColor', [1,1,1]);
%             end
%             %%% plotting better Solution
%             x_mapped = round(bestFitnessCoordinate(1,1)) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
%             y_mapped = round(bestFitnessCoordinate(2,1)) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
%             Point = z(x_mapped,y_mapped) + 1000;
%             plot3(bestFitnessCoordinate(1,1),bestFitnessCoordinate(2,1),Point,'hw', 'MarkerSize', 10, 'MarkerFaceColor', [1,1,1]);
%             %%% title of plot
%             str = sprintf('Better Solution found in iteration: %d\nBetter Solution: %f\nLocation of better solution: (%.3f;%.3f)\ntime: %f seconds', ...
%                             globalIteration, bestFitness, bestFitnessCoordinate(1,1), bestFitnessCoordinate(2,1), time_betterSolutionFound);
%             title(str);
%             %legend('Particle', 'Better Solution');
%             hold off
%         end
%     end
    
end % (Error <= 0.1 || iterationNum == 50)  --> should we put error, too? -> I don't think so!

%% Plotting results:
if disp_figures_and_results == 1
    figure
    plot([bestFitnessArray(4,:) ,GlobalIterationNum], [bestFitnessArray(1,:), bestFitnessArray(1,length(bestFitnessArray(1,:)))]);
    str = sprintf('best fittness found: %f\nbest fitness coordinate found: (%.3f;%.3f)\nbest fitness found in iteration number: %d\nbest fitness found in time: %f seconds', ...
                    bestFitness, bestFitnessCoordinate(1,1), bestFitnessCoordinate(2,1), bestFitnessArray(4,length(bestFitnessArray(4,:))), time_betterSolutionFound);
    disp(str);
    title(str);
    xlabel('number of iterations');
    ylabel('best (least) found fitness value');
end

end