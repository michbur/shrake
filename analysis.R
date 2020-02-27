library(drake)
library(visNetwork)

if(Sys.info()[["nodename"]] %in% c("amyloid", "phobos", "huawei")) {
  data_path <- "/home/michal/Dropbox/shrake-test/"
}

long_fun <- function(x) {
  res <- c()
  for(i in 1L:x)
    res <- c(res, i, sum(res))
  res
}

test_drake_sharing <- drake_plan(long_fun_res = long_fun(7000),
                                 long_fun_plot = plot(long_fun_res[1L:10]))

make(test_drake_sharing, seed = 990)

file.copy(from = ".drake", to = paste0(data_path, "drake-cache"), recursive = TRUE, overwrite = TRUE)

# vis_drake_graph(drake_config(test_drake_sharing))
# 
# shared_cache <- drake_cache(paste0(data_path, "drake-cache/.drake"))
# shared_cache$import(shared_cache)
