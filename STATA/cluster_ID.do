clear all

global data = "C:\Users\user\Desktop\學習\Josie\玉山報酬"

capture log close

log using $data\log6.txt, replace
 
set more off

**ssc install outreg2

/*任務：對有四季資料的panel data跑OLS, cluster(id)
或者進一步cluster(id),同時考慮fixed-effect
變數考慮sum_diff及風險偏好，控制三項個人特質*/

//Import data
use $data\regression_seasonal.dta, replace

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
drop if quarter == .







/*fixed-effect*/
egen hash_number = group(hash_No)
*xtset hash_number quarter

/*綜合績效績效區間*/
reg performance sum_diff ranking ranking_group female master ///
seniority Safe_switch_point , cluster(hash_number)
outreg2 using $data\reg_performance,excel replace ctitle(綜合績效績效區間)


reg performance sum_diff , cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance sum_diff Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance sum_diff female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance sum_diff Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
/*ranking*/
reg performance ranking , cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance ranking Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance ranking female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance ranking Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
/*ranking_group*/
reg performance ranking_group , cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance ranking_group Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance ranking_group female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance ranking_group Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)

/*
forvalues i = 1(1)4{
/*sum_diff*/
	reg performance sum_diff if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(performance`i')
	reg performance Safe_switch_point, cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(performance`i')
	reg performance sum_diff Safe_switch_point if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(performance`i')
	reg performance sum_diff female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_performance`i',excel append ctitle(performance`i')
	reg performance Safe_switch_point female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(performance`i')
	reg performance sum_diff Safe_switch_point female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(performance`i')
/*ranking*/
	reg performance ranking if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(performance`i')
	reg performance ranking Safe_switch_point if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(performance`i')
	reg performance ranking female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(performance`i')
	reg performance ranking Safe_switch_point female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(performance`i')
/*ranking_group*/
	reg performance ranking_group if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(performance`i')
	reg performance ranking_group Safe_switch_point if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(performance`i')
	reg performance ranking_group female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(performance`i')
	reg performance ranking_group Safe_switch_point female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_performance,excel append ctitle(performance`i')
}
*/












/*基金手收績效區間*/
reg fund sum_diff ranking ranking_group female master ///
seniority Safe_switch_point , cluster(hash_number)
outreg2 using $data\reg_fund,excel replace ctitle(基金手收績效區間)


reg fund sum_diff , cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund)
reg fund Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund)
reg fund sum_diff Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund)
reg fund sum_diff female master seniority, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund)
reg fund Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund)
reg fund sum_diff Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund)
/*ranking*/
reg fund ranking , cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund)
reg fund ranking Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund)
reg fund ranking female master seniority, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund)
reg fund ranking Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund)
/*ranking_group*/
reg fund ranking_group , cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund)
reg fund ranking_group Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund)
reg fund ranking_group female master seniority, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund)
reg fund ranking_group Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund)

/*
forvalues i = 1(1)4{
/*sum_diff*/
	reg fund sum_diff if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(fund`i')
	reg fund Safe_switch_point, cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(fund`i')
	reg fund sum_diff Safe_switch_point if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(fund`i')
	reg fund sum_diff female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_fund`i',excel append ctitle(fund`i')
	reg fund Safe_switch_point female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(fund`i')
	reg fund sum_diff Safe_switch_point female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(fund`i')
/*ranking*/
	reg fund ranking if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(fund`i')
	reg fund ranking Safe_switch_point if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(fund`i')
	reg fund ranking female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(fund`i')
	reg fund ranking Safe_switch_point female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(fund`i')
/*ranking_group*/
	reg fund ranking_group if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(fund`i')
	reg fund ranking_group Safe_switch_point if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(fund`i')
	reg fund ranking_group female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(fund`i')
	reg fund ranking_group Safe_switch_point female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_fund,excel append ctitle(fund`i')
}
*/








/*保險手收績效區間*/
reg insurance sum_diff ranking ranking_group female master ///
seniority Safe_switch_point , cluster(hash_number)
outreg2 using $data\reg_insurance,excel replace ctitle(保險手收績效區間)


reg insurance sum_diff , cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(insurance)
reg insurance Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(insurance)
reg insurance sum_diff Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(insurance)
reg insurance sum_diff female master seniority, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(insurance)
reg insurance Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(insurance)
reg insurance sum_diff Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(insurance)
/*ranking*/
reg insurance ranking , cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(insurance)
reg insurance ranking Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(insurance)
reg insurance ranking female master seniority, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(insurance)
reg insurance ranking Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(insurance)
/*ranking_group*/
reg insurance ranking_group , cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(insurance)
reg insurance ranking_group Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(insurance)
reg insurance ranking_group female master seniority, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(insurance)
reg insurance ranking_group Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(insurance)

/*
forvalues i = 1(1)4{
/*sum_diff*/
	reg insurance sum_diff if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(insurance`i')
	reg insurance Safe_switch_point, cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(insurance`i')
	reg insurance sum_diff Safe_switch_point if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(insurance`i')
	reg insurance sum_diff female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_insurance`i',excel append ctitle(insurance`i')
	reg insurance Safe_switch_point female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(insurance`i')
	reg insurance sum_diff Safe_switch_point female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(insurance`i')
/*ranking*/
	reg insurance ranking if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(insurance`i')
	reg insurance ranking Safe_switch_point if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(insurance`i')
	reg insurance ranking female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(insurance`i')
	reg insurance ranking Safe_switch_point female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(insurance`i')
/*ranking_group*/
	reg insurance ranking_group if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(insurance`i')
	reg insurance ranking_group Safe_switch_point if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(insurance`i')
	reg insurance ranking_group female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(insurance`i')
	reg insurance ranking_group Safe_switch_point female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_insurance,excel append ctitle(insurance`i')
}
*/









/*金品手收績效區間*/
reg gold sum_diff ranking ranking_group female master ///
seniority Safe_switch_point , cluster(hash_number)
outreg2 using $data\reg_gold,excel replace ctitle(金品手收績效區間)


reg gold sum_diff , cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(gold)
reg gold Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(gold)
reg gold sum_diff Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(gold)
reg gold sum_diff female master seniority, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(gold)
reg gold Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(gold)
reg gold sum_diff Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(gold)
/*ranking*/
reg gold ranking , cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(gold)
reg gold ranking Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(gold)
reg gold ranking female master seniority, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(gold)
reg gold ranking Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(gold)
/*ranking_group*/
reg gold ranking_group , cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(gold)
reg gold ranking_group Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(gold)
reg gold ranking_group female master seniority, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(gold)
reg gold ranking_group Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(gold)

/*
forvalues i = 1(1)4{
/*sum_diff*/
	reg gold sum_diff if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(gold`i')
	reg gold Safe_switch_point, cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(gold`i')
	reg gold sum_diff Safe_switch_point if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(gold`i')
	reg gold sum_diff female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_gold`i',excel append ctitle(gold`i')
	reg gold Safe_switch_point female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(gold`i')
	reg gold sum_diff Safe_switch_point female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(gold`i')
/*ranking*/
	reg gold ranking if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(gold`i')
	reg gold ranking Safe_switch_point if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(gold`i')
	reg gold ranking female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(gold`i')
	reg gold ranking Safe_switch_point female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(gold`i')
/*ranking_group*/
	reg gold ranking_group if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(gold`i')
	reg gold ranking_group Safe_switch_point if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(gold`i')
	reg gold ranking_group female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(gold`i')
	reg gold ranking_group Safe_switch_point female master seniority if quarter == `i', cluster(hash_number)
	outreg2 using $data\reg_gold,excel append ctitle(gold`i')
}
*/

save $data\cluster.dta, replace

log close
