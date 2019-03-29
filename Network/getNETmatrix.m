clear;clc;
t1=clock;
load('/brain/iCAN/home/zhuangliping/RR/RR_database.mat');
inpath1='/brain/iCAN/home/zhuangliping/RR/individualstats/2015';
inpath2='/fmri/stats_spm8/RR_ppi/stats_spm8_swcar_gPPI_mask/';
%roi_path= '/brain/iCAN/home/zhuangliping/RR/ROIs/';
roi_path='C:\Users\upon\Documents\Research\TASKs\DEP_MS\RR_scripts\ROIs';
cd(roi_path)
roi=dir('roi*.nii');
roiname={roi.name}';

outpath='/brain/iCAN/home/zhuangliping/RR/RR_NETdata';
mkdir(outpath)


num_mask=[01:15]; 
num_nr=[4,6,8,10,12,14,16,18];
num_rr=[5,7,9,11,13,15,17,19];

sub=RR_database.fmri_ID;
for i = 1:length(sub(:,1))
    inpath=strcat(inpath1,sub{i,1},inpath2);
    for j=1:length(num_mask)
        tempath=strcat(inpath,'PPI_',roiname{j,1});
        cd(tempath);
        for k=1:length(num_mask)
            mask=fullfile(roi_path,roiname{k,1});
            vol_mask=spm_vol(mask);
            array_mask=spm_read_vols(vol_mask);
            for f=1:8
                if num_nr(1,f)<10
                    image_nr=strcat(tempath,'/spmT_000',num2str(num_nr(1,f)),'.nii');
                    image_rr=strcat(tempath,'/spmT_000',num2str(num_rr(1,f)),'.nii');
                else
                    image_nr=strcat(tempath,'/spmT_00',num2str(num_nr(1,f)),'.nii');
                    image_rr=strcat(tempath,'/spmT_00',num2str(num_rr(1,f)),'.nii');
                end
            vol_nr=spm_vol(image_nr);
            array_nr=spm_read_vols(vol_nr);
            nr=array_nr(find(array_mask(:)==1));
            net_nr(j,k,f,i)=nanmean(nr);
            
            vol_rr=spm_vol(image_rr);
            array_rr=spm_read_vols(vol_rr);
            rr=array_rr(find(array_mask(:)==1));
            net_rr(j,k,f,i)=nanmean(rr);
            end
        end
    end
end
t2=clock;
etime(t2,t1) %hours

cd(outpath)
save RR_NETdata RR* net*