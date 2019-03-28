clear;clc;
load('C:\Users\upon\Documents\Research\TASKs\RR\RR_database.mat');
roi_path='C:\Users\upon\Documents\Research\TASKs\RR\rois\';
cd(roi_path)
roi=dir('mask_memory_retrieval.nii');
roiname={roi.name}';
roiindex=spm_vol_nifti(roiname{1,1});
roiindex=spm_read_vols(roiindex);

MR=spm_vol_nifti('memory_retrieval_pFgA_z_FDR_0.01.nii');
MR=spm_read_vols(MR);
MR_data=MR(find(roiindex==1));

data_path='C:\Users\upon\Documents\Research\TASKs\RR\data\RR_1st\';
for i=1:length(RR_database)
    sub_path=[data_path,RR_database{i,1},'_stats_spm8_swcar\'];
    cd(sub_path)
    
    NR=spm_vol_nifti('spmT_0005.nii');
    NR=spm_read_vols(NR);
    NR_data=NR(find(roiindex==1));
    RSA_NR(i,1)=corr(NR_data,MR_data);
    
    RR=spm_vol_nifti('spmT_0006.nii');
    RR=spm_read_vols(RR);
    RR_data=RR(find(roiindex==1));
    RSA_RR(i,1)=corr(RR_data,MR_data);
end

