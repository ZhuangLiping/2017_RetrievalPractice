# RetrievalPractice
This repository contains core scripts for Retrieval Practice Project.

# Summary and requirements:
	This repository contains MATLAB scripts needed to produce key results and supplementary materials.
	They have been tested using MATLAB 2016a.
	This code requires data available in ExampleData folder.
	To run the scripts, add folders mentioned in Dependencies to Matlab.

# Test environment(s):
	MATLAB Version: 9.0.0.341360 (R2016a)
	Operating System: Microsoft Windows 10 Home Version 10.0 
	& Linux ln01 2.6.32-431.el6.x86_64 #1 SMP Fri Nov 22 03:15:09 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux	

# Preliminary Tasks:
	Preprocess:/RetrievalPractice/Mainfunctions/preprocessfmri.m
	Regular individual analysis: /RetrievalPractice/Mainfunctions/individualstats_RR.m
	Single trial individual analysis: /RetrievalPractice/Mainfunctions/individualstats_singletrial.m

# Behavioral analysis (Figure 1, Supplementary Figure 1):
	Behavioral data:  /RetrievalPractice/RR_database.mat (as table format)

# Template and ROIs:
	Link to the directory: /RetrievalPractice/ROIs/

# Representational similarity analysis (Figure 2, Figure 5 and Supplementary Figure 2-5):
	Representational distinctiveness: /RetrievalPractice/RSA/RSA_singletrial.m
	Representational fidelity: /RetrievalPractice/RSA/RSAfidelity.m
	RSA with NeuroSynth pattern: /RetrievalPractice/RSA/RSAwithNeuorosythn.m

# Network analysis(Figure 3 & 4, Supplementary Figure 6):
	Conduct gPPI analyses: /RetrievalPractice/Network/gPPI_mask_RR.m
	Extract value from gPPI results to construct 15 x 15 connectivity matrix: /RetrievalPractice/Network/getNETmatrix.m
	Configure of network analysis:/RetrievalPractice/Network/NetworkMetricsConfigure.txt

# Network-based brain-behavior prediction analysis (Figure 4 & 5, Supplementary Figure 7):
	Based on LIBSVM toolbox (http://www.csie.ntu.edu.tw/~cjlin/libsvm/)
	Prediction analysis: /RetrievalPractice/Prediction/predict_net_accumulated_asym.m
	Permutation analysis to test the statistical significance of prediction accuracy: /RetrievalPractice/Prediction/predict_net_accumulated_asym_permutation.m


# Dependencies: These should be installed to run scripts
	Matlab: www.mathworks.com
	Statistical Parametric Mapping (SPM): software https://www.fil.ion.ucl.ac.uk/spm/
	Generalized PPI Toolbox: https://www.nitrc.org/projects/gppi
	GRETNA Toolbox: https://www.nitrc.org/projects/gretna/
	LIBSVM toolbox: http://www.csie.ntu.edu.tw/~cjlin/libsvm/

	


