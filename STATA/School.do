clear all

global data = "/Users/shawn/Documents/Esun"

capture log close

log using $data/log_exam_score.txt, replace
 
set more off



//Import data
import excel $data/output_學歷資料.xlsx, firstrow clear

ren 請問您的教育程度 degree
ren 學校 school
ren 系級 major
ren H original_exam_score
ren I original_lowest_score
ren J original_multiple_score
drop L

save $data/output_school.dta, replace


//Import data
use $data/panel_multiple.dta, replace

merge m:m hash_No using $data/output_school.dta
drop if _merge ==2
drop _merge




/*fixed-effect*/
egen hash_number = group(hash_No)


/*regress*/
reg sum_cog National_University, cluster (hash_number)
outreg2 using $data\reg_performance,excel replace ctitle(performance_multiple)
reg sum_cog National_or_Famous_Private_Unive ,cluster (hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg sum_cog Exam_score ,cluster (hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg sum_diff National_University ,cluster (hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg sum_diff National_or_Famous_Private_Unive ,cluster (hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg sum_diff Exam_score ,cluster (hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)

reg sum_diff sum_cog, cluster (hash_number)
outreg2 using $data\reg_sum?_diff,excel replace ctitle(sum_diff)


/*綜合績效績效區間*/
/*全年資料*/
/*國立學校*/
reg performance_multiple National_University sum_diff if quarter == 0
outreg2 using $data\reg_performance,excel replace ctitle(performance_multiple)
reg performance_multiple National_University Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple National_University sum_diff Safe_switch_poin if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple National_University sum_diff female master seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple National_University Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple National_University sum_diff Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)



/*國立學校或私立名校*/
reg performance_multiple National_or_Famous_Private_Unive sum_diff if quarter == 0
outreg2 using $data\reg_performance,excel replace ctitle(performance_multiple)
reg performance_multiple National_or_Famous_Private_Unive Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple National_or_Famous_Private_Unive sum_diff Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple National_or_Famous_Private_Unive sum_diff female master seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple National_or_Famous_Private_Unive Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple National_or_Famous_Private_Unive sum_diff Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple) 



/*最低錄取分數*/
reg performance_multiple Exam_score sum_diff if quarter == 0
outreg2 using $data\reg_performance,excel replace ctitle(performance_multiple)
reg performance_multiple Exam_score Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple Exam_score sum_diff Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple Exam_score sum_diff female master seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple Exam_score Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple Exam_score sum_diff Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)







/*四季資料*/
/*國立學校*/
reg performance_multiple National_University sum_diff , cluster(hash_number)
outreg2 using $data\reg_performance,excel replace ctitle(performance)
reg performance_multiple National_University Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance_multiple National_University sum_diff Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance_multiple National_University sum_diff female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance_multiple National_University Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance_multiple National_University sum_diff Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)



/*國立學校或私立名校*/
reg performance_multiple National_or_Famous_Private_Unive sum_diff , cluster(hash_number)
outreg2 using $data\reg_performance,excel replace ctitle(performance)
reg performance_multiple National_or_Famous_Private_Unive Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance_multiple National_or_Famous_Private_Unive sum_diff Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance_multiple National_or_Famous_Private_Unive sum_diff female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance_multiple National_or_Famous_Private_Unive Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance_multiple National_or_Famous_Private_Unive sum_diff Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)



/*最低錄取分數*/
reg performance_multiple Exam_score sum_diff , cluster(hash_number)
outreg2 using $data\reg_performance,excel replace ctitle(performance)
reg performance_multiple Exam_score Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance_multiple Exam_score sum_diff Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance_multiple Exam_score sum_diff female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance_multiple Exam_score Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)
reg performance_multiple Exam_score sum_diff Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance)






/*基金手收績效區間*/
/*全年資料*/
/*國立學校*/
reg fund_multiple National_University sum_diff if quarter == 0
outreg2 using $data\reg_fund,excel replace ctitle(fund_multiple)
reg fund_multiple National_University Safe_switch_point if quarter == 0
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple National_University sum_diff Safe_switch_poin if quarter == 0
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple National_University sum_diff female master seniority if quarter == 0
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple National_University Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple National_University sum_diff Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)



/*國立學校或私立名校*/
reg fund_multiple National_or_Famous_Private_Unive sum_diff if quarter == 0
outreg2 using $data\reg_fund,excel replace ctitle(fund_multiple)
reg fund_multiple National_or_Famous_Private_Unive Safe_switch_point if quarter == 0
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple National_or_Famous_Private_Unive sum_diff Safe_switch_point if quarter == 0
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple National_or_Famous_Private_Unive sum_diff female master seniority if quarter == 0
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple National_or_Famous_Private_Unive Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple National_or_Famous_Private_Unive sum_diff Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple) 



/*最低錄取分數*/
reg fund_multiple Exam_score sum_diff if quarter == 0
outreg2 using $data\reg_fund,excel replace ctitle(fund_multiple)
reg fund_multiple Exam_score Safe_switch_point if quarter == 0
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple Exam_score sum_diff Safe_switch_point if quarter == 0
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple Exam_score sum_diff female master seniority if quarter == 0
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple Exam_score Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple Exam_score sum_diff Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)






/*四季資料*/
/*國立學校*/
reg fund_multiple National_University sum_diff , cluster(hash_number)
outreg2 using $data\reg_fund,excel replace ctitle(fund_multiple)
reg fund_multiple National_University Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple National_University sum_diff Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple National_University sum_diff female master seniority, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple National_University Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple National_University sum_diff Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)



/*國立學校或私立名校*/
reg fund_multiple National_or_Famous_Private_Unive sum_diff , cluster(hash_number)
outreg2 using $data\reg_fund,excel replace ctitle(fund_multiple)
reg fund_multiple National_or_Famous_Private_Unive Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple National_or_Famous_Private_Unive sum_diff Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple National_or_Famous_Private_Unive sum_diff female master seniority, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple National_or_Famous_Private_Unive Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple National_or_Famous_Private_Unive sum_diff Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)



/*最低錄取分數*/
reg fund_multiple Exam_score sum_diff , cluster(hash_number)
outreg2 using $data\reg_fund,excel replace ctitle(fund_multiple)
reg fund_multiple Exam_score Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple Exam_score sum_diff Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple Exam_score sum_diff female master seniority, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple Exam_score Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)
reg fund_multiple Exam_score sum_diff Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_fund,excel append ctitle(fund_multiple)







/*保險手收績效區間*/
/*全年資料*/
/*國立學校*/
reg insurance_multiple National_University sum_diff if quarter == 0
outreg2 using $data\reg_insurance,excel replace ctitle(insurance_multiple)
reg insurance_multiple National_University Safe_switch_point if quarter == 0
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple National_University sum_diff Safe_switch_poin if quarter == 0
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple National_University sum_diff female master seniority if quarter == 0
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple National_University Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple National_University sum_diff Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)



/*國立學校或私立名校*/
reg insurance_multiple National_or_Famous_Private_Unive sum_diff if quarter == 0
outreg2 using $data\reg_insurance,excel replace ctitle(insurance_multiple)
reg insurance_multiple National_or_Famous_Private_Unive Safe_switch_point if quarter == 0
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple National_or_Famous_Private_Unive sum_diff Safe_switch_point if quarter == 0
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple National_or_Famous_Private_Unive sum_diff female master seniority if quarter == 0
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple National_or_Famous_Private_Unive Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple National_or_Famous_Private_Unive sum_diff Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple) 



/*最低錄取分數*/
reg insurance_multiple Exam_score sum_diff if quarter == 0
outreg2 using $data\reg_insurance,excel replace ctitle(insurance_multiple)
reg insurance_multiple Exam_score Safe_switch_point if quarter == 0
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple Exam_score sum_diff Safe_switch_point if quarter == 0
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple Exam_score sum_diff female master seniority if quarter == 0
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple Exam_score Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple Exam_score sum_diff Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)






/*四季資料*/
/*國立學校*/
reg insurance_multiple National_University sum_diff , cluster(hash_number)
outreg2 using $data\reg_insurance,excel replace ctitle(insurance_multiple)
reg insurance_multiple National_University Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple National_University sum_diff Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple National_University sum_diff female master seniority, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple National_University Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple National_University sum_diff Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)



/*國立學校或私立名校*/
reg insurance_multiple National_or_Famous_Private_Unive sum_diff , cluster(hash_number)
outreg2 using $data\reg_insurance,excel replace ctitle(insurance_multiple)
reg insurance_multiple National_or_Famous_Private_Unive Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple National_or_Famous_Private_Unive sum_diff Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple National_or_Famous_Private_Unive sum_diff female master seniority, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple National_or_Famous_Private_Unive Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple National_or_Famous_Private_Unive sum_diff Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)



/*最低錄取分數*/
reg insurance_multiple Exam_score sum_diff , cluster(hash_number)
outreg2 using $data\reg_insurance,excel replace ctitle(insurance_multiple)
reg insurance_multiple Exam_score Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple Exam_score sum_diff Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple Exam_score sum_diff female master seniority, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple Exam_score Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)
reg insurance_multiple Exam_score sum_diff Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_insurance,excel append ctitle(fund_multiple)







/*金品手收績效區間*/
/*全年資料*/
/*國立學校*/
reg gold_multiple National_University sum_diff if quarter == 0
outreg2 using $data\reg_gold,excel replace ctitle(gold_multiple)
reg gold_multiple National_University Safe_switch_point if quarter == 0
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple National_University sum_diff Safe_switch_poin if quarter == 0
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple National_University sum_diff female master seniority if quarter == 0
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple National_University Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple National_University sum_diff Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)



/*國立學校或私立名校*/
reg gold_multiple National_or_Famous_Private_Unive sum_diff if quarter == 0
outreg2 using $data\reg_gold,excel replace ctitle(gold_multiple)
reg gold_multiple National_or_Famous_Private_Unive Safe_switch_point if quarter == 0
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple National_or_Famous_Private_Unive sum_diff Safe_switch_point if quarter == 0
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple National_or_Famous_Private_Unive sum_diff female master seniority if quarter == 0
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple National_or_Famous_Private_Unive Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple National_or_Famous_Private_Unive sum_diff Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple) 



/*最低錄取分數*/
reg gold_multiple Exam_score sum_diff if quarter == 0
outreg2 using $data\reg_gold,excel replace ctitle(gold_multiple)
reg gold_multiple Exam_score Safe_switch_point if quarter == 0
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple Exam_score sum_diff Safe_switch_point if quarter == 0
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple Exam_score sum_diff female master seniority if quarter == 0
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple Exam_score Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple Exam_score sum_diff Safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)






/*四季資料*/
/*國立學校*/
reg gold_multiple National_University sum_diff , cluster(hash_number)
outreg2 using $data\reg_gold,excel replace ctitle(gold_multiple)
reg gold_multiple National_University Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple National_University sum_diff Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple National_University sum_diff female master seniority, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple National_University Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple National_University sum_diff Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)



/*國立學校或私立名校*/
reg gold_multiple National_or_Famous_Private_Unive sum_diff , cluster(hash_number)
outreg2 using $data\reg_gold,excel replace ctitle(gold_multiple)
reg gold_multiple National_or_Famous_Private_Unive Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple National_or_Famous_Private_Unive sum_diff Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple National_or_Famous_Private_Unive sum_diff female master seniority, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple National_or_Famous_Private_Unive Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple National_or_Famous_Private_Unive sum_diff Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)



/*最低錄取分數*/
reg gold_multiple Exam_score sum_diff , cluster(hash_number)
outreg2 using $data\reg_gold,excel replace ctitle(gold_multiple)
reg gold_multiple Exam_score Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple Exam_score sum_diff Safe_switch_point, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple Exam_score sum_diff female master seniority, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple Exam_score Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)
reg gold_multiple Exam_score sum_diff Safe_switch_point female master seniority, cluster(hash_number)
outreg2 using $data\reg_gold,excel append ctitle(fund_multiple)






save $data/Exam_score.dta, replace



clear all

global data = "/Users/shawn/Documents/Esun"

import delimited "/Users/shawn/Documents/Esun/All.csv", encoding(UTF-8)
ren hash_no hash_No

save $data/all.dta, replace

use $data/cluster.dta, clear

merge m:1 hash_No using $data/all.dta, force

reg performance_multiple happiness_from_others sum_diff if quarter == 0
outreg2 using $data\reg_performance,excel replace ctitle(performance_multiple)
reg performance_multiple happiness_from_others safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple happiness_from_others sum_diff safe_switch_poin if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple happiness_from_others sum_diff female master seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple happiness_from_others safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple happiness_from_others sum_diff safe_switch_point female master seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)






