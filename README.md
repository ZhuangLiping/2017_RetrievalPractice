# RetrievalPractice
Codes for Retrieval Practice Project


Master Sheet for Data Analysis Conducted in The Manuscript

A.	Behavioral data (outside scanner)

o	Raw data: /brain/iCAN/home/zhuangliping/RR/behav/

o	Analyzed data: /brain/iCAN/home/zhuangliping/RR/RR_Manuscript/RR_behav.xlsx

o	Texts in the MS: 
  	  1st section in the main text and Behavioral data analysis in the Methods & Materials used the information from analyzed data folder;
  	  Participants/Materials/Experimental procedure in the Methods & Materials used the information from raw data folder

o	Figures in the MS: Figure 1; Supplemental Figure 1 

B.  fMRI data quality check and univariate analysis

Raw DICOMs:

o	/brain/iCAN/home/zhuangliping/RR/raw_data

Data quality check:

o	Movement:/brain/iCAN/home/zhuangliping/RR/behav/SUBinfo/RR_movement.xlsx

o	Quality check report:/brain/iCAN/home/zhuangliping/RR/behav/SUBinfo/Quality check report.txt

Univariate analysis: 

o	Task design
/brain/iCAN/home/zhuangliping/RR/RR_scripts/task_design/taskdesign*.m

o	Preprocessing
   1. /brain/iCAN/home/zhuangliping/RR/RR_scripts/Mainfunctions/preprocessfmri_config_RR.m
   2. /brain/iCAN/home/zhuangliping/RR/RR_scripts/Mainfunctions/preprocessfmri.m
Usage: preprocessfmri(‘preprocessfmri_config_RR.m’)

o	Individual stats: 
   1. /brain/iCAN/home/zhuangliping/RR/RR_scripts/Mainfunctions/individualstats_config_RR.m
   2. /brain/iCAN/home/zhuangliping/RR/RR_scripts/Mainfunctions/individualstats_RR.m
   3. Usage: individualstats_RR (‘individualstats_config_RR.m’)

o	Individual stats (for single trial):  
  1. /brain/iCAN/home/zhuangliping/RR/RR_scripts/Mainfunctions/individualstats_singletrial_config_RR.m
  2. /brain/iCAN/home/zhuangliping/RR/RR_scripts/Mainfunctions/individualstats_singletrial.m
  3. Usage: individualstats_singletrial (‘individualstats_singletrial_config_RR.m’)

o	Texts in the MS: 6th & 7th section in the Methods & Materials

C.	Representational similarity analysis

Template and ROIs: 

o	Link to the directory: /brain/iCAN/home/zhuangliping/RR/ROIs

Representational distinctiveness:

o	Link to the directory: /brain/iCAN/home/zhuangliping/RR/RSA/ Results_RSA/RSA_ distinctiveness

o	Core scripts & subject list:
/brain/iCAN/home/zhuangliping/RR/RR_scripts/RSA_singletrial.m

o	Texts in the MS: 9th section in the Methods & Materials

o	Figures in the MS: Figure 2 & S3

Representational fidelity:

o	Link to the directory: /brain/iCAN/home/zhuangliping/RR/RSA/Results_RSA/RSA_R1template

o	Core scripts & subject list: /brain/iCAN/home/zhuangliping/RR/RR_scripts/RSAfidelity.m

o	Texts in the MS: 1st section in the Supplementary methods

o	Figures in the MS: Figure S2, S4 & S5


D.	Network and prediction analysis

Network construction:

o	Link to the directory:/brain/iCAN/home/zhuangliping/RR/PPI_NET

o	Core scripts & subject list: 
  1. /brain/iCAN/home/zhuangliping/RR/RR_scripts/gPPI_mask_RR.m 
  2. /brain/iCAN/home/zhuangliping/RR/RR_scripts/gPPI_mask_RR_config.m 
  3. Usage: gPPI_mask_RR(‘gPPI_mask_RR_config.m’)
  4. /brain/iCAN/home/zhuangliping/RR/RR_scripts/getNETmatrix.m

o	Texts in the MS: 10th section in the Methods & Materials

o	Figures in the MS: Figure 3A

Network analysis:

o	Link to the directory: C:\Users\upon\Documents\Research\TASKs\RR\results\Network\network\data\results\

o	Configure (GRETNA software): C:\Users\upon\Documents\Research\TASKs\DEP_MS\results\Network\network\data\results\GretnaLogs\NetworkMetricsConfigure.txt

o	Texts in the MS: 12th & 13th section in the Methods & Materials

o	Figures in the MS: Figure 3B, 3C,4C & S6

Network-based brain-behavior prediction analysis:

o	Link to the directory: 

o	/brain/iCAN/home/zhuangliping/RR/Prediction

o	Core scripts:
  1. /brain/iCAN/home/zhuangliping/RR/RR_scripts/predict_net_accumulated_asym.m
  2. /brain/iCAN/home/zhuangliping/RR/RR_scripts/predict_net_accumulated_asym_permutation.m

o	Texts in the MS: 11th section in the Methods & Materials

o	Figures in the MS: Figure 4B, 5B& S7


