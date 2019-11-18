## Selects k raandom unique points from list of Point
## The initialization step of K-means clustering

select_initial_centroids = function(x, k, myseed){
  set.seed(myseed) # set seed to make this process reproducible
  idx = sample(1:nrow(x), k)
  initial_centroids = x[idx, , drop = F]
  return(initial_centroids)
}

## Calculate the Euclidean distance between two points

euclisean_distance = function(x1, x2){
  dist = sqrt((x1 - x2)^2)
  return(dist)
}

## assign points to a cluster, this is the assignment step of k-means

assign_points = function(x, centroids){
  dist_matrix = matrix(rep(0, nrow(x)*k), nrow(x), k)


}
