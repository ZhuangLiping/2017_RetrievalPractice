function gPPI_mask_zlp(Config_File)
%-gPPI analysis for task-related fMRI data and analysis pipeline
%Shaozheng Qin adapted for his memory poject on January 1, 2014 

warning('off', 'MATLAB:FINITE:obsoleteFunction')
c = fix(clock);
disp('==================================================================');
fprintf('gPPI analysis started at %d/%02d/%02d %02d:%02d:%02d \n',c);
disp('==================================================================');
fname = sprintf('dcan_gPPI-%d_%02d_%02d-%02d_%02d_%02.0f.log',c);
diary(fname);
disp(['Current directory is: ',pwd]);
disp('------------------------------------------------------------------');
%==========================================================================
%addpath(genpath('/home/fmri/fmrihome/SPM/spm8_scripts/Connectivity/EffectiveConnectivity/PPI/PPPI_v2012_1_22'));
%addpath('/home/fmri/fmrihome/SPM/spm8_scripts/Utility/');

%-Check existence of the configuration file
Config_File = strtrim(Config_File);

if ~exist(Config_File,'file')
  fprintf('Cannot find the configuration file ... \n');
  diary off; 
  return;
end

Config_File = Config_File(1:end-2);

%-Read individual stats parameters
current_dir = pwd;
eval(Config_File);
clear Config_File;

%-Load parameters
data_server = strtrim(paralist.data_server);
data_server_stats = paralist.server_path_stats;
subjects = ReadList(strtrim(paralist.subject_list));
stats_folder = strtrim(paralist.stats_folder);
num_subj = length(subjects);
roi_file = ReadList(paralist.roi_file_list);
roi_name = ReadList(paralist.roi_name_list);
num_roi_name = length(roi_name);
num_roi_file = length(roi_file);
tasks_to_include = paralist.tasks_to_include;
mask_file = paralist.mask_file;
confound_names = paralist.confound_names;
%prep_pipeline = strtrim(paralist.prep_pipeline);
if num_roi_name ~= num_roi_file
  error('number of ROI files not equal to number of ROI names');
end

for i_roi = 1:num_roi_file
  
  fprintf('===> gPPI for ROI: %s\n', roi_name{i_roi});
  
  load('ppi_master_template.mat');
  
  P.VOI = roi_file{i_roi};
  P.Region = roi_name{i_roi};
  %P.extract = 'mean';
  %P.CompContrasts = 1;
  P.Tasks = tasks_to_include;
  P.FLmask = 1;
  P.equalroi = 0;
  % P.analysis = 'psy'; %added by genghaiyang
  % P.method =  'cond'; %added by genghaiyang
  
  
  for i_subj = 1:num_subj
    
    fprintf('------> processing subject: %s\n', subjects{i_subj});
    
    year_id = ['20', subjects{i_subj}(1:2)];
    
    
    %-directory of SPM.mat file
    subject_stats_dir = fullfile(data_server_stats, year_id, subjects{i_subj}, ...
      'fmri/stats_spm8', stats_folder);
    
    subject_gPPI_stats_dir = fullfile(data_server_stats, year_id, subjects{i_subj}, ...
      'fmri/stats_spm8', [stats_folder, '_gPPI_mask']); % edited by zlp
    
    if ~exist(subject_gPPI_stats_dir, 'dir')
      mkdir(subject_gPPI_stats_dir);
    end
    
    cd(subject_gPPI_stats_dir);
    
    unix(sprintf('/bin/cp -af %s %s', fullfile(subject_stats_dir, 'SPM.mat'), ...
      subject_gPPI_stats_dir));
    
    unix(sprintf('/bin/cp -af %s %s', fullfile(subject_stats_dir, '*.nii'), ...
      subject_gPPI_stats_dir));
    
    %unix(sprintf('/bin/cp -af %s %s', fullfile(subject_stats_dir, '*.hdr'), ...
    %  subject_gPPI_stats_dir));
    
    
    P.subject = subjects{i_subj};
    P.directory = subject_gPPI_stats_dir;
    
    %-Update the SPM path for gPPI analysis
    load('SPM.mat');
    SPM.swd = pwd;
    
    num_sess = numel(SPM.Sess);
    
    img_name = cell(num_sess, 1);
    img_path = cell(num_sess, 1);
    num_scan = [1, SPM.nscan];
    
    for i_sess = 1:num_sess
      first_scan_sess = sum(num_scan(1:i_sess));
      img_name{i_sess} = SPM.xY.VY(first_scan_sess).fname;
      img_path{i_sess} = fileparts(img_name{i_sess});
      unix(sprintf('gunzip -fq %s', [img_name{i_sess}, '.gz']));
    end
 
    
    iG = [];
    col_name = SPM.xX.name;
    
    num_confound = length(confound_names);
    
    for i_c = 1:num_confound
      iG_exp = ['^Sn\(.*\).', confound_names{i_c}, '$'];
      iG_match = regexpi(col_name, iG_exp);
      iG_match = ~cellfun(@isempty, iG_match);
      if sum(iG_match) == 0
        error('confound columns are not well defined or found');
      else
        iG = [iG find(iG_match == 1)];
      end
    end
       
    if length(iG) ~= num_confound*num_sess
      error('number of confound columns does not match SPM design');
    end
    
    num_col = size(SPM.xX.X, 2);
    FCon = ones(num_col, 1);
    FCon(iG) = 0;
    FCon(SPM.xX.iB) = 0;
    FCon = diag(FCon);
    
    num_con = length(SPM.xCon);
    
    %-make F contrast and run it
    SPM.xCon(end+1)= spm_FcUtil('Set', 'effects_of_interest', 'F', 'c', FCon', SPM.xX.xKXs);
    spm_contrasts(SPM, num_con+1);
    
    P.contrast = num_con + 1;
    
    SPM.xX.iG = sort(iG);
    for g = 1:length(iG)
      SPM.xX.iC(SPM.xX.iC==iG(g)) = [];
    end
    
    save SPM.mat SPM;
    clear SPM;
    % make T contrast and put i into P. added by genghaiyang
    P.Contrasts(1).name='NR';
    P.Contrasts(1).left={'NR'};
 	P.Contrasts(1).right={'none'};
    P.Contrasts(1).STAT='T';
    P.Contrasts(1).Weighted=0;
    %P.Contrasts(1).MinEvents=5;
%    
    P.Contrasts(2).name='RR';
    P.Contrasts(2).left={'RR'};
 	P.Contrasts(2).right={'none'};
    P.Contrasts(2).STAT='T';
    P.Contrasts(2).Weighted=0;
    %P.Contrasts(2).MinEvents=5;
    
    P.Contrasts(3).name='RR-NR';
    P.Contrasts(3).left={'RR'};
 	P.Contrasts(3).right={'NR'};
    P.Contrasts(3).STAT='T';
    P.Contrasts(3).Weighted=0;
    %P.Contrasts(3).MinEvents=5;
    

    
    %User input required (change analysis to be more specific)
    %roi_name{i_roi}=roi_name{i_roi}{1};% gegnhy added
    %save x.mat roi_name
    save(['gPPI_', subjects{i_subj}, '_analysis_', roi_name{i_roi}, '.mat'], 'P');
    %PPPI(['gPPI_', subjects{i_subj}, '_analysis_', roi_name{i_roi}, '.mat']);
    PPPI_mask(['gPPI_', subjects{i_subj}, '_analysis_', roi_name{i_roi}, '.mat'], ['gPPI_', subjects{i_subj}, '_analysis_', roi_name{i_roi}, '.mat'],mask_file);
    
    for i_sess = 1:num_sess
      unix(sprintf('gzip -fq %s', img_name{i_sess}));
    end
    %scsnl_art_redo_mask(fullfile(subject_gPPI_stats_dir_temp, ['PPI_', roi_name{i_roi}]), prep_pipeline, gPPI_roi_dir, img_path, mask_file);

    cd(subject_gPPI_stats_dir);
    unix(sprintf('/bin/rm -rf %s', 'SPM.mat'));
    unix(sprintf('/bin/rm -rf %s', '*.nii'));%edited by genghaiyang
    unix(sprintf('/bin/rm -rf %s', '*.img'));
    unix(sprintf('/bin/rm -rf %s', '*.hdr'));
    unix(sprintf('/bin/mv -f %s %s', '*.txt', ['PPI_', roi_name{i_roi}]));
    unix(sprintf('/bin/mv -f %s %s', '*.mat', ['PPI_', roi_name{i_roi}]));
    unix(sprintf('/bin/mv -f %s %s', '*.log', ['PPI_', roi_name{i_roi}]));
  end
  cd(current_dir);
end

cd(current_dir);
disp('------------------------------------------------------------------');
fprintf('Changing back to the directory: %s \n', current_dir);
c     = fix(clock);
disp('==================================================================');
fprintf('gPPI analysis finished at %d/%02d/%02d %02d:%02d:%02d \n',c);
disp('==================================================================');

diary off;
clear all;
close all;
end