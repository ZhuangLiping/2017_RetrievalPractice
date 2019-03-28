clear;clc;
load('C:\Users\upon\Documents\Research\TASKs\RR\RR_scripts\RSA\RR_Tvalue_3masks_RUN.mat')
num_mask=1:3;
for k=1:length(num_mask)
    for i=1:50
        eval(['temp=Tvalue_RR_mask',num2str(num_mask(1,k)),'(:,:,i);']);
        eval(['temp2=Tvalue_NR_mask',num2str(num_mask(1,k)),'(:,:,i);']);
        for j=2:8
            [fidelity_RR(i,j-1,k),a]=corr(temp(:,1),temp(:,j));
            [fidelity_NR(i,j-1,k),a]=corr(temp2(:,1),temp2(:,j));
        end
    end
end

load('C:\Users\upon\Documents\Research\TASKs\RSA\RR_scripts\RSA\RR_Tvalue_wholeM_RUN.mat')
for i=1:50
    temp_rr=Tvalue_RR_wholeM(:,:,i);
    temp_nr=Tvalue_NR_wholeM(:,:,i);
    for j=2:8
            [fidelity_RR_wholeM(i,j-1),a]=corr(temp_rr(:,1),temp_rr(:,j));
            [fidelity_NR_wholeM(i,j-1),a]=corr(temp_nr(:,1),temp_nr(:,j));
    end
end
    