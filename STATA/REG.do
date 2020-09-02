clear all

global data = "C:\Users\user\Desktop\學習\Josie\玉山報酬"

capture log close

log using $data\log4.txt, replace
 
set more off

//Import data
use $data\performance.dta, replace
ssc install outreg2


/*先處理我們想要的變數*/
/*先把guess和offer改成數字格式*/
forvalues i = 1(1)10{
	ren ug`i'_guess ug`i'_guesss
	ren ug`i'_offer ug`i'_offerr
	gen ug`i'_guess = real(ug`i'_guesss)
	gen ug`i'_offer = real(ug`i'_offerr)
}
forvalues i = 1(1)10{
	drop ug`i'_guesss ug`i'_offerr
}
	
/*求guess和real之差、取絕對值、 加總*/
forvalues i = 1(1)10{
	gen diff`i' = ug`i'_guess - ug`i'_real
	gen abs_diff`i' = abs(diff`i')
}
gen sum_diff = abs_diff1 + abs_diff2 + abs_diff3 +abs_diff4 + ///
abs_diff5 + abs_diff6 +abs_diff7 + abs_diff8 + abs_diff9 + abs_diff10

/*對Dictator game的結果進行排名*/
egen ranking = rank(sum_diff)
/*改成組別的方式，以10名為一組*/
gen ranking_group = 0
replace ranking_group = 1 if (ranking < 10 | ranking == 10)
replace ranking_group = 2 if ranking > 10 & (ranking < 20 | ranking == 20)
replace ranking_group = 3 if ranking > 20 & (ranking < 30 | ranking == 30)
replace ranking_group = 4 if ranking > 30 & (ranking < 40 | ranking == 40)
replace ranking_group = 5 if ranking > 40 & (ranking < 50 | ranking == 50)
replace ranking_group = 6 if ranking > 50 & (ranking < 60 | ranking == 60)
replace ranking_group = 7 if ranking > 60 & (ranking < 70 | ranking == 70)
replace ranking_group = 8 if ranking > 70 & (ranking < 80 | ranking == 80)
replace ranking_group = 9 if ranking > 80 & (ranking < 90 | ranking == 90)
replace ranking_group = 10 if ranking > 90 & (ranking < 100 | ranking == 100)

/*取offer平均*/
gen sum_offer = ug1_offer + ug2_offer + ug3_offer +ug4_offer + ///
ug5_offer + ug6_offer + ug7_offer + ug8_offer + ug9_offer + ug10_offer
gen aver_offer = sum_offer / 10

/*測驗總和*/
gen sum_fin = fintest1 + fintest2 + fintest3 + fintest4 + fintest5
gen sum_cog = cogtest6 + cogtest7 + cogtest8

/*看一下變數間的相關性*/
pwcorr Safe_switch_point time_switch_point sum_coinright ///
sum_diff aver_offer sum_fin sum_cog, sig
/*認知測驗分數和金融測驗分數顯著相關
認知測驗分數轉換點部分顯著相關(p~=0.5)*/





/*開始跑regression*/

/*先看綜合績效績效區間*/
/*分開跑每個變數*/
reg performance sum_diff 
outreg2 using $data\reg_performance,excel replace ctitle(綜合績效績效區間) 
reg performance ranking
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance ranking_group
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance aver_offer 
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance Safe_switch_point 
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance time_switch_point 
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance sum_coinright 
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance sum_fin 
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance sum_cog
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)


/*控制個人特質等變數，再分開跑每個變數*/
reg performance sum_diff female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance ranking female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance ranking_group female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間) 
reg performance aver_offer female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance Safe_switch_point female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance time_switch_point female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance sum_coinright female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance sum_fin female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)
reg performance sum_cog female master seniority
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間)


/*從7個Covariates中，選出2個*/
gen m1 = sum_diff 
gen m2 = ranking 
gen m3 = ranking_group 
gen m4 = aver_offer 
gen m5 = Safe_switch_point 
gen m6 = time_switch_point 
gen m7 = sum_coinright
gen m8 = sum_fin 
gen m9 = sum_cog

reg performance m1 m2 m3 m4 m5 m6 m7 m8 m9
outreg2 using $data\reg_performance__2,excel replace ctitle(綜合績效績效區間)

forvalues j = 4(1)9{
	reg performance m1 m`j'
	outreg2 using $data\reg_performance__2,excel append ctitle(綜合績效績效區間)
	}

forvalues j = 4(1)9{
	reg performance m2 m`j'
	outreg2 using $data\reg_performance__2,excel append ctitle(綜合績效績效區間)
	}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		if `i' < `j'{
		reg performance m`i' m`j'
		outreg2 using $data\reg_performance__2,excel append ctitle(綜合績效績效區間)
		}
	}
}

/*加入個人特質*/
forvalues j = 4(1)9{
	reg performance m1 m`j' female master seniority 
	outreg2 using $data\reg_performance__2,excel append ctitle(綜合績效績效區間)
	}

forvalues j = 4(1)9{
	reg performance m2 m`j' female master seniority 
	outreg2 using $data\reg_performance__2,excel append ctitle(綜合績效績效區間)
	}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		if `i' < `j'{
		reg performance m`i' m`j' female master seniority 
		outreg2 using $data\reg_performance__2,excel append ctitle(綜合績效績效區間)
		}
	}
}



/*從7個Covariates中，選出3個*/

outreg2 using $data\reg_performance__3,excel replace ctitle(綜合績效績效區間)

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		if `j' < `k' {
			reg performance m1 m`j' m`k'
			outreg2 using $data\reg_performance__3,excel append ctitle(綜合績效績效區間)
		}
	}
}

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		if `j' < `k' {
			reg performance m2 m`j' m`k'
			outreg2 using $data\reg_performance__3,excel append ctitle(綜合績效績效區間)
		}
	}
}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		forvalues k = 5(1)9{
			if `i' < `j' & `j' < `k'{
			reg performance m`i' m`j' m`k'
			outreg2 using $data\reg_performance__3,excel append ctitle(綜合績效績效區間)
		}
		}
	}
}

/*加入個人特質*/
outreg2 using $data\reg_performance__3,excel replace ctitle(綜合績效績效區間)

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		if `j' < `k' {
			reg performance m1 m`j' m`k' female master seniority 
			outreg2 using $data\reg_performance__3,excel append ctitle(綜合績效績效區間)
		}
	}
}

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		if `j' < `k' {
			reg performance m2 m`j' m`k' female master seniority 
			outreg2 using $data\reg_performance__3,excel append ctitle(綜合績效績效區間)
		}
	}
}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		forvalues k = 5(1)9{
			if `i' < `j' & `j' < `k'{
			reg performance m`i' m`j' m`k' female master seniority 
			outreg2 using $data\reg_performance__3,excel append ctitle(綜合績效績效區間)
		}
		}
	}
}


/*從選取兩項跟三項的結果來看，sum_diff跟safe_switch_point最顯著*/
/*再控制個人特質下，繼續挑選*/
/*sum_diff, safe_switch_point加另外兩項*/
outreg2 using $data\reg_performance__4,excel replace ctitle(綜合績效績效區間)
forvalues j = 4(1)9{
	if `j' != 5 {
		reg performance m1 m5 m`j' female master seniority 
		outreg2 using $data\reg_performance__4,excel append ctitle(綜合績效績效區間)
	}
}

/*sum_diff, safe_switch_point加另外三項*/
outreg2 using $data\reg_performance__5,excel replace ctitle(綜合績效績效區間)
forvalues j = 4(1)9{
	forvalues k = 6(1)9{
	if `j' != 5 & `j' < `k'{
		reg performance m1 m5 m`j' m`k' female master seniority 
		outreg2 using $data\reg_performance__5,excel append ctitle(綜合績效績效區間)
	}
	}
}


reg performance sum_diff aver_offer Safe_switch_point time_switch_point ///
sum_coinright sum_fin sum_cog
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間) 

reg performance sum_diff aver_offer Safe_switch_point time_switch_point ///
sum_coinright sum_fin sum_cog female master seniority 
outreg2 using $data\reg_performance,excel append ctitle(綜合績效績效區間) 







/*基金手收績效區間*/
reg fund sum_diff 
outreg2 using $data\reg_fund,excel replace ctitle(基金手收績效區間) 
reg fund ranking
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund ranking_group
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund aver_offer 
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund Safe_switch_point 
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund time_switch_point 
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund sum_coinright 
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund sum_fin 
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund sum_cog
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)


/*控制個人特質等變數，再分開跑每個變數*/
reg fund sum_diff female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund ranking female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund ranking_group female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間) 
reg fund aver_offer female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund Safe_switch_point female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund time_switch_point female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund sum_coinright female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund sum_fin female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)
reg fund sum_cog female master seniority
outreg2 using $data\reg_fund,excel append ctitle(基金手收績效區間)




/*從7個Covariates中，選出2個*/

outreg2 using $data\reg_fund__2,excel replace ctitle(基金手收績效區間)

forvalues j = 4(1)9{
	reg fund m1 m`j'
	outreg2 using $data\reg_fund__2,excel append ctitle(基金手收績效區間)
	}

forvalues j = 4(1)9{
	reg fund m2 m`j'
	outreg2 using $data\reg_fund__2,excel append ctitle(基金手收績效區間)
	}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		if `i' < `j'{
		reg fund m`i' m`j'
		outreg2 using $data\reg_fund__2,excel append ctitle(基金手收績效區間)
		}
	}
}

/*加入個人特質*/
forvalues j = 4(1)9{
	reg fund m1 m`j' female master seniority 
	outreg2 using $data\reg_fund__2,excel append ctitle(基金手收績效區間)
	}

forvalues j = 4(1)9{
	reg fund m2 m`j' female master seniority 
	outreg2 using $data\reg_fund__2,excel append ctitle(基金手收績效區間)
	}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		if `i' < `j'{
		reg fund m`i' m`j' female master seniority 
		outreg2 using $data\reg_fund__2,excel append ctitle(基金手收績效區間)
		}
	}
}




/*從7個Covariates中，選出3個*/

outreg2 using $data\reg_fund__3,excel replace ctitle(基金手收績效區間)

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		if `j' < `k' {
			reg fund m1 m`j' m`k'
			outreg2 using $data\reg_fund__3,excel append ctitle(基金手收績效區間)
		}
	}
}

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		if `j' < `k' {
			reg fund m2 m`j' m`k'
			outreg2 using $data\reg_fund__3,excel append ctitle(基金手收績效區間)
		}
	}
}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		forvalues k = 5(1)9{
			if `i' < `j' & `j' < `k'{
			reg fund m`i' m`j' m`k'
			outreg2 using $data\reg_fund__3,excel append ctitle(基金手收績效區間)
		}
		}
	}
}

/*加入個人特質*/
outreg2 using $data\reg_fund__3,excel replace ctitle(基金手收績效區間)

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		if `j' < `k' {
			reg fund m1 m`j' m`k' female master seniority 
			outreg2 using $data\reg_fund__3,excel append ctitle(基金手收績效區間)
		}
	}
}

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		if `j' < `k' {
			reg fund m2 m`j' m`k' female master seniority 
			outreg2 using $data\reg_fund__3,excel append ctitle(基金手收績效區間)
		}
	}
}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		forvalues k = 5(1)9{
			if `i' < `j' & `j' < `k'{
			reg fund m`i' m`j' m`k' female master seniority 
			outreg2 using $data\reg_fund__3,excel append ctitle(基金手收績效區間)
		}
		}
	}
}



/*從選取兩項跟三項的結果來看，sum_diff跟safe_switch_point最顯著*/
/*再控制個人特質下，繼續挑選*/
/*sum_diff, safe_switch_point加另外兩項*/
outreg2 using $data\reg_fund__4,excel replace ctitle(基金手收績效區間)
forvalues j = 4(1)9{
	if `j' != 5 {
		reg fund m1 m5 m`j' female master seniority 
		outreg2 using $data\reg_fund__4,excel append ctitle(基金手收績效區間)
	}
}

/*sum_diff, safe_switch_point加另外三項*/
outreg2 using $data\reg_fund__5,excel replace ctitle(基金手收績效區間)
forvalues j = 4(1)9{
	forvalues k = 6(1)9{
	if `j' != 5 & `j' < `k'{
		reg fund m1 m5 m`j' m`k' female master seniority 
		outreg2 using $data\reg_fund__5,excel append ctitle(基金手收績效區間)
	}
	}
}




/*先看保險手收績效區間*/
reg insurance sum_diff 
outreg2 using $data\reg_insurance,excel replace ctitle(保險手收績效區間) 
reg insurance ranking
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance ranking_group
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance aver_offer 
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance Safe_switch_point 
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance time_switch_point 
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance sum_coinright 
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance sum_fin 
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance sum_cog
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)


/*控制個人特質等變數，再分開跑每個變數*/
reg insurance sum_diff female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance ranking female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance ranking_group female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間) 
reg insurance aver_offer female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance Safe_switch_point female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance time_switch_point female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance sum_coinright female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance sum_fin female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)
reg insurance sum_cog female master seniority
outreg2 using $data\reg_insurance,excel append ctitle(保險手收績效區間)



/*從7個Covariates中，選出2個*/

outreg2 using $data\reg_insurance__2,excel replace ctitle(保險手收績效區間)

forvalues j = 4(1)9{
	reg insurance m1 m`j'
	outreg2 using $data\reg_insurance__2,excel append ctitle(保險手收績效區間)
	}

forvalues j = 4(1)9{
	reg insurance m2 m`j'
	outreg2 using $data\reg_insurance__2,excel append ctitle(保險手收績效區間)
	}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		if `i' < `j'{
		reg insurance m`i' m`j'
		outreg2 using $data\reg_insurance__2,excel append ctitle(保險手收績效區間)
		}
	}
}

/*加入個人特質*/
forvalues j = 4(1)9{
	reg insurance m1 m`j' female master seniority 
	outreg2 using $data\reg_insurance__2,excel append ctitle(保險手收績效區間)
	}

forvalues j = 4(1)9{
	reg insurance m2 m`j' female master seniority 
	outreg2 using $data\reg_insurance__2,excel append ctitle(保險手收績效區間)
	}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		if `i' < `j'{
		reg insurance m`i' m`j' female master seniority 
		outreg2 using $data\reg_insurance__2,excel append ctitle(保險手收績效區間)
		}
	}
}



/*從7個Covariates中，選出3個*/

outreg2 using $data\reg_insurance__3,excel replace ctitle(基金手收績效區間)

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		if `j' < `k' {
			reg insurance m1 m`j' m`k'
			outreg2 using $data\reg_insurance__3,excel append ctitle(基金手收績效區間)
		}
	}
}

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		if `j' < `k' {
			reg insurance m2 m`j' m`k'
			outreg2 using $data\reg_insurance__3,excel append ctitle(基金手收績效區間)
		}
	}
}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		forvalues k = 5(1)9{
			if `i' < `j' & `j' < `k'{
			reg insurance m`i' m`j' m`k'
			outreg2 using $data\reg_insurance__3,excel append ctitle(基金手收績效區間)
		}
		}
	}
}

/*加入個人特質*/
outreg2 using $data\reg_insurance__3,excel replace ctitle(基金手收績效區間)

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		if `j' < `k' {
			reg insurance m1 m`j' m`k' female master seniority 
			outreg2 using $data\reg_insurance__3,excel append ctitle(基金手收績效區間)
		}
	}
}

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		if `j' < `k' {
			reg insurance m2 m`j' m`k' female master seniority 
			outreg2 using $data\reg_insurance__3,excel append ctitle(基金手收績效區間)
		}
	}
}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		forvalues k = 5(1)9{
			if `i' < `j' & `j' < `k'{
			reg insurance m`i' m`j' m`k' female master seniority 
			outreg2 using $data\reg_insurance__3,excel append ctitle(基金手收績效區間)
		}
		}
	}
}



/*從7個Covariates中，選出4個*/

outreg2 using $data\reg_insurance__4,excel replace ctitle(基金手收績效區間)

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		forvalues l = 6(1)9{
		if `j' < `k' & `k' < `l'{
			reg insurance m1 m`j' m`k' m`l'
			outreg2 using $data\reg_insurance__4,excel append ctitle(基金手收績效區間)
		}
		}
	}
}

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		forvalues l = 6(1)9{
		if `j' < `k' & `k' < `l'{
			reg insurance m2 m`j' m`k' m`l'
			outreg2 using $data\reg_insurance__4,excel append ctitle(基金手收績效區間)
		}
		}
	}
}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		forvalues k = 5(1)9{
			forvalues l = 6(1)9{
				if `i' < `j' & `j' < `k' & `k' < `l'{
				reg insurance m`i' m`j' m`k' m`l'
				outreg2 using $data\reg_insurance__4,excel append ctitle(基金手收績效區間)
				}
			}
		}
	}
}

/*加入個人特質*/
outreg2 using $data\reg_insurance__4,excel replace ctitle(基金手收績效區間)

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		forvalues l = 6(1)9{
		if `j' < `k' & `k' < `l'{
			reg insurance m1 m`j' m`k' m`l' female master seniority 
			outreg2 using $data\reg_insurance__4,excel append ctitle(基金手收績效區間)
		}
		}
	}
}

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		forvalues l = 6(1)9{
		if `j' < `k' & `k' < `l'{
			reg insurance m2 m`j' m`k' m`l' female master seniority 
			outreg2 using $data\reg_insurance__4,excel append ctitle(基金手收績效區間)
		}
		}
	}
}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		forvalues k = 5(1)9{
			forvalues l = 6(1)9{
				if `i' < `j' & `j' < `k' & `k' < `l'{
				reg insurance m`i' m`j' m`k' m`l' female master seniority 
				outreg2 using $data\reg_insurance__4,excel append ctitle(基金手收績效區間)
				}
			}
		}
	}
}










/*先看金品手收績效區間*/
reg gold sum_diff 
outreg2 using $data\reg_gold,excel replace ctitle(金品手收績效區間) 
reg gold ranking
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold ranking_group
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold aver_offer 
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold Safe_switch_point 
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold time_switch_point 
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold sum_coinright 
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold sum_fin 
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold sum_cog
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)


/*控制個人特質等變數，再分開跑每個變數*/
reg gold sum_diff female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold ranking female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold ranking_group female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間) 
reg gold aver_offer female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold Safe_switch_point female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold time_switch_point female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold sum_coinright female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold sum_fin female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)
reg gold sum_cog female master seniority
outreg2 using $data\reg_gold,excel append ctitle(金品手收績效區間)




/*從7個Covariates中，選出2個*/

outreg2 using $data\reg_gold__2,excel replace ctitle(金品手收績效區間)

forvalues j = 4(1)9{
	reg gold m1 m`j'
	outreg2 using $data\reg_gold__2,excel append ctitle(金品手收績效區間)
	}

forvalues j = 4(1)9{
	reg gold m2 m`j'
	outreg2 using $data\reg_gold__2,excel append ctitle(金品手收績效區間)
	}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		if `i' < `j'{
		reg gold m`i' m`j'
		outreg2 using $data\reg_gold__2,excel append ctitle(金品手收績效區間)
		}
	}
}

/*加入個人特質*/
forvalues j = 4(1)9{
	reg gold m1 m`j' female master seniority 
	outreg2 using $data\reg_gold__2,excel append ctitle(金品手收績效區間)
	}

forvalues j = 4(1)9{
	reg gold m2 m`j' female master seniority 
	outreg2 using $data\reg_gold__2,excel append ctitle(金品手收績效區間)
	}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		if `i' < `j'{
		reg gold m`i' m`j' female master seniority 
		outreg2 using $data\reg_gold__2,excel append ctitle(金品手收績效區間)
		}
	}
}



/*從7個Covariates中，選出3個*/

outreg2 using $data\reg_gold__3,excel replace ctitle(金品手收績效區間)

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		if `j' < `k' {
			reg gold m1 m`j' m`k'
			outreg2 using $data\reg_gold__3,excel append ctitle(金品手收績效區間)
		}
	}
}

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		if `j' < `k' {
			reg gold m2 m`j' m`k'
			outreg2 using $data\reg_gold__3,excel append ctitle(金品手收績效區間)
		}
	}
}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		forvalues k = 5(1)9{
			if `i' < `j' & `j' < `k'{
			reg gold m`i' m`j' m`k'
			outreg2 using $data\reg_gold__3,excel append ctitle(金品手收績效區間)
		}
		}
	}
}

/*加入個人特質*/
outreg2 using $data\reg_gold__3,excel replace ctitle(金品手收績效區間)

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		if `j' < `k' {
			reg gold m1 m`j' m`k' female master seniority 
			outreg2 using $data\reg_gold__3,excel append ctitle(金品手收績效區間)
		}
	}
}

forvalues j = 4(1)9{
	forvalues k = 5(1)9{
		if `j' < `k' {
			reg gold m2 m`j' m`k' female master seniority 
			outreg2 using $data\reg_gold__3,excel append ctitle(金品手收績效區間)
		}
	}
}

forvalues i = 3(1)9{
	forvalues j = 4(1)9{
		forvalues k = 5(1)9{
			if `i' < `j' & `j' < `k'{
			reg gold m`i' m`j' m`k' female master seniority 
			outreg2 using $data\reg_gold__3,excel append ctitle(金品手收績效區間)
		}
		}
	}
}






/*存檔*/
save $data\reg.dta, replace

log close
