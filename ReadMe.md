# Spatial pattern clustering of high frequency activity (SPC-HFA)
This is the example implementation of the algorithm in the paper entitled [Automatic Epileptic Tissue Localization through Spatial Pattern Clustering of High Frequency Activity](https://ieeexplore.ieee.org/document/10018254). SPC-HFA mainly includes 4 steps:

1. **Data processing and feature extraction**: include bandpass filtering in high-frequency band (80-500 Hz), envelope extraction and segmentation. The extracted feature is skewness. This part is illustrated in detail in this repo [SFC](https://github.com/shenmusmart/SFC) and omitted here.

2. **Evaluation of opitimal clustering number**: include elbow method, gap statistic, silhouette score and Davies–Bouldin index.

3. **Clustering with k-means** : perform clustering based on k-means with 10 repititions and k-means++ random initialization.

4. **Localization**: sorting cluster centroids with respect to variance and picking the centeroid with the largest variance

For more details, please refer to this paper:

[1] M. Shen et al., “Automatic Epileptic Tissue Localization Through Spatial Pattern Clustering of High Frequency Activity,” IEEE Transactions on Neural Systems and Rehabilitation Engineering, vol. 31, pp. 981–990, 2023, doi: 10.1109/tnsre.2023.3237226.