# 查询数据集变量名称 ----
Search_name <- function(data, patten) {
  names(data)[str_detect(names(data), patten)]
}
