clear;clc;
load('C:\Users\upon\Documents\Research\TASKs\DEP_MS\RR_scripts\forGITHUB\Prediction\RR_NETdata.mat');
load('C:\Users\upon\Documents\Research\TASKs\DEP_MS\RR_scripts\forGITHUB\Prediction\selectedFeatures_thr001.mat');

num_sub=length(RR_database.sub_ID);
con_score=(score_RR(:,5)-score_RR(:,6))-(score_RR(:,2)-score_RR(:,3));%1isD1NR;2isD1R;3isD1B;4isD2NR;5isD2R;6isD2B;
for k=1:length(w_feature)
     weight_netT=w_feature{k,1};
     net_rr_weight=net_rr_unfold(:,weight_netT);
     roi_data_input = net_rr_weight;
for z=1:1000
    score_behav=con_score(randperm(length(con_score)));    
       %% Scaling to [0 1]
        MinValue = min(roi_data_input);
        MaxValue = max(roi_data_input);
        [rows, columns_quantity] = size(roi_data_input);
        for j = 1:columns_quantity
            roi_data_input_scaling(:, j) = (roi_data_input(:, j) - MinValue(j)) / (MaxValue(j) - MinValue(j));
        end
        roi_data=roi_data_input_scaling;
        %% create model
        for i=1:num_sub
            data_train=roi_data;
            data_train(i,:)=[];
            data_test= roi_data(i,:);
            score_train=score_behav;
            score_train(i,:)=[];
            score_test=score_behav(i,1);
            
            cmd = ['-s 3 -t 0'];
            model=svmtrain(score_train,data_train,cmd);
            [predicted_label,accuracy,prob_estimates] = svmpredict(score_test,data_test,model);
            score_predict(i,1)=predicted_label;
        end
        permu_PredictionAccuracy(z,1)=corr(score_predict,score_behav);      
end
       permu_PredictionAccuracy_sorted(:,k)=sort(permu_PredictionAccuracy,'descend');
end
 
 

