%-Configfile for preprovcessfmri.m
%__________________________________________________________________________

paralist.ServerPath = '/lustre/iCAN/data';

%-Subject list  
  load('/lustre/iCAN/home/zhuangliping/RR/RR_scripts/RR_database.mat');
 for i =[1:50]
  paralist.SubjectList{i,1}=RR_database{i,2};
 end

 %-Session list
paralist.SessionList = {'MS_01';'MS_02';'MS_03';'MS_04';'MS_05';'MS_06';'MS_07';'MS_08';};

paralist.sliceorder=[1:2:37 2:2:36];     

paralist.InputImgPrefix = 'car';

paralist.EntirePipeLine = 'swcar'; 

%-Additinal subject list for swgc** pipelines due to better SPGR quality,
% one-to-one matched to paralist.SubjectList
paralist.SPGRSubjectList = '';
