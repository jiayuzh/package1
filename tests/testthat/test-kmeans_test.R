test_that("kmeans works", {
  expect_equal(sum(k_means_cluster(rbind(matrix(rnorm(100, sd = 0.3), ncol = 2),
                                         matrix(rnorm(100, mean = 2, sd = 0.3), ncol = 2)), k)
                   $clusters == 1), 50)
})
