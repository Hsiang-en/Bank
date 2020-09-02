clear all

global data = "/Users/shawn/Documents/Esun"

capture log close
 
set more off

//Import data
use $data/regression_seasonal.dta, replace






/*gen avg_offer變數*/
gen avg_offer = (ug1_offer + ug2_offer + ug3_offer + ug4_offer + ug5_offer ///
+ ug6_offer + ug7_offer + ug8_offer + ug9_offer + ug10_offer) / 10






/*gen一個multiple的變數*/
gen performance_allyear_multiple = 0
replace performance_allyear_multiple = 16 if performance == 1
replace performance_allyear_multiple = 12 if performance == 2
replace performance_allyear_multiple = 10 if performance == 3
replace performance_allyear_multiple = 9 if performance == 4
replace performance_allyear_multiple = 7 if performance == 5
replace performance_allyear_multiple = 6 if performance == 6
replace performance_allyear_multiple = 5 if performance == 7
replace performance_allyear_multiple = 4 if performance == 8
replace performance_allyear_multiple = 3 if performance == 9
replace performance_allyear_multiple = 1 if performance == 10

gen fund_allyear_multiple = 0
replace fund_allyear_multiple = 20 if fund == 1
replace fund_allyear_multiple = 13 if fund == 2
replace fund_allyear_multiple = 11 if fund == 3
replace fund_allyear_multiple = 9 if fund == 4
replace fund_allyear_multiple = 8 if fund == 5
replace fund_allyear_multiple = 6 if fund == 6
replace fund_allyear_multiple = 5 if fund == 7
replace fund_allyear_multiple = 4 if fund == 8
replace fund_allyear_multiple = 2 if fund == 9
replace fund_allyear_multiple = 1 if fund == 10

gen insurance_allyear_multiple = 0
replace insurance_allyear_multiple = 24 if insurance == 1
replace insurance_allyear_multiple = 15 if insurance == 2
replace insurance_allyear_multiple = 12 if insurance == 3
replace insurance_allyear_multiple = 10 if insurance == 4
replace insurance_allyear_multiple = 9 if insurance == 5
replace insurance_allyear_multiple = 7 if insurance == 6
replace insurance_allyear_multiple = 6 if insurance == 7
replace insurance_allyear_multiple = 4 if insurance == 8
replace insurance_allyear_multiple = 3 if insurance == 9
replace insurance_allyear_multiple = 1 if insurance == 10

gen gold_allyear_multiple = 0
replace gold_allyear_multiple = 15650 if gold == 1
replace gold_allyear_multiple = 6381 if gold == 2
replace gold_allyear_multiple = 3923 if gold == 3
replace gold_allyear_multiple = 2325 if gold == 4
replace gold_allyear_multiple = 1508 if gold == 5
replace gold_allyear_multiple = 785 if gold == 6
replace gold_allyear_multiple = 368 if gold == 7
replace gold_allyear_multiple = 134 if gold == 8
replace gold_allyear_multiple = 37 if gold == 9
replace gold_allyear_multiple = 1 if gold == 10



/*reg*/
/* peformance */
reg performance_allyear_multiple sum_diff ranking ranking_group female master ///
seniority Safe_switch_point
outreg2 using $data\reg_performance,excel replace ctitle(綜合績效績效區間)


reg performance_allyear_multiple sum_diff
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_allyear_multiple Safe_switch_point
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_allyear_multiple sum_diff Safe_switch_point
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_allyear_multiple sum_diff female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_allyear_multiple Safe_switch_point female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_allyear_multiple sum_diff Safe_switch_point female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)

reg performance_allyear_multiple ranking
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_allyear_multiple Safe_switch_point
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_allyear_multiple ranking Safe_switch_point
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_allyear_multiple ranking female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_allyear_multiple Safe_switch_point female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_allyear_multiple ranking Safe_switch_point female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)

reg performance_allyear_multiple ranking_group
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_allyear_multiple Safe_switch_point
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_allyear_multiple ranking_group Safe_switch_point
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_allyear_multiple ranking_group female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_allyear_multiple Safe_switch_point female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_allyear_multiple ranking_group Safe_switch_point female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)





/*增加一些covariates*/
gen m1 = time_switch_point 
gen m2 = aver_offer
gen m3 = sum_coinright
gen m4 = sum_fin
gen m5 = sum_cog 

reg performance_allyear_multiple sum_diff ranking ranking_group female master ///
seniority Safe_switch_point m1 m2 m3 m4 m5
outreg2 using $data\reg_performance,excel replace ctitle(綜合績效績效區間)

forvalues i =1(1)5 {
	reg performance_allyear_multiple sum_diff m`i'
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_allyear_multiple Safe_switch_point m`i'
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_allyear_multiple sum_diff Safe_switch_point m`i'
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_allyear_multiple sum_diff female master seniority m`i'
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_allyear_multiple Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_allyear_multiple sum_diff Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)

	reg performance_allyear_multiple ranking m`i'
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_allyear_multiple Safe_switch_point m`i'
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_allyear_multiple ranking Safe_switch_point m`i'
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_allyear_multiple ranking female master seniority m`i'
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_allyear_multiple Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_allyear_multiple ranking Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)

	reg performance_allyear_multiple ranking_group m`i'
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_allyear_multiple Safe_switch_point m`i'
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_allyear_multiple ranking_group Safe_switch_point m`i'
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_allyear_multiple ranking_group female master seniority m`i'
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_allyear_multiple Safe_switch_point female master seniority m`i' 
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_allyear_multiple ranking_group Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
}







/*reg*/
/* fund */
reg fund_allyear_multiple sum_diff ranking ranking_group female master ///
seniority Safe_switch_point
outreg2 using $data\reg_performance,excel replace ctitle(基金手收績效區間)


reg fund_allyear_multiple sum_diff
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_allyear_multiple Safe_switch_point
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_allyear_multiple sum_diff Safe_switch_point
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_allyear_multiple sum_diff female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_allyear_multiple Safe_switch_point female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_allyear_multiple sum_diff Safe_switch_point female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)

reg fund_allyear_multiple ranking
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_allyear_multiple Safe_switch_point
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_allyear_multiple ranking Safe_switch_point
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_allyear_multiple ranking female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_allyear_multiple Safe_switch_point female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_allyear_multiple ranking Safe_switch_point female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)

reg fund_allyear_multiple ranking_group
outregallyear_multiple ranking_group Safe_switch_point
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_allyear_multiple ranking_group female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_allyear_multiple Safe_switch_point female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_allyear_multiple ranking_group Safe_switch_point female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間) 
reg fund_allyear_multiple Safe_switch_point
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)






/*增加一些covariates*/

reg fund_allyear_multiple sum_diff ranking ranking_group female master ///
seniority Safe_switch_point m1 m2 m3 m4 m5
outreg2 using $data\reg_fund,excel replace ctitle(基金手收績效區間)

forvalues i =1(1)5 {
	reg fund_allyear_multiple sum_diff m`i'
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_allyear_multiple Safe_switch_point m`i'
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_allyear_multiple sum_diff Safe_switch_point m`i'
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_allyear_multiple sum_diff female master seniority m`i'
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_allyear_multiple Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_allyear_multiple sum_diff Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)

	reg fund_allyear_multiple ranking m`i'
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_allyear_multiple Safe_switch_point m`i'
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_allyear_multiple ranking Safe_switch_point m`i'
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_allyear_multiple ranking female master seniority m`i'
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_allyear_multiple Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_allyear_multiple ranking Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)

	reg fund_allyear_multiple ranking_group m`i'
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_allyear_multiple Safe_switch_point m`i'
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_allyear_multiple ranking_group Safe_switch_point m`i'
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_allyear_multiple ranking_group female master seniority m`i'
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_allyear_multiple Safe_switch_point female master seniority m`i' 
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_allyear_multiple ranking_group Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
}









/*reg*/
/* insurance */
reg insurance_allyear_multiple sum_diff ranking ranking_group female master ///
seniority Safe_switch_point
outreg2 using $data\reg_insurance,excel replace ctitle(保險手收績效區間)


reg insurance_allyear_multiple sum_diff
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_allyear_multiple Safe_switch_point
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_allyear_multiple sum_diff Safe_switch_point
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_allyear_multiple sum_diff female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_allyear_multiple Safe_switch_point female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_allyear_multiple sum_diff Safe_switch_point female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)

reg insurance_allyear_multiple ranking
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_allyear_multiple Safe_switch_point
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_allyear_multiple ranking Safe_switch_point
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_allyear_multiple ranking female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_allyear_multiple Safe_switch_point female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_allyear_multiple ranking Safe_switch_point female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)

reg insurance_allyear_multiple ranking_group
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_allyear_multiple Safe_switch_point
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_allyear_multiple ranking_group female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_allyear_multiple Safe_switch_point female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_allyear_multiple ranking_group Safe_switch_point female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間) 
reg insurance_allyear_multiple Safe_switch_point
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)






/*增加一些covariates*/

reg insurance_allyear_multiple sum_diff ranking ranking_group female master ///
seniority Safe_switch_point m1 m2 m3 m4 m5
outreg2 using $data\reg_insurance,excel replace ctitle(保險手收績效區間)

forvalues i =1(1)5 {
	reg insurance_allyear_multiple sum_diff m`i'
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_allyear_multiple Safe_switch_point m`i'
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_allyear_multiple sum_diff Safe_switch_point m`i'
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_allyear_multiple sum_diff female master seniority m`i'
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_allyear_multiple Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_allyear_multiple sum_diff Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)

	reg insurance_allyear_multiple ranking m`i'
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_allyear_multiple Safe_switch_point m`i'
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_allyear_multiple ranking Safe_switch_point m`i'
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_allyear_multiple ranking female master seniority m`i'
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_allyear_multiple Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_allyear_multiple ranking Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)

	reg insurance_allyear_multiple ranking_group m`i'
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_allyear_multiple Safe_switch_point m`i'
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_allyear_multiple ranking_group Safe_switch_point m`i'
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_allyear_multiple ranking_group female master seniority m`i'
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_allyear_multiple Safe_switch_point female master seniority m`i' 
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_allyear_multiple ranking_group Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
}








/*reg*/
/* gold*/
reg gold_allyear_multiple sum_diff ranking ranking_group female master ///
seniority Safe_switch_point
outreg2 using $data\reg_gold,excel replace ctitle(金品手收績效區間)


reg gold_allyear_multiple sum_diff
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_allyear_multiple Safe_switch_point
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_allyear_multiple sum_diff Safe_switch_point
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_allyear_multiple sum_diff female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_allyear_multiple Safe_switch_point female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_allyear_multiple sum_diff Safe_switch_point female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)

reg gold_allyear_multiple ranking
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_allyear_multiple Safe_switch_point
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_allyear_multiple ranking Safe_switch_point
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_allyear_multiple ranking female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_allyear_multiple Safe_switch_point female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_allyear_multiple ranking Safe_switch_point female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)

reg gold_allyear_multiple ranking_group
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_allyear_multiple Safe_switch_point
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_allyear_multiple ranking_group female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_allyear_multiple Safe_switch_point female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_allyear_multiple ranking_group Safe_switch_point female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間) 
reg gold_allyear_multiple Safe_switch_point
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)






/*增加一些covariates*/

reg gold_allyear_multiple sum_diff ranking ranking_group female master ///
seniority Safe_switch_point m1 m2 m3 m4 m5
outreg2 using $data\reg_gold,excel replace ctitle(金品手收績效區間)

forvalues i =1(1)5 {
	reg gold_allyear_multiple sum_diff m`i'
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_allyear_multiple Safe_switch_point m`i'
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_allyear_multiple sum_diff Safe_switch_point m`i'
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_allyear_multiple sum_diff female master seniority m`i'
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_allyear_multiple Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_allyear_multiple sum_diff Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)

	reg gold_allyear_multiple ranking m`i'
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_allyear_multiple Safe_switch_point m`i'
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_allyear_multiple ranking Safe_switch_point m`i'
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_allyear_multiple ranking female master seniority m`i'
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_allyear_multiple Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_allyear_multiple ranking Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)

	reg gold_allyear_multiple ranking_group m`i'
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_allyear_multiple Safe_switch_point m`i'
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_allyear_multiple ranking_group Safe_switch_point m`i'
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_allyear_multiple ranking_group female master seniority m`i'
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_allyear_multiple Safe_switch_point female master seniority m`i' 
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_allyear_multiple ranking_group Safe_switch_point female master seniority m`i'
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
}








/*改成panel data*/
ren performance performance_allyear
ren fund fund_allyear
ren insurance insurance_allyear
ren gold gold_allyear
forvalues i = 1(1)4{
  ren performance_Q`i' performance`i'
  ren fund_Q`i' fund`i'
  ren insurance_Q`i' insurance`i'
  ren gold_Q`i' gold`i'
}
reshape long performance fund insurance gold,i(hash_No) j(q) string

destring q, gen (quarter) force
drop if q == "_allyear_multiple"






/*fixed-effect*/
egen hash_number = group(hash_No)







/*對四季資料生成倍率*/
/*performance*/
gen performance_multiple = 0
replace performance_multiple = 405 if performance == 1 & quarter == 1 
replace performance_multiple = 275 if performance == 2 & quarter == 1 
replace performance_multiple = 225 if performance == 3 & quarter == 1 
replace performance_multiple = 180 if performance == 4 & quarter == 1 
replace performance_multiple = 148 if performance == 5 & quarter == 1 
replace performance_multiple = 123 if performance == 6 & quarter == 1 
replace performance_multiple = 95 if performance == 7 & quarter == 1 
replace performance_multiple = 65 if performance == 8 & quarter == 1 
replace performance_multiple = 31 if performance == 9 & quarter == 1 
replace performance_multiple = 1 if performance == 10 & quarter == 1 

replace performance_multiple = 41 if performance == 1 & quarter == 2 
replace performance_multiple = 28 if performance == 2 & quarter == 2 
replace performance_multiple = 22 if performance == 3 & quarter == 2 
replace performance_multiple = 18 if performance == 4 & quarter == 2 
replace performance_multiple = 15 if performance == 5 & quarter == 2 
replace performance_multiple = 13 if performance == 6 & quarter == 2 
replace performance_multiple = 11 if performance == 7 & quarter == 2 
replace performance_multiple = 8 if performance == 8 & quarter == 2 
replace performance_multiple = 5 if performance == 9 & quarter == 2 
replace performance_multiple = 1 if performance == 10 & quarter == 2 

replace performance_multiple = 19 if performance == 1 & quarter == 3 
replace performance_multiple = 13 if performance == 2 & quarter == 3 
replace performance_multiple = 10 if performance == 3 & quarter == 3 
replace performance_multiple = 9 if performance == 4 & quarter == 3 
replace performance_multiple = 7 if performance == 5 & quarter == 3 
replace performance_multiple = 6 if performance == 6 & quarter == 3 
replace performance_multiple = 5 if performance == 7 & quarter == 3 
replace performance_multiple = 4 if performance == 8 & quarter == 3 
replace performance_multiple = 3 if performance == 9 & quarter == 3 
replace performance_multiple = 1 if performance == 10 & quarter == 3 

replace performance_multiple = 16 if performance == 1 & quarter == 4 
replace performance_multiple = 10 if performance == 2 & quarter == 4 
replace performance_multiple = 8 if performance == 3 & quarter == 4 
replace performance_multiple = 7 if performance == 4 & quarter == 4 
replace performance_multiple = 6 if performance == 5 & quarter == 4 
replace performance_multiple = 5 if performance == 6 & quarter == 4 
replace performance_multiple = 4 if performance == 7 & quarter == 4 
replace performance_multiple = 3 if performance == 8 & quarter == 4 
replace performance_multiple = 2 if performance == 9 & quarter == 4 
replace performance_multiple = 1 if performance == 10 & quarter == 4 







/*fund*/
gen fund_multiple = 0
replace fund_multiple = 1160 if fund == 1 & quarter == 1 
replace fund_multiple = 501 if fund == 2 & quarter == 1 
replace fund_multiple = 360 if fund == 3 & quarter == 1 
replace fund_multiple = 287 if fund == 4 & quarter == 1 
replace fund_multiple = 215 if fund == 5 & quarter == 1 
replace fund_multiple = 154 if fund == 6 & quarter == 1 
replace fund_multiple = 106 if fund == 7 & quarter == 1 
replace fund_multiple = 77 if fund == 8 & quarter == 1 
replace fund_multiple = 32 if fund == 9 & quarter == 1 
replace fund_multiple = 1 if fund == 10 & quarter == 1 

replace fund_multiple = 53 if fund == 1 & quarter == 2 
replace fund_multiple = 33 if fund == 2 & quarter == 2 
replace fund_multiple = 26 if fund == 3 & quarter == 2 
replace fund_multiple = 22 if fund == 4 & quarter == 2 
replace fund_multiple = 17 if fund == 5 & quarter == 2 
replace fund_multiple = 14 if fund == 6 & quarter == 2 
replace fund_multiple = 11 if fund == 7 & quarter == 2 
replace fund_multiple = 7 if fund == 8 & quarter == 2 
replace fund_multiple = 4 if fund == 9 & quarter == 2 
replace fund_multiple = 1 if fund == 10 & quarter == 2 

replace fund_multiple = 28 if fund == 1 & quarter == 3 
replace fund_multiple = 19 if fund == 2 & quarter == 3 
replace fund_multiple = 15 if fund == 3 & quarter == 3 
replace fund_multiple = 12 if fund == 4 & quarter == 3 
replace fund_multiple = 10 if fund == 5 & quarter == 3 
replace fund_multiple = 8 if fund == 6 & quarter == 3 
replace fund_multiple = 6 if fund == 7 & quarter == 3 
replace fund_multiple = 5 if fund == 8 & quarter == 3 
replace fund_multiple = 3 if fund == 9 & quarter == 3 
replace fund_multiple = 1 if fund == 10 & quarter == 3 

replace fund_multiple = 21 if fund == 1 & quarter == 4 
replace fund_multiple = 14 if fund == 2 & quarter == 4 
replace fund_multiple = 11 if fund == 3 & quarter == 4 
replace fund_multiple = 10 if fund == 4 & quarter == 4 
replace fund_multiple = 8 if fund == 5 & quarter == 4 
replace fund_multiple = 6 if fund == 6 & quarter == 4 
replace fund_multiple = 5 if fund == 7 & quarter == 4 
replace fund_multiple = 4 if fund == 8 & quarter == 4 
replace fund_multiple = 3 if fund == 9 & quarter == 4 
replace fund_multiple = 1 if fund == 10 & quarter == 4 








/*insurance*/
gen insurance_multiple = 0
replace insurance_multiple = 19 if insurance == 1 & quarter == 1 
replace insurance_multiple = 12 if insurance == 2 & quarter == 1 
replace insurance_multiple = 9 if insurance == 3 & quarter == 1 
replace insurance_multiple = 7 if insurance == 4 & quarter == 1 
replace insurance_multiple = 5 if insurance == 5 & quarter == 1 
replace insurance_multiple = 5 if insurance == 6 & quarter == 1 
replace insurance_multiple = 3 if insurance == 7 & quarter == 1 
replace insurance_multiple = 2 if insurance == 8 & quarter == 1 
replace insurance_multiple = 1 if insurance == 9 & quarter == 1 

replace insurance_multiple = 98 if insurance == 1 & quarter == 2 
replace insurance_multiple = 54 if insurance == 2 & quarter == 2 
replace insurance_multiple = 41 if insurance == 3 & quarter == 2 
replace insurance_multiple = 32 if insurance == 4 & quarter == 2 
replace insurance_multiple = 26 if insurance == 5 & quarter == 2 
replace insurance_multiple = 21 if insurance == 6 & quarter == 2 
replace insurance_multiple = 15 if insurance == 7 & quarter == 2 
replace insurance_multiple = 11 if insurance == 8 & quarter == 2 
replace insurance_multiple = 7 if insurance == 9 & quarter == 2 
replace insurance_multiple = 1 if insurance == 10 & quarter == 2 

replace insurance_multiple = 69 if insurance == 1 & quarter == 3 
replace insurance_multiple = 35 if insurance == 2 & quarter == 3 
replace insurance_multiple = 24 if insurance == 3 & quarter == 3 
replace insurance_multiple = 18 if insurance == 4 & quarter == 3 
replace insurance_multiple = 14 if insurance == 5 & quarter == 3 
replace insurance_multiple = 11 if insurance == 6 & quarter == 3 
replace insurance_multiple = 9 if insurance == 7 & quarter == 3 
replace insurance_multiple = 6 if insurance == 8 & quarter == 3 
replace insurance_multiple = 4 if insurance == 9 & quarter == 3 
replace insurance_multiple = 1 if insurance == 10 & quarter == 3 

replace insurance_multiple = 116 if insurance == 1 & quarter == 4 
replace insurance_multiple = 60 if insurance == 2 & quarter == 4 
replace insurance_multiple = 42 if insurance == 3 & quarter == 4 
replace insurance_multiple = 33 if insurance == 4 & quarter == 4 
replace insurance_multiple = 27 if insurance == 5 & quarter == 4 
replace insurance_multiple = 22 if insurance == 6 & quarter == 4 
replace insurance_multiple = 15 if insurance == 7 & quarter == 4 
replace insurance_multiple = 9 if insurance == 8 & quarter == 4 
replace insurance_multiple = 5 if insurance == 9 & quarter == 4 
replace insurance_multiple = 1 if insurance == 10 & quarter == 4 








/*gold*/
gen gold_multiple = 0
replace gold_multiple = 96941 if gold == 1 & quarter == 1 
replace gold_multiple = 38818 if gold == 2 & quarter == 1 
replace gold_multiple = 20680 if gold == 3 & quarter == 1 
replace gold_multiple = 10789 if gold == 4 & quarter == 1 
replace gold_multiple = 4484 if gold == 5 & quarter == 1 
replace gold_multiple = 910 if gold == 6 & quarter == 1 
replace gold_multiple = 205 if gold == 7 & quarter == 1 
replace gold_multiple = 1 if gold == 8 & quarter == 1 

replace gold_multiple = 12147 if gold == 1 & quarter == 2 
replace gold_multiple = 5502 if gold == 2 & quarter == 2 
replace gold_multiple = 2431 if gold == 3 & quarter == 2 
replace gold_multiple = 1330 if gold == 4 & quarter == 2 
replace gold_multiple = 583 if gold == 5 & quarter == 2 
replace gold_multiple = 192 if gold == 6 & quarter == 2 
replace gold_multiple = 51 if gold == 7 & quarter == 2 
replace gold_multiple = 1 if gold == 8 & quarter == 2 

replace gold_multiple = 3223 if gold == 1 & quarter == 3 
replace gold_multiple = 1014 if gold == 2 & quarter == 3 
replace gold_multiple = 563 if gold == 3 & quarter == 3 
replace gold_multiple = 310 if gold == 4 & quarter == 3 
replace gold_multiple = 163 if gold == 5 & quarter == 3 
replace gold_multiple = 64 if gold == 6 & quarter == 3 
replace gold_multiple = 25 if gold == 7 & quarter == 3 
replace gold_multiple = 1 if gold == 8 & quarter == 3 


replace gold_multiple = 3673 if gold == 1 & quarter == 4 
replace gold_multiple = 1480 if gold == 2 & quarter == 4 
replace gold_multiple = 707 if gold == 3 & quarter == 4 
replace gold_multiple = 358 if gold == 4 & quarter == 4 
replace gold_multiple = 142 if gold == 5 & quarter == 4 
replace gold_multiple = 61 if gold == 6 & quarter == 4 
replace gold_multiple = 24 if gold == 7 & quarter == 4 
replace gold_multiple = 1 if gold == 8 & quarter == 4 









/**/
replace performance_multiple = 16 if performance == 1 & quarter == .
replace performance_multiple = 12 if performance == 2 & quarter == .
replace performance_multiple = 10 if performance == 3 & quarter == .
replace performance_multiple = 9 if performance == 4 & quarter == .
replace performance_multiple = 7 if performance == 5 & quarter == .
replace performance_multiple = 6 if performance == 6 & quarter == .
replace performance_multiple = 5 if performance == 7 & quarter == .
replace performance_multiple = 4 if performance == 8 & quarter == .
replace performance_multiple = 3 if performance == 9 & quarter == .
replace performance_multiple = 1 if performance == 10 & quarter == .

replace fund_multiple = 20 if fund == 1 & quarter == .
replace fund_multiple = 13 if fund == 2 & quarter == .
replace fund_multiple = 11 if fund == 3 & quarter == .
replace fund_multiple = 9 if fund == 4 & quarter == .
replace fund_multiple = 8 if fund == 5 & quarter == .
replace fund_multiple = 6 if fund == 6 & quarter == .
replace fund_multiple = 5 if fund == 7 & quarter == .
replace fund_multiple = 4 if fund == 8 & quarter == .
replace fund_multiple = 2 if fund == 9 & quarter == .
replace fund_multiple = 1 if fund == 10 & quarter == .

replace insurance_multiple = 24 if insurance == 1 & quarter == .
replace insurance_multiple = 15 if insurance == 2 & quarter == .
replace insurance_multiple = 12 if insurance == 3 & quarter == .
replace insurance_multiple = 10 if insurance == 4 & quarter == .
replace insurance_multiple = 9 if insurance == 5 & quarter == .
replace insurance_multiple = 7 if insurance == 6 & quarter == .
replace insurance_multiple = 6 if insurance == 7 & quarter == .
replace insurance_multiple = 4 if insurance == 8 & quarter == .
replace insurance_multiple = 3 if insurance == 9 & quarter == .
replace insurance_multiple = 1 if insurance == 10 & quarter == .

replace gold_multiple = 15650 if gold == 1 & quarter == .
replace gold_multiple = 6381 if gold == 2 & quarter == .
replace gold_multiple = 3923 if gold == 3 & quarter == .
replace gold_multiple = 2325 if gold == 4 & quarter == .
replace gold_multiple = 1508 if gold == 5 & quarter == .
replace gold_multiple = 785 if gold == 6 & quarter == .
replace gold_multiple = 368 if gold == 7 & quarter == .
replace gold_multiple = 134 if gold == 8 & quarter == .
replace gold_multiple = 37 if gold == 9 & quarter == .
replace gold_multiple = 1 if gold == 10 & quarter == .








/*regression*/

reg performance_multiple sum_diff ranking ranking_group female master ///
seniority Safe_switch_point  ,cluster(hash_number)
outreg2 using $data\reg_performance,excel replace ctitle(綜合績效績效區間)


reg performance_multiple sum_diff ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_multiple Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_multiple sum_diff Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_multiple sum_diff female master seniority ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_multiple Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_multiple sum_diff Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)

reg performance_multiple ranking ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_multiple Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_multiple ranking Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_multiple ranking female master seniority ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_multiple Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_multiple ranking Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)

reg performance_multiple ranking_group ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_multiple Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_multiple ranking_group Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_multiple ranking_group female master seniority ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_multiple Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance_multiple ranking_group Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)





/*增加一些covariates*/
gen m1 = time_switch_point 
gen m2 = aver_offer
gen m3 = sum_coinright
gen m4 = sum_fin
gen m5 = sum_cog 

reg performance_multiple sum_diff ranking ranking_group female master ///
seniority Safe_switch_point m1 m2 m3 m4 m5 ,cluster(hash_number)
outreg2 using $data\reg_performance,excel replace ctitle(綜合績效績效區間)

forvalues i =1(1)5 {
	reg performance_multiple sum_diff m`i' ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_multiple Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_multiple sum_diff Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_multiple sum_diff female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_multiple Safe_switch_point female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_multiple sum_diff Safe_switch_point female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)

	reg performance_multiple ranking m`i' ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_multiple Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_multiple ranking Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_multiple ranking female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_multiple Safe_switch_point female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_multiple ranking Safe_switch_point female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)

	reg performance_multiple ranking_group m`i' ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_multiple Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_multiple ranking_group Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_multiple ranking_group female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_multiple Safe_switch_point female master seniority m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
	reg performance_multiple ranking_group Safe_switch_point female master seniority m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
}







/*reg*/
/* fund */
reg fund_multiple sum_diff ranking ranking_group female master ///
seniority Safe_switch_point  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel replace ctitle(基金手收績效區間)


reg fund_multiple sum_diff  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_multiple Safe_switch_point  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_multiple sum_diff Safe_switch_point  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_multiple sum_diff female master seniority  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_multiple Safe_switch_point female master seniority  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_multiple sum_diff Safe_switch_point female master seniority  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)

reg fund_multiple ranking  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_multiple Safe_switch_point  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_multiple ranking Safe_switch_point  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_multiple ranking female master seniority  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_multiple Safe_switch_point female master seniority  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_multiple ranking Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)

reg fund_multiple ranking_group  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_multiple Safe_switch_point  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_multiple ranking_group Safe_switch_point  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_multiple ranking_group female master seniority  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_multiple Safe_switch_point female master seniority  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund_multiple ranking_group Safe_switch_point female master seniority  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)






/*增加一些covariates*/

reg fund_multiple sum_diff ranking ranking_group female master ///
seniority Safe_switch_point m1 m2 m3 m4 m5  ,cluster(hash_number)
outreg2 using $data\reg_fund,excel replace ctitle(基金手收績效區間)

forvalues i =1(1)5 {
	reg fund_multiple sum_diff m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_multiple Safe_switch_point m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_multiple sum_diff Safe_switch_point m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_multiple sum_diff female master seniority m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_multiple Safe_switch_point female master seniority m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_multiple sum_diff Safe_switch_point female master seniority m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)

	reg fund_multiple ranking m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_multiple Safe_switch_point m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_multiple ranking Safe_switch_point m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_multiple ranking female master seniority m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_multiple Safe_switch_point female master seniority m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_multiple ranking Safe_switch_point female master seniority m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)

	reg fund_multiple ranking_group m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_multiple Safe_switch_point m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_multiple ranking_group Safe_switch_point m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_multiple ranking_group female master seniority m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_multiple Safe_switch_point female master seniority m`i'   ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
	reg fund_multiple ranking_group Safe_switch_point female master seniority m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
}









/*reg*/
/* insurance */
reg insurance_multiple sum_diff ranking ranking_group female master ///
seniority Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel replace ctitle(保險手收績效區間)


reg insurance_multiple sum_diff ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_multiple Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_multiple sum_diff Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_multiple sum_diff female master seniority ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_multiple Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_multiple sum_diff Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)

reg insurance_multiple ranking ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_multiple Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_multiple ranking Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_multiple ranking female master seniority ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_multiple Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_multiple ranking Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)

reg insurance_multiple ranking_group ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_multiple Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_multiple ranking_group female master seniority ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_multiple Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance_multiple ranking_group Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間) 
reg insurance_multiple Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)






/*增加一些covariates*/

reg insurance_multiple sum_diff ranking ranking_group female master ///
seniority Safe_switch_point m1 m2 m3 m4 m5 ,cluster(hash_number)
outreg2 using $data\reg_insurance,excel replace ctitle(保險手收績效區間)

forvalues i =1(1)5 {
	reg insurance_multiple sum_diff m`i' ,cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_multiple Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_multiple sum_diff Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_multiple sum_diff female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_multiple Safe_switch_point female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_multiple sum_diff Safe_switch_point female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)

	reg insurance_multiple ranking m`i' ,cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_multiple Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_multiple ranking Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_multiple ranking female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_multiple Safe_switch_point female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_multiple ranking Safe_switch_point female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)

	reg insurance_multiple ranking_group m`i' ,cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_multiple Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_multiple ranking_group Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_multiple ranking_group female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_multiple Safe_switch_point female master seniority m`i' ,cluster(hash_number) 
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
	reg insurance_multiple ranking_group Safe_switch_point female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
}








/*reg*/
/* gold*/
reg gold_multiple sum_diff ranking ranking_group female master ///
seniority Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_gold,excel replace ctitle(金品手收績效區間)


reg gold_multiple sum_diff ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_multiple Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_multiple sum_diff Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_multiple sum_diff female master seniority ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_multiple Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_multiple sum_diff Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)

reg gold_multiple ranking ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_multiple Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_multiple ranking Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_multiple ranking female master seniority ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_multiple Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_multiple ranking Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)

reg gold_multiple ranking_group ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_multiple Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_multiple ranking_group female master seniority ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_multiple Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold_multiple ranking_group Safe_switch_point female master seniority ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間) 
reg gold_multiple Safe_switch_point ,cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)






/*增加一些covariates*/

reg gold_multiple sum_diff ranking ranking_group female master ///
seniority Safe_switch_point m1 m2 m3 m4 m5 ,cluster(hash_number)
outreg2 using $data\reg_gold,excel replace ctitle(金品手收績效區間)

forvalues i =1(1)5 {
	reg gold_multiple sum_diff m`i' ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_multiple Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_multiple sum_diff Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_multiple sum_diff female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_multiple Safe_switch_point female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_multiple sum_diff Safe_switch_point female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)

	reg gold_multiple ranking m`i' ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_multiple Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_multiple ranking Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_multiple ranking female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_multiple Safe_switch_point female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_multiple ranking Safe_switch_point female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)

	reg gold_multiple ranking_group m`i' ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_multiple Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_multiple ranking_group Safe_switch_point m`i' ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_multiple ranking_group female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_multiple Safe_switch_point female master seniority m`i'  ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
	reg gold_multiple ranking_group Safe_switch_point female master seniority m`i' ,cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
}





drop m1 m2 m3 m4 m5

/*存檔*/
save $data/panel_multiple.dta, replace
