# Posterior predictive for phylodynamic models in H1N1

Please contact Sebastian Duchene <sduchene@unimelb.edu.au> for any questions.

The files in this folder reproduce the model adequacy analyses in the paper.

-   samples_metadata.csv
Metadata for 100 h1n1 samples included in this analysis.

-   DeterCoalSIR_h1n1.xml
This xml file contains a time tree for h1n1 samples and the analysis with the determinsitic coalescent SIR model. The trajectories are sampled in each state, so the file is best visualised in R.

-   BDSIR_h1n1_sampling.xml
This xml file contanins the timetree for h1n1 samples to be analysed using the BDSIR model. Sampling is assumed to be close to zero before the collection of the earliest sample. 

-    DeterCoal_simulate_tree.xml
This is an example file for MASTER to simulate trees under the determinisitc coalescent SIR model. Use this as the MASTER file in TMA.

-    BDSIR_simulate_tree.xml
This is an example file to simulate trees for the BDSIR model. In practice this consists in 'sampling from the prior' by fixing the phylodynamic model parameter values. As such, operators on R0, becomeUninfectiousRate, sampling, and S0 are commented out, but those for the tree are still active. Use this as the MASTER file in TMA. 

- pps_plots.R
This is an example of an R script to generate plots for the trajectories of the BDSIR and determinstic coalescent SIR models.
