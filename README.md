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
  /brain/iCAN/home/zhuangliping/RR/RR_scripts/Mainfunctions/preprocessfmri_config_RR.m
  /brain/iCAN/home/zhuangliping/RR/RR_scripts/Mainfunctions/preprocessfmri.m
Usage: preprocessfmri(‘preprocessfmri_config_RR.m’)

o	Individual stats: 
  /brain/iCAN/home/zhuangliping/RR/RR_scripts/Mainfunctions/individualstats_config_RR.m
  /brain/iCAN/home/zhuangliping/RR/RR_scripts/Mainfunctions/individualstats_RR.m
Usage: individualstats_RR (‘individualstats_config_RR.m’)

o	Individual stats (for single trial): 
  /brain/iCAN/home/zhuangliping/RR/RR_scripts/Mainfunctions/individualstats_singletrial_config_RR.m
  /brain/iCAN/home/zhuangliping/RR/RR_scripts/Mainfunctions/individualstats_singletrial.m
Usage: individualstats_singletrial (‘individualstats_singletrial_config_RR.m’)

o	Texts in the MS: 6th & 7th section in the Methods & Materials

