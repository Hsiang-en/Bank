clear all

global data = "/Users/shawn/Documents/Esun"

use $data/panel_multiple.dta, clear








/*Happiness*/
reg performance_multiple sum_diff female seniority if quarter == 0
outreg2 using $data\reg_performance,excel replace ctitle(performance_multiple)
reg performance_multiple sum_diff female seniority master if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(performance_multiple)



reg performance_multiple sum_diff female seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance_multiple)
reg performance_multiple sum_diff female seniority master  if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance_multiple)





**
reg fund_multiple sum_diff female seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple sum_diff female seniority master if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)



reg fund_multiple sum_diff female seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple sum_diff female seniority master  if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)






reg insurance_multiple sum_diff female seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(insurance_multiple)
reg insurance_multiple sum_diff female seniority master if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(insurance_multiple)



reg insurance_multiple sum_diff female seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(insurance_multiple)
reg insurance_multiple sum_diff female seniority master  if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(insurance_multiple)








reg gold_multiple sum_diff female seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(gold_multiple)
reg gold_multiple sum_diff female seniority master if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(gold_multiple)



reg gold_multiple sum_diff female seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(gold_multiple)
reg gold_multiple sum_diff female seniority master  if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(gold_multiple)


