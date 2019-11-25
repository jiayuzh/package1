#' Algorithm for kmeans clustering of numeric matrix of data
#' @title K-Means Clustering
#' @name k_means_cluster
#'
#' @usage
#' k_means_cluster(x, k, tolerance = 1e-5, nstart = 9)
#'
#' @param x A numeric matrix of data
#' @param k A number of clusters
#' @param tolerance A tolerance number that determines whether the centroids are converge, default is 1e-5
#' @param nstart An iteration number since k-means clustering depends on the initial centroids, default is 9
#'
#' @return The original data matrix \code{x}, a vector of the clusters, a matrix of the coordinates of \code{k} centroids
#' @importFrom matrixStats colMedians
#'
#' @examples
#' x = rbind(matrix(rnorm(100, sd = 0.3), ncol = 2), matrix(rnorm(100, mean = 1, sd = 0.3), ncol = 2))
#' k = 2
#' k_means_cluster(x, k)
#'
#' @export
#'

## usethis namespace: start
#' @useDynLib package1, .registration = TRUE
## usethis namespace: end
NULL

## usethis namespace: start
#' @importFrom Rcpp sourceCpp
## usethis namespace: end
NULL


library(matrixStats)
library(Rcpp)

## Selects k random unique points from list of Point
## The initialization step of K-means clustering

select_initial_centroids = function(x, k){
  #set.seed(myseed) # set seed to make this process reproducible
  idx = sample(1:nrow(x), k)
  initial_centroids = x[idx, , drop = F]
  return(initial_centroids)
}

## Calculate the Euclidean distance between two points

#cppFunction('
 #           double cppdist(NumericVector x1, NumericVector x2, double size){
  #            double sum = 0;
   #           for(int i=0; i<size; i++){
    #            sum += (x1[i] - x2[i]) * (x1[i] - x2[i]);
     #         }
      #        return sum;
       #     }
#)

#euclisean_distance = function(sum){
#  return(sqrt(sum))
#}

## assign points to a cluster, this is the assignment step of k-means
## Args:
## returns clusters

assign_points = function(x, centroids, n, k, m){
  clusters = rep(0, n)
  for(i in 1:n){
    dist = rep(0, k)
    for(j in 1:k){
      dist[j] = sqrt(cppdist(x[i, , drop = F], centroids[j, , drop = F], m))
    }
    clusters[i] = which.min(dist)
  }
  return(clusters)
}

## create new centroids based on points clusters
## this is the Update step of kmeans
## Args:
## returns new centroids

define_new_centroids = function(x, k, clusters, m, n){
  centroids_new = matrix(rep(0, k*m), k, m)
  for(i in 1:k){
    if(sum(clusters == i) == 1){
      centroids_new[i, ] = x[clusters == i, , drop = F]
    }else if(sum(clusters == i) == 0){
      centroids_new[i, ] = x[sample(1:n, 1), , drop = F]
    }else{
      centroids_new[i, ] = colMeans(x[clusters == i, , drop = F])
    }
  }
  return(centroids_new)
}

## determines if the centroids have reached convergence
## Args:
## returns bool: whether centroids_new and centroids_old are within tolerance

check_converge = function(centroids_new, centroids_old, tolerance, m){
  bool = rep(0, length(centroids_new))
  for(i in 1:nrow(centroids_new)){
    bool[i] = sqrt(cppdist(centroids_new[i, ], centroids_old[i, ], m))
  }
  if(all(bool < tolerance)){
    return(TRUE)
  }else{
    return(FALSE)
  }
}

## Algorithm for kmeans clustering of numeric matrix of data
## Args:
## returns clusters of all data points

k_means_cluster = function(x, k, tolerance = 1e-5, nstart = 9){
  n = nrow(x)
  m = ncol(x)
  mono = matrix(rep(0, nstart*m), nstart, m)
  centroids_list = replicate(k, mono, simplify = F)

  for(i in 1:nstart){
    # random choose initial centroids:
    centroids = select_initial_centroids(x, k)
    for(iter in 1:100000){ # default iteration number = 100000
      # assign each points to the centrods:
      clusters = assign_points(x, centroids, n, k, m)
      # define new centroids
      centroids_new = define_new_centroids(x, k, clusters, m, n)
      # decide to terminate or not
      if(check_converge(centroids_new, centroids, tolerance, m) == TRUE){
        centroids = centroids[order(centroids[,1],centroids[,2]), ]
        for(ind in 1:k){
          centroids_list[[ind]][i, ] = centroids[ind, ]
        }
        break
      }else{
        centroids = centroids_new
      }
    }
  }

  # Using the robust centroids to assign clusters
  ult_centroids = matrix(rep(0, k*m), k, m)
  for (ind in 1:k) {
    ult_centroids[ind, ] = matrixStats::colMedians(centroids_list[[ind]])
  }

  # Writing outputs in a list
  ult_clusters = assign_points(x, centroids, n, k, m)
  ult_list = list("data" = x, "clusters" = ult_clusters, "centroids" = ult_centroids)
  return(ult_list)

}
