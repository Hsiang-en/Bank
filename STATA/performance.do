clear all

global data = "C:\Users\user\Desktop\學習\Josie\玉山報酬"

capture log close

log using $data\log3.txt, replace
 
set more off

/*先讀檔：理專績效年資data*/
import excel $data\理專績效年資data.xlsx

/*更改變數名稱*/
ren A hash_No
gen performance = real(B)
la var performance "綜合績效績效區間"
gen fund = real(C)
la var fund "基金手收績效區間"
gen insurance = real(D)
la var insurance "保險手收績效區間"
gen gold = real(E)
la var gold "金品手收績效區間"
gen seniority = real(F)
la var seniority "理財年資"

/*存成data檔*/
save $data\理專績效年資data.dta, replace

//Import data
use $data\data_esun.dta, replace

/*合併檔案*/
merge 1:1 hash_No using $data\理專績效年資data.dta
drop if _merge == 2
drop _merge

/*匯出檔案*/
save $data\performance.dta, replace

export excel hash_No performance fund insurance gold ///
seniority pos_seq ug1_guess ug2_guess ug3_guess ///
ug4_guess ug5_guess ug6_guess ug7_guess ug8_guess ug9_guess ///
ug10_guess ug1_offer ug2_offer ug3_offer ug4_offer ug5_offer ///
ug6_offer ug7_offer ug8_offer ug9_offer ug10_offer ug1_real ///
ug2_real ug3_real ug4_real ug5_real ug6_real ug7_real ug8_real ///
ug9_real ug10_real risk_safe30 risk_safe40 risk_safe50 risk_safe60 ///
risk_safe70 risk_safe80 risk_safe90 risk_safe100 risk_safe110 ///
risk_safe120 risk_consistency Safe_switch_point Safe_options_chosen ///
time_future110 time_future120 time_future130 time_future140 ///
time_future150 time_future160 time_future170 time_future180 ///
time_future190 time_future200 time_consistency check time_switch_point ///
time_options_chosen coinright1 coinright2 coinright3 coinright4 ///
coinright5 coinright6 coinright7 coinright8 coinright9 coinright10 ///
sum_coinright fintest1 fintest2 fintest3 fintest4 fintest5 cogtest6 ///
cogtest7 cogtest8 Q1 Q2 Q3 Q4 Q5 Q6 Q7 Q8 Q9 Q10 Q11 Q12 date ///
female birthyear master moneyenough second ///
using $data\Performance_data.xlsx, sheetreplace firstrow(variables)

log close
