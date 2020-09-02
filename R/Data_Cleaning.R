rm(list = ls())

#設定檔案位置
setwd("/Users/shawn/Documents/Esun")

#讀取資料
install.packages("haven")
library(haven)
data_dta <- read_dta("/Users/shawn/Documents/Esun/fixed_effect.dta")

#設立變數sum_kind
install.packages("dplyr")
library(dplyr)
for (i in 1:10){
  data_dta <- mutate(data_dta, 'i' = i)
}

data_dta <- mutate(data_dta, ug1_kind = ug1_offer - ug1_guess)
data_dta <- mutate(data_dta, ug2_kind = ug2_offer - ug2_guess)
data_dta <- mutate(data_dta, ug3_kind = ug3_offer - ug3_guess)
data_dta <- mutate(data_dta, ug4_kind = ug4_offer - ug4_guess)
data_dta <- mutate(data_dta, ug5_kind = ug5_offer - ug5_guess)
data_dta <- mutate(data_dta, ug6_kind = ug6_offer - ug6_guess)
data_dta <- mutate(data_dta, ug7_kind = ug7_offer - ug7_guess)
data_dta <- mutate(data_dta, ug8_kind = ug8_offer - ug8_guess)
data_dta <- mutate(data_dta, ug9_kind = ug9_offer - ug9_guess)
data_dta <- mutate(data_dta, ug10_kind = ug10_offer - ug10_guess)
data_dta <- mutate(data_dta, sum_kind = ug1_kind + ug2_kind + ug3_kind + ug4_kind + ug5_kind + ug6_kind + ug7_kind + ug8_kind + ug9_kind + ug10_kind)

#performance
model <- lm(formula = performance~sum_kind + Safe_switch_point, data = data_dta)
summary(model)


