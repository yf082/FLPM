Search_name <- function(data, patten) {
  names(data)[str_detect(names(data), patten)]
}