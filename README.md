# Agent-Based Modeling of Plant-Pollinator Mutualism

This research project is a semester-long interdisplinary project done by Iris Liu, under the guidance of Professor Eric Aaron at Colby College Computer Science Deparment and Professor Chris Moore at Colby College Biology Department.

Note that:
* MATLAB is the main coding language in this project.
* LaTex and BibTex are used for the manuscript. 


## Manuscript

The manuscript presents an agent-based, spatially explicit model simulating one pollination-based mutualism environment that contains one pollinator species and one plant species. The main question addressed by the research, using the model, is to investigate plant traits, pollinator behaviors and environmental impacts in relation to each other and with respect to the spatial distributions of both species. The presented model includes parameters important to plant species and pollinator species life cycles, traits of animal foraging behaviors, plant-animal interaction measures and two environmental factors. Five simulation experiments were performed and discussed: Experiment 1 is on effects of plant densities across time, Experiment 2 on the relationship between plant life cycle and species reproduction statistics, Experiment 3 on effects of pollinator foraging behaviors, and Experiment 4 and 5 on effects of winds on species reproduction and distribution. A list of improvements that can be made on future versions of the research manuscript is present below. 

### Correctness and soundness of technical content
* Method: The research project stresses the nature of pollination-based mutualism that the pollinator species receives food from pollination behaviors while the plant species receives pollination services from the animal species. However, though pollen is a food source of pollinators, the model should consider separating the food factor and the attractiveness factor. In particular, the animals may be not capable of identifying plant clusters with the most amount of food but are capable of identifying plant clusters (flowers) with appealing scents and plant hormones; in this case, it is possible to have pollinators visiting attractive plant clusters but gaining little food. Regarding the specifications on plant life cycle, there are two separate periods for the plant species to flower and to produce seeds if further investigations on plant species life cycles want to be made.  

* Implementation: There are at least two improvements that can be made in the Implementation section. First, the original manuscript fails to present the detailed equations used in the model. In particular, though two variables can be inversely related to each other, for example, pollination success rate and wind speed in the environment, the manuscript could explain in details how they are negatively associated and why that decision is made. For instance, how large is the effect on the pollination success rate for each increase in unit wind speed? The Appendix section indicates that the pollination success rate would be the reciprocal of the wind speed if wind speed of the day is non-zero. Then, why is a reciprocal equation used, rather than a linear equation with a negative coefficient on the wind speed term? It could be that as speed increases, it would be more and more difficult for plants to become pollinated as the wind can easily below pollen grains away; then why not a quadratic equation? It would be better if the manuscript lists reasons why the choices of equations were made when modeling the relationships between variables. 
Secondly, it would be more user-friendly if the manuscript briefly describes and mentions the visualizations and the purpose of each visualization. For instance, present a table containing all different kinds of marks in the landscape graph and their corresponding meanings in context. This may also help the audience better understand the graphs presented in the Results section. 

* Validation and Model Evaluation: More credibility would be added to the research project if the manuscript can present a detailed example of how, for example, pollinator visiting rate affects plants spatial distribution in comparison to a real dataset to demonstrate the validation process. Validation tests can be performed on measures of plant and pollinator traits, and outputs of the simulation model can be compared to data from natural plant-pollinator systems. Statistical tests may be considered valuable indicating whether the differences (if any) between the simulation dataset and the real data are significant. 

### Novelty of the work
The model is considered very valuable since few research had been done regarding spatially explicit modeling specifically on pollination-based mutualism. The resulting model would be a useful simulation tool that helps the understand pollinator behaviors and may contribute significantly to plant and pollinator species management and preservation. 

###  Importance of the results to the relevant research community
There are five simulation experiments in the Results and Simulations section, in which there are corresponding graphs and tables associated with each experiment. However, the author of the manuscript did not clearly refer to each graph in the text, which undermines the value of the graphs because the audience may miss or misunderstand the point the author is making and the reason why each graph is included. 
From a result perspective, graphs of time steps other than the ending in Experiment 1 may also provide insights and add values to the change of plant densities and distributions across time. Error bars or statistics on standard deviations can be added to tables in shown in Experiment 4 and 5. Though evidence or lack of evidence shown in the tables can contribute to conclusions on the effect of wind, there could be changes in standard deviations, volatilities of results or other indications the species statistics when modifying relevant parameters. 
Additionally, if possible, more efforts could be put into having a smaller timestep (smaller than a day) so that researchers are able to monitor or test different pollinator behaviors within a day, since both the plant and the pollinator species may have different activeness in response to daylight. 

### Clarity and insight of the discussion
The discussion section addresses each simulation experiments, but most of them did not discuss expectations and original hypotheses in accordance or in contrast to the results. Nevertheless, the discussion does not overinterpret the simulation results: for example, in Experiment 3, the manuscript concludes that pollinators are not very likely to regard pollen density as the only criterion of their destination choices, without overinterpreting any causal factors impacting pollinator foraging behaviors. 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.


### Prerequisites

What things you need to install

```
MATLAB
```
```
LaTex
```

## Running the tests

To run Main.java, go to your terminal and the folder/path where the file is located, and enter 

```
filename.m
```

## Contributing

Please read [CONTRIBUTION.md](https://github.com/irises0605/Contribution) for details on our code of conduct, and the process for submitting pull requests to me.


## Author(s)

Iris Liu, Colby '22, with assistance from Prof. Eric Aaron and Prof. Chris Moore


## Acknowledgments

* Please give me credit when using my code.
