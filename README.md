K Means Package
=========
---

This is Jiayu's R Package

License: MIT

For more information please contact jiayuzh@umich.edu
# Structure #
---

This package includes 6 functions:
* select_initial_centroids: Selects k random points from data matrix
	* The initialization step pf k-means
* cppdist: Caculate the Euclidean distance between two points
* assign_points: assign points to a cluster
	* The assignment step pf k-means 
*  define_new_centroids: create new centroids based on points clusters
	* The update step of k-means
* check_converge: determines if the centroids have reached convergence
* k_means_cluster: the body function



# Installation #
---

Using the 'devtools' package:

    > install.packages("devtools")
    > library(devtools)
    > install_github("silverfoxxxx/package1")


# Usage #
---

### Arguments ###
1. **x** should be a numeric data matrix.
2. **k** should be chosen with consideration; if you have no idea which k to choose, you can refer to Additional Resources.
3. **nstart** is suggested to be no less than 9, which is the default.
4. **tolerance** tolerance convergance value; default is 1e-5.

### Example ###
Create a simulated 2-clustered data matrix with 2 columns, and then run k_means_clustering function with default settings:
	 
	 x = rbind(matrix(rnorm(100, sd = 0.3), ncol = 2),
           matrix(rnorm(100, mean = 1, sd = 0.3), ncol = 2))
     mydata = x
     k = 2
     k_means_cluster(mydata, k)



# Additional Resources #
---
    
To determine which k to choose, can refer to [silhouette](https://www.rdocumentation.org/packages/cluster/versions/2.1.0/topics/silhouette) in [R Documentation](http://https://www.rdocumentation.org/) help pages.
