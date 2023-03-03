clear 
close all

% load extracted feature matrix for P-2
load data_example

skewness_feature=data.skewness_feature;
channel_label=data.channel_label;


%% z-scoring for each column vector
feature=zscore(skewness_feature);

%% feature visualization
figure;
imagesc(feature)
x_label_1=0:480:length(feature);
x_label_2=x_label_1/60;
set(gca,'xtick',x_label_1,'xticklabels',x_label_2,'FontSize',16,'FontWeight','bold','FontName','TimesNewRoman')
set(gca,'ytick',1:length(channel_label),'yticklabels',channel_label,'FontSize',16,'FontWeight','bold','FontName','TimesNewRoman')

xlabel('Time/min','FontName','TimesNewRoman')

%% evaluate optimal clustering number based on
% elbow method, gap statistic, silhouette score and Davies–Bouldin index
% clustering number from 1-5

eva_elbow=[];
for i=1:5
    i
    [~,~,cluster_sum] = kmeans(feature',i,'Replicates',10);
    eva_elbow=[eva_elbow sum(cluster_sum)/length(feature)];
end

eva_gap = evalclusters(feature','kmeans','gap','KList',1:5);
eva_silhouette = evalclusters(feature','kmeans','silhouette','KList',1:5);
eva_DaviesBouldin = evalclusters(feature','kmeans','DaviesBouldin','KList',1:5);

figure;
subplot(2,2,1)
plot(eva_elbow,'*-')
xlabel('clustering number')
ylabel('Within cluster sum')
subplot(2,2,2)
plot(eva_gap.CriterionValues,'*-')
xlabel('clustering number')
ylabel('Gap')
title('Gap statistic method')
subplot(2,2,3)
plot(eva_silhouette.CriterionValues,'*-')
xlabel('clustering number')
ylabel('silhouette score')
title('Silhouette method')
subplot(2,2,4)
plot(eva_DaviesBouldin.CriterionValues,'*-')
xlabel('clustering number')
ylabel('Davies-Bouldin index')
title('DaviesBouldin method')

%% set optimal clustering number as 3

[idx,C,sumd] = kmeans(feature',3,'Replicates',10);

%% sort cluster centroids with respect to variance
var_C=var(C');

[~,index]=sort(var_C);

%% visualize sorted cluster centroids
figure;
imagesc([C(index(1),:);C(index(2),:);C(index(3),:)]')
set(gca,'xtick',1:3,'xticklabels',{'centroid 1','centroid 2','centroid 3'},'FontSize',16,'FontWeight','bold','FontName','TimesNewRoman')
set(gca,'ytick',1:length(channel_label),'yticklabels',channel_label,'FontSize',16,'FontWeight','bold','FontName','TimesNewRoman')