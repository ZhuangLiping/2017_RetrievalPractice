clear;clc;
load('/brain/iCAN/home/zhuangliping/RR/RR_NETdata/RR_NETdata.mat');%load NETdata

num_sub=50;num_rois=15;num_runs=8;
feature_run=num_rois*num_rois;
score_behav=(score_RR(:,5)-score_RR(:,6))-(score_RR(:,2)-score_RR(:,3));%1isD1NR;2isD1R;3isD1B;4isD2NR;5isD2R;6isD2B;
w_feature=cell(1);
thr=[0.01:0.01:0.1];

for t=1:length(thr)
    for k=1:num_runs
        roi_data_input = net_rr_unfold(:,1:k*feature_run);
        Features_Quantity=feature_run*k;
        %% Scaling to [0 1]
        MinValue = min(roi_data_input);
        MaxValue = max(roi_data_input);
        [rows, columns_quantity] = size(roi_data_input);
        for j = 1:columns_quantity
            roi_data_input_scaling(:, j) = (roi_data_input(:, j) - MinValue(j)) / (MaxValue(j) - MinValue(j));
        end
        %% weight
        model_All = svmtrain(score_behav,roi_data_input_scaling,'-s 3 -t 0');
        w_Brain = zeros(1,Features_Quantity);
        for j = 1 : model_All.totalSV
            w_Brain = w_Brain + model_All.sv_coef(j) * model_All.SVs(j, :);
        end
        w_Brain = w_Brain / norm(w_Brain);
        w_Brain(2,:) = [1:Features_Quantity];
        %% feature selection
        w_temp(1,:)=sort(w_Brain(1,:),'descend');
        for j=1:Features_Quantity
            w_temp(2,j)=w_Brain(2,find(w_Brain(1,:)==w_temp(1,j)));
        end
        feature_num=ceil(Features_Quantity*thr(t));
        w_feature{k,1}=w_temp(2,1:feature_num);
        roi_data=roi_data_input_scaling(:,w_feature{k,:});
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
        [PredictionAccuracy_r(k,t),PredictionAccuracy_p(k,t)]=corr(score_predict,score_behav);
        clear w_temp  w_Brain roi* pre*
    end
end