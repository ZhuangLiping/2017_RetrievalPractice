clear;clc;
for k=1:8
    NiiPath=strcat('C:\Users\upon\Documents\Research\TASKs\RR\data\sorted_stats_spm8_swcar_singletrial\beta\RUN',num2str(k),'_T\');
    OutputPath=strcat('C:\Users\upon\Documents\Research\TASKs\RR\data\sorted_stats_spm8_swcar_singletrial\RUN',num2str(k),'_T_RSA\');
    mkdir(OutputPath)
    
    VM = 'C:\Users\upon\Documents\Research\TASKs\RR\ROIs\vbm_grey_mask.nii';
    SearchOpt = struct('def', 'sphere', 'spec', 6);
    SearchOpt.def ='sphere';
    SearchOpt.spec = 6;
    
    cd(NiiPath)
    files=dir('15*');
    file={files.name}';
    
    for i=1:length(file)
        cd([NiiPath,file{i,1}])
        imgs=dir('beta*nii');
        img={imgs.name}';
        OutputFolder=[OutputPath,file{i,1}];
        mkdir(OutputFolder)
        for m=1:length(img)-1
            for n=m+1:length(img)
                CurrentMaps = cell(2,1);
                CurrentMaps(1,1)=strcat(img(m,1));
                CurrentMaps(2,1)=strcat(img(n,1));
                FileEnd = strcat('rsa_RR_RUN',num2str(k),'_trial_',num2str(m),'-',num2str(n));
                
                OutputFile = fullfile(OutputFolder, FileEnd);
                scsnl_searchlight_qin(CurrentMaps, VM, SearchOpt, 'pearson_correlation', OutputFile);
            end
        end
    end
end