clear all

global data = "/Users/shawn/Documents/Esun"

capture log close

log using $data/log_sumkind.txt, replace
 
set more off

//Import data
use $data/regression_seasonal.dta, replace






/*gen sum_kind*/
forv i = 1(1)10{
	gen ug`i'_kind = ug`i'_offer - ug`i'_guess
}

gen sum_kind = ug1_kind + ug2_kind + ug3_kind + ug4_kind + ug5_kind ///
+ ug6_kind + ug7_kind + ug8_kind + ug9_kind + ug10_kind






/*regress sum_kind on sim_diff*/
reg sum_kind sum_diff
outreg2 using $data\reg_sum_kind,excel replace ctitle(sum_kind)






/*gen avg_offer變數*/
gen avg_offer = (ug1_offer + ug2_offer + ug3_offer + ug4_offer + ug5_offer ///
+ ug6_offer + ug7_offer + ug8_offer + ug9_offer + ug10_offer) / 10






/*regress avg_offer on sim_diff*/
reg avg_offer sum_diff
outreg2 using $data\reg_avg_offer,excel replace ctitle(avg_offer)








/*reg*/
/* Avg_offer (x變數) 對 綜合業績 (y變數)*/
reg performance avg_offer ranking ranking_group female master ///
seniority Safe_switch_point
outreg2 using $data\reg_performance,excel replace ctitle(綜合績效績效區間)


reg performance avg_offer
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance Safe_switch_point
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance avg_offer Safe_switch_point
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance avg_offer female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance Safe_switch_point female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance avg_offer Safe_switch_point female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)







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







/*Avg_offer (x變數) 對 四季綜合績效*/
reg performance avg_offer ranking ranking_group female master ///
seniority Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_performance,excel replace ctitle(綜合績效績效區間)


reg performance avg_offer, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance avg_offer Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance avg_offer female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance avg_offer Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)







/*Avg_offer (x變數) 對 sum_diff (y變數）的回歸*/
reg avg_offer sum_diff
outreg2 using $data\reg_avg_offer,excel replace ctitle(avg_offer)






/*存檔*/
save $data\avg_offer.dta, replace
