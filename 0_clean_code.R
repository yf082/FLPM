# Title；数据清理
# Author：YSK
# Date：2025-01-06

# 清空环境

rm(list = ls())
cat("\14")

# part I 加载包 & 数据读取 -------------------------------------------------------------

## 加载包
packages = c("tidyverse", "data.table")
lapply(packages, function(x) library(x, character.only = T))

## 读取数据
loc = str_locate_all(getwd(), "/")
iloc = loc[[1]][dim(loc[[1]])[1],dim(loc[[1]])[2]]
setwd(str_sub(getwd(), 1, iloc))

dt = fread(file = "data/dt_all.csv")
source("./FLPM/Functions.R")

# part II 数据清理 ------------------------------------------------------------

# 0 变量名处理 ----
names(dt) = str_remove_all(names(dt), "\\[")
names(dt) = str_remove_all(names(dt), "\\]")


# 1 血生化指标处理 ----
#* 需处理变量 ----
index = c("PatientCode")
liver_makers = c("总蛋白", "白蛋白", "球蛋白", "丙氨酸氨基转移酶", "门冬氨酸氨转移酶", "碱性磷酸酶", "总胆红素", "间接胆红素", "直接胆红素")
kidney_makers = c("尿素", "肌酐", "尿酸")
blood_liqid_makers = c("胆固醇", "甘油三脂",  "高密度脂蛋白", "低密度脂蛋白")
inflammation_makers = c("C-反应蛋白", "高敏C-反应蛋白", "血沉", "血沉方程K 值", "降钙素")
blood_biomakers = all_of(c(liver_makers, kidney_makers, blood_liqid_makers, inflammation_makers))

#* 所有变量数值化 ----
dt_blood_biomakers = dt[,..blood_biomakers][
  , paste0(blood_biomakers) := lapply(.SD, function(x) {gsub("[^0-9]", "", x)}), .SDcols = blood_biomakers][
  , paste0(blood_biomakers) := lapply(.SD, as.numeric), .SDcols = blood_biomakers]