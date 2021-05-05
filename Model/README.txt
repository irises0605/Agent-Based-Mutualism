README.txt

Author: Iris (Bingya) Liu and Eric Aaron

Project purpose:
Pollination by insects and other pollinator animal species is an essential part of various ecosystems considering biodiversity and ecological conservation. Understanding pollination systems is a challenging task due to the complex plant-animal interactions impacted by different factors, including environmental conditions, species-specific traits and the fundamental mutual dependence in the ecosystem. The focus of this research is to develop an agent-based, computational simulation model that helps researchers in ecology, plant-science and relevant fields understand pollination-based plant-animal mutualism in a spatially explicit way. The implementation of agent-based modeling evaluates not only shared pollination services in an interactive environment, but also plant and animal species individuals with respect to each other. The simulation tracks animal behaviors, pollen and nectar sources, and the spatial position of individual foragers; the visualization of both species would allow researchers to quickly identify the generational movement and migration of the species with respect to the environment. With some abstract levels which the researchers can specify themselves, this model aims to be used to represent various species in different environments and thus may be an effective tool to compare plant-animal interactions across many species. The verification of the model is done in each modeling step, from the simplified to the complicated.

List of files:
1. Mutualism_Liu_Model:
This file contains the model with default parameter values (see manuscript Appendix C). 
Simulation Experiment 1:
(1) Modify only init_num_plant (line 38) to 20, 40, and 80.
(2) Modify only init_cluster_size (line 39) to 4, 20, 40.
Simulation Experiment 2:
(1) Modify only plant_maturity_date (line 27) to 120, 180, and 240.
(2) Modify only seed_period (line 28)  to 30, 45, and 60.
(3) Modify only seed_stage(line 29)  to 30, 60, and 90.
Simulation Experiment 3:
(1) Modify init_size (line 36) to 110. Then modify k (line 235) to 1,3,5,10, init_size/10+1. 
(1) Modify init_size (line 36) to 50. Then modify k (line 235) to 1,2,3,5,20, init_size/10+1. 
Simulation Experiment 4:
(1) Modify only maximum wind speed (line 27) to 1,2,5,8,10.
Simulation Experiment 5:
(1) Modify only maximum wind speed (line 27) to 1,2,5,8,10.

2. Mutualism_Liu_Validation:
This file contains the model used for the most recent validation simulation. The main differences are:
(1) There is no wind disturbance considering animal behaviors
(2) Pollen would not move due to wind and stay at their original plants.
(3) Pollen grains are graphed with plant and pollinator species. 




