% Configuration file for dcan_gPPI.m
% _________________________________________________________________
%Shaozheng Qin adapted for his poject on January 1, 2014 

% Please specify the data server path
paralist.data_server =  '/lustre/iCAN/data/';

%added by genghaiyang specify the stats server path
paralist.server_path_stats = '/lustre/iCAN/home/zhuangliping/RR/individualstats';

% Please specify the parent folder of the static data
% For YEAR data structure, use the first one
% For NONE YEAR data structure, use the second one
paralist.parent_folder        = [''];

% Please specify the subject list file (.txt) or a cell array
 load('/lustre/iCAN/home/zhuangliping/RR/RR_scripts/RR_database.mat');
 a=1;
 for i =[1:50]
  paralist.subject_list{a,1}=RR_database{i,2};
  a=a+1;
 end

% Please specify the stats folder name (eg., stats_spm8) 
paralist.stats_folder='RR_ppi/stats_spm8_swcar'; 

% Please specify the .nii file(s) for the ROI(s)
%paralist.roi_file_list = {'/home/qinlab/data/genghaiyang/data/nback/SPM12_results/sub_e18_c18/ppi/roi/MFG.nii'                     
%};
% get .nii list
paralist.roi_nii_folder    = '/lustre/iCAN/home/zhuangliping/RR/ROIs/';
niidir = dir(paralist.roi_nii_folder);
niidir = niidir([22]);
niidir = struct2cell(niidir);
niidir = niidir(1,:);
niidir = niidir';
paralist.roi_file_list =strcat(paralist.roi_nii_folder,'/',niidir);

% Please specify the name of the ROI
paralist.roi_name_list =regexp(niidir,'roi\w+','match','once');

% Please specify the task to include
% tasks_to_include = { '1', 'task1', 'task2', 'task3'} -> must exist in all sessions
% tasks_to_include = { '0', 'task1', 'task2', 'task3'} -> does not need to exist in all sessions
paralist.tasks_to_include = {'1';'NR'; 'RR'}';

%-mask file, restricting the analysis on voxels within the mask
paralist.mask_file = '/lustre/iCAN/home/zhuangliping/RR/ROIs/wholemask_memory_retrieval.nii';
%-------------------------------------------------------------------------%
% Please specify the confound names
paralist.confound_names = {'R1', 'R2', 'R3', 'R4', 'R5', 'R6'};