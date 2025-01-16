## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=F-------------------------------------------------------------------
# install.packages("devtools")
# devtools::install_github("luizesser/chooseGCM")

## ----eval=F-------------------------------------------------------------------
# install.packages("chooseGCM")

## -----------------------------------------------------------------------------
library(chooseGCM)
tictoc::tic()
set.seed(1)

## ----eval=F-------------------------------------------------------------------
# worldclim_data(path = "input_data/WorldClim_data_gcms_all", period = "future", variable = "bioc", year = "2090", gcm = "all", ssp = "585", resolution = 10)

## -----------------------------------------------------------------------------
var_names <- c("bio_1", "bio_12")
s <- import_gcms(system.file("extdata", package = "chooseGCM"), var_names = var_names)

## -----------------------------------------------------------------------------
study_area <- terra::ext(c(-80, -30, -50, 10)) |> terra::vect(crs="epsg:4326")

## -----------------------------------------------------------------------------
res <- compare_gcms(s, var_names, study_area, k = 3)
res$statistics_gcms

## -----------------------------------------------------------------------------
# Summary of GCMs
s_sum <- summary_gcms(s, var_names, study_area)
s_sum

## -----------------------------------------------------------------------------
# Pearson Correlation between GCMs
s_cor <- cor_gcms(s, var_names, study_area, scale = TRUE, method = "pearson")
s_cor

## -----------------------------------------------------------------------------
# Euclidean Distance between GCMs
s_dist <- dist_gcms(s, var_names, study_area, method = "euclidean")
s_dist

## -----------------------------------------------------------------------------
kmeans_gcms(s, var_names, study_area, k = 3, method = "euclidean")

## -----------------------------------------------------------------------------
kmeans_gcms(s, var_names, study_area, k = 3)

## -----------------------------------------------------------------------------
hclust_gcms(s, var_names, study_area, k = 3)

## -----------------------------------------------------------------------------
hclust_gcms(s, var_names, study_area, k = 3, n = 1000)

## -----------------------------------------------------------------------------
optk_gcms(s, var_names, study_area, cluster = "kmeans", method = "wss", n = 1000)

## -----------------------------------------------------------------------------
optk_gcms(s, var_names, study_area, cluster = "kmeans", method = "silhouette", n = 1000)

## -----------------------------------------------------------------------------
optk_gcms(s, var_names, study_area, cluster = "kmeans", method = "gap_stat", n = 1000)

## -----------------------------------------------------------------------------
montecarlo_gcms(s, var_names, study_area, perm = 10000, dist_method = "euclidean", clustering_method = "kmeans")

## -----------------------------------------------------------------------------
montecarlo_gcms(s, var_names, study_area, perm = 10000, dist_method = "euclidean", clustering_method = "closestdist")

## -----------------------------------------------------------------------------
env_gcms(s, var_names, study_area, highlight = res$suggested_gcms$k3)

## -----------------------------------------------------------------------------
env_gcms(s, var_names, study_area, highlight = "sum")

## -----------------------------------------------------------------------------
closestdist_gcms(s, var_names, study_area)

## -----------------------------------------------------------------------------
closestdist_gcms(s, var_names, study_area, k=3)

## -----------------------------------------------------------------------------
tictoc::toc()

