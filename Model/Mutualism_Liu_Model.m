%{
    Iris Liu
    CS446 
    Fall 2020
    Agent-based Mutualism in Space
    To run: Type script name in command line
%}

%% Timestep
timestep = 1;
totalsteps = 365*2;

%% Global Constant Values

% environment related
max_wind_speed = 5;                 % maximum wind velocity
max_pollination_success_rate = 1.0; % maximum pollination success rate
prob_disturb = 0.01;                % the probability of wind disturbance in animal movements

% animal related
num_eggs = 10;                      % number of eggs each female animal lays
prob_egg_survival = 0.83;           % survival probability of each egg
best_temp_seed = 25;                % best temperature for growth of the seed
visit_capacity = 5;                % visiting capacity of each animal

% plant related
plant_maturity_date = 180;          % the maturity date when the plant produces seeds
seed_period = 60;                   % the number of days the plant can produce seeds
seed_stage = 60;                    % the number of days before a seed becomes a plant
prob_landing = 0.03;                % the probability of the seed successfully landing
prob_seed_survival = 1;             % the probability of seed survival
best_temp_egg = 25;                 % best temperature for hatching of the animals
prob_pollen = 0.95;                 % the probability of the pollen production rate

%% Initial Conditions
init_size = 40;         % initial landscape size n x n
init_num_animal = 20;   % initial number of animals
init_num_plant = 100;   % initial number of plant clusters
init_cluster_size = 20;  % initial maximum cluster_size

%% Environment Array Index
envir_length = 8;       % num of parameters of the environment

num_animal = 1;         % 1: num of animals
num_plant = 2;          % 2: num of plants
wind_angle = 3;         % 3: wind angle
wind_speed = 4;         % 4: wind velocity
num_pollinated = 5;     % 5: pollination
num_egg = 6;            % 6: num of eggs
num_seed = 7;           % 7: num of seeds
temp = 8;               % 8: num of seeds

%% Animal Array Index
animal_length = 5;      % num of parameters of an animal

animal_sex = 1;         % 0: female/male
animal_age = 2;         % 1: animal age
animal_x = 3;           % 2: animal x position
animal_y = 4;           % 3: animal y position
animal_alive = 5;       % 4: animal alive/dead

%% Plant Array Index
plant_length = 6;       % num of parameters of a plant

pollinated = 1;         % 1: unpollinated/pollinated
plant_age = 2;          % 2: plant age
plant_x = 3;            % 3: plant x position
plant_y = 4;            % 4: plant y position
plant_alive = 5;        % 5: plant alive/dead
plant_size = 6;         % 6: plant cluster size

%% Pollen Array Index
pollen_length = 2;

pollen_x = 1;           % 1: pollen x position
pollen_y = 2;           % 2: pollen y position

%% Helper Array Index
helper_length = 3;      % num of parameters in the helper array

animal_next = 1;        % 1: next available index in the animal array
plant_next = 2;         % 2: next available index in the plant array
pollen_next = 3;        % 3: next available index in the pollen array
graph_next = 4;         % 4: next graph

%% Helper Function
distance = @(x1,y1,x2,y2) sqrt((x1-x2)^2+(y1-y2)^2);
location = @(landscape_size) -1*landscape_size+rand*2*landscape_size;

wind_impact = @(angle, speed, x, y) ...
              [x + 10*speed*cos(angle), y + 10*speed*sin(angle)];
          
pollination_success = @(speed) ...
                      cal_pollination_success_rate(max_pollination_success_rate, speed);
reproduction_rate = @(num_animal, num_pollen) ...
                    num_pollen*0.0001/num_animal;
               
%% Graphing
graphing_index = [1, plant_maturity_date, totalsteps];

%% Initial Landscape
% initialize the three object arryas
environment = zeros(totalsteps, envir_length);
helper = [init_num_animal+1, init_num_plant+1, 1, graphing_index(1)];
animals = zeros(init_num_animal*10,animal_length);
plants = zeros(init_num_plant*20,plant_length);
pollen = zeros(30,init_num_plant*2,pollen_length);
pollen_day = 1;
pollen_index = zeros(1,30);
% initial condition of the environment
environment(1, num_animal) = init_num_animal;
environment(1, num_plant) = init_num_plant;
environment(1, wind_angle) = 0;
environment(1, wind_speed) = 0;
environment(1, num_pollinated) = 0;     
environment(1, num_egg) = 0;
environment(1, num_seed) = 0;
environment(1, temp) = 25;  

% initial condition of the animal species
for index = 1:init_num_animal
    if rand <= 0.5
        animals(index, animal_sex) = 0;
    else
        animals(index, animal_sex) = 1;
    end
    
    animals(index, animal_age) = 1;
    animals(index, animal_x) = location(init_size);
    animals(index, animal_y) = location(init_size);
    animals(index, animal_alive) = 1;
end

% initial condition of the plant species
for index = 1:init_num_plant
    
    plants(index, pollinated) = 0;
    plants(index, plant_age) = 1;
    plants(index, plant_x) = location(init_size);
    plants(index, plant_y) = location(init_size);
    plants(index, plant_alive) = 1;
    plants(index, plant_size) = randi(init_cluster_size);
end

%% Simulation

for days = 2:timestep:totalsteps
    % environment condition
    environment(days, num_animal) = environment(days-1, num_animal);
    environment(days, num_plant) = environment(days-1, num_plant);  
    environment(days, wind_angle) = -2+4*rand;
    environment(days, wind_speed) = max_pollination_success_rate*rand;
    environment(days, num_pollinated) = environment(days-1, num_pollinated);     
    environment(days, num_seed) = environment(days-1, num_seed);
    environment(days, num_egg) = environment(days-1, num_egg);
    environment(days, temp) = 25; 
    
    % update pollen_next and pollen_day
    if days <= 30
        pollen_day = days - 1;
        pollen_index(days - 1) = helper(pollen_next) - 1;
    else
        pollen_day = 30;
        pollen_index(30) = helper(pollen_next) - 1;
    end
    helper(pollen_next) = 1;
    
    % update plant
    for plant = 1:helper(plant_next)
        
        % increment age for every plant
        plants(plant, plant_age) = plants(plant, plant_age) + 1;
        
        % if the plant is still a seed
        if plants(plant, plant_age) < 0
            if rand > (prob_seed_survival+0.001*(abs(best_temp_seed-environment(days, temp))))
                plants(plant, plant_alive) = 0;
                environment(days, num_seed) = environment(days, num_seed) - 1;
            end
        end
        
        % if the seed becomes a plant
        if plants(plant, plant_age) == 0 && plants(plant, plant_alive) == 1
            environment(days, num_seed) = environment(days, num_seed) - 1;
            environment(days, num_plant) = environment(days, num_plant) + 1;
        end
        
        % before maturity the plant will produce pollen by chance
        if 0 < plants(plant, plant_age) < plant_maturity_date ...
           && rand < prob_pollen
            output = wind_impact(environment(days, wind_angle), ...
                         environment(days, wind_speed), ...
                         plants(plant, plant_x), ...
                         plants(plant, plant_y));
            pollen(pollen_day, helper(pollen_next), pollen_x) = output(1);
            pollen(pollen_day, helper(pollen_next), pollen_y) = output(2);
            helper(pollen_next) = helper(pollen_next) + 1;
        end
        
        % if the plant is in the seed producing period, pollinated and the seed
        % landed appropriately
        if plant_maturity_date < plants(plant, plant_age) && plants(plant, plant_age) < plant_maturity_date + seed_period
            if plants(plant, pollinated) == 1 && rand < prob_landing
                plants(helper(plant_next), pollinated) = 0;
                plants(helper(plant_next), plant_age) = -1*seed_stage;
                output = wind_impact(environment(days, wind_angle), ...
                         environment(days, wind_speed), ...
                         plants(plant, plant_x), ...
                         plants(plant, plant_y));
                plants(helper(plant_next), plant_x) = output(1);
                plants(helper(plant_next), plant_y) = output(2);
                plants(helper(plant_next), plant_alive) = 1;
                plants(helper(plant_next), plant_size) = plants(plant, plant_size);
                
                % update helper
                helper(plant_next) = helper(plant_next) + 1;
                environment(days, num_seed) = environment(days, num_seed) + 1;
            end
        end
        
        % if the plant is about to die
        if plants(plant, plant_age) == 365 
            if plants(plant, plant_alive) == 1
                plants(plant, plant_alive) = 0;
                environment(days, num_plant) = environment(days, num_plant) - 1;
            end
            if plants(plant, pollinated) == 1
                environment(days, num_pollinated) = environment(days, num_pollinated)-1;
            end
        end
    end
    
    % update animal
    if days >= 30
        k = init_size/10+1;
        random_n = randi([1 20]);
        pollen_i = reshape(pollen(random_n,1:pollen_index(random_n),:),[pollen_index(random_n),2]);
        for i = 24:30
            pollen_i = [pollen_i;reshape(pollen(i,1:pollen_index(i),:),[pollen_index(i),2])];
        end
        [idx,C] = kmeans(pollen_i,k);
    end
    
    for animal = 1: helper(animal_next) - 1

        % increment age for every animal
        animals(animal, animal_age) = animals(animal, animal_age) + 1;
        
        % if the animal is still an egg
        if animals(animal, animal_age) < 0 && animals(animal, animal_alive) == 1
            if rand > (prob_egg_survival+0.001*(abs(best_temp_seed-environment(days, temp))))
                animals(animal, animal_alive) = 0;
                environment(days, num_egg) = environment(days, num_egg) - 1;
            end
        end
        
        % if the egg becomes an animal
        if animals(animal, animal_age) == 0 && animals(animal, animal_alive) == 1
            environment(days, num_egg) = environment(days, num_egg) - 1;
            environment(days, num_animal) = environment(days, num_animal) + 1;
        end
        
        % the movement of the animals alive & reproduce eggs
        % movement without enough pollen in the environment
        if days < 31
            if 0 < animals(animal, animal_age) < 60
                output = wind_impact(environment(days, wind_angle), ...
                                     environment(days, wind_speed), ...
                                     location(init_size), location(init_size));
                animals(animal, animal_x) = output(1);
                animals(animal, animal_y) = output(2);

                for plant = 1:environment(days-1, num_plant)
                    if 0 < plants(plant, plant_age) < plant_maturity_date && ...
                            plants(plant, plant_alive) == 1 && plants(plant, pollinated) == 0
                        if distance(animals(animal, animal_x), ...
                                    animals(animal, animal_y),...
                                    plants(plant, plant_x),...
                                    plants(plant, plant_y)) <= sqrt(init_size)*2 &&...
                           rand < pollination_success(environment(days, wind_speed))
                            plants(plant, pollinated) = 1;
                           environment(days, num_pollinated) = environment(days, num_pollinated)+1;
                        end
                    end
                end
            end
        % movement with enough pollen in the environment
        else
            centroid = rem(animal,k)+1;
            animals(animal, animal_x) = C(centroid,1) + rand*15;
            animals(animal, animal_y) = C(centroid,2) + rand*15;
            
            visit = 0;
            for plant = 1:environment(days-1, num_plant)
                if 0 < plants(plant, plant_age) < plant_maturity_date && ...
                        plants(plant, plant_alive) == 1 && plants(plant, pollinated) == 0
                    if distance(animals(animal, animal_x), ...
                                animals(animal, animal_y),...
                                plants(plant, plant_x),...
                                plants(plant, plant_y)) <= sqrt(init_size)*2 &&...
                        rand < pollination_success(environment(days, wind_speed)) ...
                        && visit < visit_capacity
                       plants(plant, pollinated) = 1;
                       environment(days, num_pollinated) = environment(days, num_pollinated)+1;
                       visit = visit + 1;
                    end
                end
            end

            % wind disturbance on animal movements
            if rand < prob_disturb*environment(days, wind_speed)
                output = wind_impact(environment(days, wind_angle), ...
                                 environment(days, wind_speed), ...
                                 location(init_size), location(init_size));
                animals(animal, animal_x) = output(1);
                animals(animal, animal_y) = output(2);
            end
        end
        
        
        % if the animal is female and can produce eggs
        if animals(animal, animal_sex) == 1 && rand < reproduction_rate(environment(days, num_animal), pollen_index(30))
            
            animals(helper(animal_next):helper(animal_next)+5, animal_sex) = 1;
            animals(helper(animal_next)+5:helper(animal_next)+num_eggs, animal_sex) = 0;
            
            animals(helper(animal_next):helper(animal_next)+num_eggs, animal_age) = -10;
            animals(helper(animal_next):helper(animal_next)+num_eggs, animal_x) = animals(animal, animal_x);
            animals(helper(animal_next):helper(animal_next)+num_eggs, animal_y) = animals(animal, animal_y);
            animals(helper(animal_next):helper(animal_next)+num_eggs, animal_alive) = 1;

            % update helper
            helper(animal_next) = helper(animal_next) + num_eggs;
            environment(days, num_egg) = environment(days, num_egg) + num_eggs;
        end
        
        % if the animal is about to die
        if animals(animal, animal_age) == 365 && animals(animal, animal_alive) == 1
            animals(animal, animal_alive) = 0;
            environment(days, num_animal) = environment(days, num_animal) - 1;
        end
    end
end

%% Plot & Stats  
figure;
plot(1:totalsteps, environment(:, num_animal), 1:totalsteps, environment(:, num_plant))
title('Animal & Plant Population vs. Time')
xlabel('Time (days)')
legend('Animal', 'Plant')

figure;
plot(1:totalsteps, environment(:, num_egg), 1:totalsteps, environment(:, num_seed))
title('Egg & Seed Population vs. Time')
xlabel('Time (days)')
legend('Egg', 'Seed')

figure;
sz = 40;
MarkerEdgeColor = {[.5 .5 .5], [0 .7 .7], [0 1 0], [1 0 0], [.5 .5 1], [1 0 1]};
MarkerFaceColor = {[.7 .7 .7], [0 .7 .7], [0 1 0], [1 0 0], [.7 .7 1], [1 0 1]};

% graph plant clusters
for i = 1:helper(plant_next)
    
    if plants(i, plant_alive) == 0
        scatter(plants(i, plant_x),plants(i, plant_y),...
                plants(i, plant_size)*12,'filled',...
                'MarkerFaceAlpha',3/8,...
                'MarkerEdgeColor', MarkerEdgeColor{1},...
                'MarkerFaceColor', MarkerFaceColor{1})
        hold on
    else
        if plants(i, plant_age) < 0
            scatter(plants(i, plant_x),plants(i, plant_y),...
                sz,...
                'MarkerEdgeColor', MarkerEdgeColor{3},...
                'MarkerFaceColor', MarkerFaceColor{3})
            hold on
        else
            scatter(plants(i, plant_x),plants(i, plant_y),...
                plants(i, plant_size)*12,'filled',...
                'MarkerFaceAlpha',7/8,...
                'MarkerEdgeColor', MarkerEdgeColor{2},...
                'MarkerFaceColor', MarkerFaceColor{2})
            hold on
        end
    end
end

% graph animals
for i = 1:helper(animal_next)
    
    if animals(i, animal_alive) == 1
        if animals(i, animal_age) > 0
            scatter(animals(i, animal_x),animals(i, animal_y),...
                sz,...
                'MarkerEdgeColor', MarkerEdgeColor{4},...
                'MarkerFaceColor', MarkerFaceColor{4})
            hold on
        else
            scatter(animals(i, animal_x),animals(i, animal_y),...
                sz,...
                'MarkerEdgeColor', MarkerEdgeColor{5},...
                'MarkerFaceColor', MarkerFaceColor{5})
            hold on
        end
    end
end

title('landscape')
h = zeros(5, 1);
for i = 1:5
    h(i) = scatter(NaN,NaN,'MarkerEdgeColor', MarkerEdgeColor{i},...
                'MarkerFaceColor', MarkerFaceColor{i});
end

legend(h, 'dead plant cluster', 'alive plant cluster', 'seed', 'alive animal', 'egg')
xlim([-1.2*init_size 1.2*init_size])
ylim([-1.2*init_size 1.2*init_size])

% graph pollen
figure;
scatter(pollen_i(:,pollen_x),pollen_i(:,pollen_y),...
        4,...
        'MarkerEdgeColor', MarkerEdgeColor{6},...
        'MarkerFaceColor', MarkerFaceColor{6})
title('landscape of pollen')

%% Functions
function success = cal_pollination_success_rate(max_pollination_success_rate, speed)
    if speed == 0
        success = max_pollination_success_rate;
    else
        success = max_pollination_success_rate/speed;
    end
end