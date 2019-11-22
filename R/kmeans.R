## Selects k raandom unique points from list of Point
## The initialization step of K-means clustering

select_initial_centroids = function(x, k){
  #set.seed(myseed) # set seed to make this process reproducible
  idx = sample(1:nrow(x), k)
  initial_centroids = x[idx, , drop = F]
  return(initial_centroids)
}

## Calculate the Euclidean distance between two points

euclisean_distance = function(x1, x2){
  dist = sqrt(sum(((x1 - x2)^2)))
  return(dist)
}

## assign points to a cluster, this is the assignment step of k-means
## Args:
## returns clusters

assign_points = function(x, centroids, n, k){
  clusters = rep(0, n)
  for(i in 1:n){
    dist = rep(0, k)
    for(j in 1:k){
      dist[j] = euclisean_distance(x[i, , drop = F], centroids[j, , drop = F])
      #print("distance here and j")
      #print(j)
      #print(dist)
    }
    clusters[i] = which.min(dist) # error here
    #print("update cluster here and i")
    #print(i)
    #print(clusters)
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

check_converge = function(centroids_new, centroids_old, tolerance){
  bool = rep(0, length(centroids_new))
  for(i in 1:nrow(centroids_new)){
    #print(centroids_new)
    #print(centroids_old)
    bool[i] = euclisean_distance(centroids_new[i, ], centroids_old[i, ])
    #print(bool)
  }
  # print(bool)
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
    #print(i)
    # random choose initial centroids:
    centroids = select_initial_centroids(x, k)
    #print("initial centroids")
    #print(centroids)
    for(iter in 1:100000){ # default iteration number = 100000
      # assign each points to the centrods:
      clusters = assign_points(x, centroids, n, k)
      #print("clusters and i")
      #print(i)
      #print(clusters)
      # define new centroids
      centroids_new = define_new_centroids(x, k, clusters, m, n)
      #print("centroids new")
      #print(centroids_new)
      # decide to terminate or not
      if(check_converge(centroids_new, centroids, tolerance) == TRUE){
        centroids = centroids[order(centroids[,1],centroids[,2]), ]
        #return(centroids)
        for(ind in 1:k){
          centroids_list[[ind]][i, ] = centroids[ind, ]
        }
        break
      }else{
        centroids = centroids_new
      }
    }
  }
  ult_centroids = matrix(rep(0, k*m), k, m)
  for (ind in 1:k) {
    ult_centroids[ind, ] = matrixStats::colMedians(centroids_list[[ind]])
  }
  ult_clusters = assign_points(x, centroids, n, k)
  ult_list = list("data" = x, "clusters" = ult_clusters, "centroids" = ult_centroids)
  return(ult_list)

}
