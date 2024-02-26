---
title: "Clustering Algorithm"
author: "Nimay"
output:
  html_notebook:
    toc: yes
    toc_float: yes
  html_document:
    toc: yes
    df_print: paged
---

### Part 2.1
```{r}
library("factoextra")
library(cluster)
options("digits"=3)
rm(list=ls())
library(dbscan)
setwd("/Users/nimaysrinivasan/CS-422/CS-422 Homework 8")
df <- read.csv("file19.csv", header=T, sep=",")
set.seed(1122)
```

### Part 2.1-A-i
```{r}
# > Answer: When we look at the the attributes of the data set the name attribute can be changed to animal_name or animal and the other variables have similar names with just the case as difference(lowercase or uppercase) as this is the only non numeric attribute in the data. These can be changed as sometimes it might get tough decoding the results.
rownames(df) <- df[,1]
df <- df [ , -1]
```

### Part 2.1-A-ii
```{r}
# > Answer: Yes, the data needs to be standardized. As when we look the variables closely especially variables "C"(top canines) and "c"(bottom canines) we see that both these variables have a range from 0 to 1. In comparison to other variables where the range is between 0 to 5 thus standardizing and scaling would give us optimized results.
scaled_df <- scale(df)
```

### Part 2.1-A-iii
```{r}
# > Answer: The data set after removing the multiple spaces and after adding the comma character as delimiter we get the uploaded csv file - file19.csv, uploaded in the zip file.
```

### Part 2.1-B
### Part 2.1-B-i
```{r}
fviz_nbclust(scaled_df, kmeans, method="wss")
fviz_nbclust(scaled_df, kmeans, method="silhouette")

# > Answer: When we run the WSS or Silhouette graph using fviz_nbclust we see  the sum of squares in both the plots. In the wss plot the graph dosent decrease much after the 7th pointer, so is the case in the silhouette plot where the average width incrases after the 7th pointer, thus we can take the number of clusters as 7(k=7).
```
### Part 2.1-B-ii
```{r}
kplot <- kmeans(scaled_df, centers=7, nstart=10)
fviz_cluster(kplot, data=scaled_df)  
```
### Part 2.1-B-iii
```{r}
print(kplot['size'])
```

### Part 2.1-B-iv
```{r}
print(kplot['totss'])  
```

### Part 2.1-B-v
```{r}
# (v) What is the SSE of each cluster?
print(kplot['withinss'])
```

### Part 2.1-B-vi
```{r}
for (c in 1:7){
    print(which(kplot$cluster == c))
    print("\n")
}

# Answer > When we look at the output of the clustering the output is clustered properly as the animals are all clustered/grouped mammals according to their respective tooth patterns. This is true as animals with similar tooth patterns have similar eating patterns. The algorithm has clustered carnivorous and water carnivorous mammals as one group then it has clustered small shrub and tree mammals are one group and so on till herbivorous mountain mammals as one group. In this clustering the only outlier is the mammal Armadillo which is grouped into any cluster as the algorithm isn't able to categorize this mammal into any group.
```

### Part 2.2
```{r}
setwd("/Users/nimaysrinivasan/CS-422/CS-422 Homework 8")
df2 <- read.csv("s1.csv", header=T, sep=",")
```

### Part 2.2-A
```{r}
summary(df2)
scaled_df2 <- scale(df2)

# > Answer : Yes it is necessary to standardize the dataset as we just have two variables.When we look the summary of the dataset which has two variables x and y but there ranges are vastly different, thus it is necessary to standardize as after we standardize the ranges are similar.

summary(scaled_df2)
```

### Part 2.2-B
### Part 2.2-B-i
```{r}
data("multishapes", package = "factoextra")
df3 <- multishapes[, 1:2]
plot(df3, main="Raw points before DBSCAN")
```

### Part 2.2-B-ii
```{r}
# > Answer: In this plot we see that when we perform multishapes and factoextra we see that we have a total of five clusters. We see that there are two big clusters and a small cluster in the bottom half of the plot. Then we have a big oval cluster and a smaller oval cluster within the bigger cluster in the top half of the plot.     
```

### Part 2.2-C
### Part 2.2-C-i
```{r}
fviz_nbclust(df3, kmeans, method="wss")
```

### Part 2.2-C-ii
```{r}
fviz_nbclust(df3, kmeans, method="silhouette")
```

### Part 2.2-C-iii
```{r}
# > Answer: When we run the WSS or Silhouette graph using fviz_nbclust we see the sum of squares in both the plots. In the wss plot the graph dosen't decrease much after the 7th pointer, so is the case in the silhouette plot where the average width increases after the 7th pointer, thus we can take the number of clusters as 7(k=7).
```

### Part 2.2-D
### Part 2.2-D-i
```{r}  
kplot2 <- kmeans(df3, centers=7, nstart=5)
fviz_cluster(kplot2, data=df3)
```

### Part 2.2-D-ii
```{r}  
# > Answer: When we look at the plot after the K-Means cluster, it is similar to the outcome from(2.2-B-i). It has not done much to different from the intial clusturing we have performed in (2.2-B-i), it has left the three clusters in the bottom half as the same but it has split the two clusters in the top part into four parts or four clusters.
```

### Part 2.2-E
```{r} 
db <- fpc::dbscan(df3, eps = 0.13, MinPts = 4)
plot(db, df3, main = "DBSCAN", frame = FALSE)
fviz_cluster(db, df3, stand = FALSE, ellipse = F, geom = "point")
print(db)
```

### Part 2.2-E-i
```{r} 
# > Answer: When we observe the dataset we see that it is a 2-dimensional data, therefore am applying MinPts = 2*dimensions of the dataset.
# MinPts = 2*2
# MinPts = 4
```

### Part 2.2-E-ii  
```{r}
dbscan::kNNdistplot(df3, k =  5)
abline(h = 0.13, lty = 2)  

# At minPts = 4 , eps = 0.13, there are 5 clusters.
```
