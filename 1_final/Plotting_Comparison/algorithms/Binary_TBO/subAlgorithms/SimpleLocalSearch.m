function [GlobalBestFitness, GlobalBestCoordinate] = SimpleLocalSearch(ParticlesNum, x, y, z, x_min, x_max, y_min, y_max, step, iterationLocalSearch)

    %%%%%%% initializations:
    neighborhoodLocalSearch = 15;
    ParticleLoc(1,:) = round(x_min + (x_max - x_min)*rand(1,ParticlesNum));
    ParticleLoc(2,:) = round(y_min + (y_max - y_min)*rand(1,ParticlesNum));

    %%%%%%% job of every Particle:
    for i = 1:ParticlesNum
        %%%%%%% Local Search:
        for k = 1:iterationLocalSearch
            if ParticleLoc(1,i) - neighborhoodLocalSearch < x_min
                x_rand_min = x_min;
            else
                x_rand_min = ParticleLoc(1,i) - neighborhoodLocalSearch;
            end
            if ParticleLoc(1,i) + neighborhoodLocalSearch > x_max
                x_rand_max = x_max;
            else
                x_rand_max = ParticleLoc(1,i) + neighborhoodLocalSearch;
            end
            if ParticleLoc(2,i) - neighborhoodLocalSearch < y_min
                y_rand_min = y_min;
            else
                y_rand_min = ParticleLoc(2,i) - neighborhoodLocalSearch;
            end
            if ParticleLoc(2,i) + neighborhoodLocalSearch > y_max
                y_rand_max = y_max;
            else
                y_rand_max = ParticleLoc(2,i) + neighborhoodLocalSearch;
            end
            x_rand = floor((x_rand_min + (x_rand_max - x_rand_min)*rand) * (1/step)) / (1/step);  % (floor(number*(1/step))/(1/step)) --> truncates precision of number to step size --> example: step=10 -> precision of number is 0.1
            y_rand = floor((y_rand_min + (y_rand_max - y_rand_min)*rand) * (1/step)) / (1/step);
            x_rand_mapped = round(x_rand / step) + (((length(x)-1)/2) + 1); % ((length(x)/2) + 1)) is mapping from [-x_min,x_max] to [1,length(x)]
            y_rand_mapped = round(y_rand / step) + (((length(y)-1)/2) + 1); % ((length(y)/2) + 1)) is mapping from [-y_min,y_max] to [1,length(y)]
            fitness = z(x_rand_mapped, y_rand_mapped); 
            %%% updating global best:
            if (i == 1 && k == 1) %% if first particle in first iteration of all
                GlobalBestFitness = fitness;
                GlobalBestCoordinate = [x_rand; y_rand];
                %%%% for plot:
%                 bestFitnessArray = [GlobalBestFitness; GlobalBestCoordinate; globalIteration];
%                 betterAnswerFoundFlag = 1;
            elseif fitness < GlobalBestFitness
                GlobalBestFitness = fitness;
                GlobalBestCoordinate = [x_rand; y_rand];
                %%%% for plot:
%                 bestFitnessArray = [bestFitnessArray [GlobalBestFitness; GlobalBestCoordinate; globalIteration]];
%                 betterAnswerFoundFlag = 1;
            end
        end
    end
end