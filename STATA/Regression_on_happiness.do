clear all

global data = "/Users/shawn/Documents/Esun"

use $data/panel_multiple.dta, clear

gen happiness_from_others = 0

replace happiness_from_others = 1 if hash_No == "100dd4e27977a83ea3c66ec8edc07bf5c805b74ec8af37e7a54f0d364fc9f5a8" | hash_No == "1db515c600c6563a93bf4fcbef511bcb81e7b3f6eeb93c8c97f447621e136776"| ///
hash_No == "327f057e054d1e6a9a1be4ac6acc4b1dedc63d8a88222396ffe98b3194067347" | hash_No == "34195a099f8a6514fe3498a0d2496a33cd9640aaca29cd99fa71757fcbc4249c"| ///
hash_No == "36d96614da0537010f1dd2b4abb2e86b7374681dfbde12ec848c9f9a931e9575" | hash_No == "429eda1cda50611797f20c943f53b8534f4ec8310b098c8840154bf9d436a69b"| ///
hash_No == "4a93457cf4c32f74058fa420ddc2c458a0827e651ce1b73d2ca9157206302af4" | hash_No == "54d9f048788c3b4d800fe88c529bbce0ddca9b46a7a11fe90c3f20cf9bbc4a4a"| ///
hash_No == "55b7c884afc45126541f5f3d612f0c9d27b2a8304086fa5f436e30b0fb37d0cb" | hash_No == "568b13a982d679c4cc9c8240cb3d8fb1338b9eb31932bdc4d825cbf4b1b0b342"| ///
hash_No == "58b56ca565b863349e33f05ed62532784bc8f11935ad7386e97b57033322c31a" | hash_No == "857b4cd3f6a11d1b8f98cfcae825977c77b830c5bce4f82a68a0ed78e716451c"| ///
hash_No == "8f61140318317506ad079b43762ef8f8e8d50713b513b4d4b2ca49d389779c03" | hash_No == "a804d67d7b0634ee273a06c4ee71bdfa07d2dd6933f9d5a18766f7d35c268720"| ///
hash_No == "bfe109c35b60434174233bb6f30382c21b3bb88427427f93d11a1ba2d4b28f3b" | hash_No == "eff65e33a1c20298e50c3307293fefbb09b11ac8d69f6cffd6bd32237547ba1b"| ///
hash_No == "f4865c88d6564da9352ce45ee8e2b8cdc2f7e83212e863dd6713ce599875b5bb" 



/*Happiness*/
reg performance_multiple happiness_from_others sum_diff if quarter == 0
outreg2 using $data\reg_performance,excel replace ctitle(performance_multiple)
reg performance_multiple happiness_from_others Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple happiness_from_others sum_diff Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple happiness_from_others sum_diff female seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple happiness_from_others Safe_switch_point female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple happiness_from_others sum_diff Safe_switch_point female seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)



reg performance_multiple happiness_from_others sum_diff if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel replace ctitle(performance_multiple)
reg performance_multiple happiness_from_others Safe_switch_point if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple happiness_from_others sum_diff Safe_switch_point if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple happiness_from_others sum_diff female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple happiness_from_others Safe_switch_point female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg performance_multiple happiness_from_others sum_diff Safe_switch_point female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)

**
reg fund_multiple happiness_from_others sum_diff if quarter == 0
outreg2 using $data\reg_performance,excel replace ctitle(performance_multiple)
reg fund_multiple happiness_from_others Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple happiness_from_others sum_diff Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple happiness_from_others sum_diff female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple happiness_from_others Safe_switch_point female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple happiness_from_others sum_diff Safe_switch_point female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)



reg fund_multiple happiness_from_others sum_diff if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel replace ctitle(performance_multiple)
reg fund_multiple happiness_from_others Safe_switch_point if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple happiness_from_others sum_diff Safe_switch_point if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple happiness_from_others sum_diff female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple happiness_from_others Safe_switch_point female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple happiness_from_others sum_diff Safe_switch_point female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)

**
reg insurance_multiple happiness_from_others sum_diff if quarter == 0
outreg2 using $data\reg_performance,excel replace ctitle(performance_multiple)
reg insurance_multiple happiness_from_others Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg insurance_multiple happiness_from_others sum_diff Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg insurance_multiple happiness_from_others sum_diff female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg insurance_multiple happiness_from_others Safe_switch_point female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg insurance_multiple happiness_from_others sum_diff Safe_switch_point female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)



reg insurance_multiple happiness_from_others sum_diff if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel replace ctitle(performance_multiple)
reg insurance_multiple happiness_from_others Safe_switch_point if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg insurance_multiple happiness_from_others sum_diff Safe_switch_point if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg insurance_multiple happiness_from_others sum_diff female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg insurance_multiple happiness_from_others Safe_switch_point female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg insurance_multiple happiness_from_others sum_diff Safe_switch_point female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)

**
reg gold_multiple happiness_from_others sum_diff if quarter == 0
outreg2 using $data\reg_performance,excel replace ctitle(performance_multiple)
reg gold_multiple happiness_from_others Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg gold_multiple happiness_from_others sum_diff Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg gold_multiple happiness_from_others sum_diff female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg gold_multiple happiness_from_others Safe_switch_point female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg gold_multiple happiness_from_others sum_diff Safe_switch_point female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)



reg gold_multiple happiness_from_others sum_diff if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel replace ctitle(performance_multiple)
reg gold_multiple happiness_from_others Safe_switch_point if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg gold_multiple happiness_from_others sum_diff Safe_switch_point if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg gold_multiple happiness_from_others sum_diff female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg gold_multiple happiness_from_others Safe_switch_point female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg gold_multiple happiness_from_others sum_diff Safe_switch_point female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)






















destring Q6, gen(H6)


/*Happiness*/
reg performance_multiple H6 sum_diff if quarter == 0
outreg2 using $data\reg_performance,excel replace ctitle(performance_multiple)
reg performance_multiple H6 Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(performance_multiple)
reg performance_multiple H6 sum_diff Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(performance_multiple)
reg performance_multiple H6 sum_diff female seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(performance_multiple)
reg performance_multiple H6 Safe_switch_point female seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(performance_multiple)
reg performance_multiple H6 sum_diff Safe_switch_point female seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(performance_multiple)



reg performance_multiple H6 sum_diff if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance_multiple)
reg performance_multiple H6 Safe_switch_point if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance_multiple)
reg performance_multiple H6 sum_diff Safe_switch_point if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance_multiple)
reg performance_multiple H6 sum_diff female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance_multiple)
reg performance_multiple H6 Safe_switch_point female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance_multiple)
reg performance_multiple H6 sum_diff Safe_switch_point female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(performance_multiple)

**
reg fund_multiple H6 sum_diff if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple H6 Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple H6 sum_diff Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple H6 sum_diff female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple H6 Safe_switch_point female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple H6 sum_diff Safe_switch_point female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)



reg fund_multiple H6 sum_diff if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple H6 Safe_switch_point if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple H6 sum_diff Safe_switch_point if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple H6 sum_diff female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple H6 Safe_switch_point female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)
reg fund_multiple H6 sum_diff Safe_switch_point female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(fund_multiple)

**
reg insurance_multiple H6 sum_diff if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(insurance_multiple)
reg insurance_multiple H6 Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(insurance_multiple)
reg insurance_multiple H6 sum_diff Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(insurance_multiple)
reg insurance_multiple H6 sum_diff female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(insurance_multiple)
reg insurance_multiple H6 Safe_switch_point female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(insurance_multiple)
reg insurance_multiple H6 sum_diff Safe_switch_point female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(insurance_multiple)



reg insurance_multiple H6 sum_diff if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(insurance_multiple)
reg insurance_multiple H6 Safe_switch_point if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(insurance_multiple)
reg insurance_multiple H6 sum_diff Safe_switch_point if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(insurance_multiple)
reg insurance_multiple H6 sum_diff female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(insurance_multiple)
reg insurance_multiple H6 Safe_switch_point female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(insurance_multiple)
reg insurance_multiple H6 sum_diff Safe_switch_point female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(insurance_multiple)

**
reg gold_multiple H6 sum_diff if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(gold_multiple)
reg gold_multiple H6 Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(gold_multiple)
reg gold_multiple H6 sum_diff Safe_switch_point if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(gold_multiple)
reg gold_multiple H6 sum_diff female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(gold_multiple)
reg gold_multiple H6 Safe_switch_point female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(gold_multiple)
reg gold_multiple H6 sum_diff Safe_switch_point female  seniority if quarter == 0
outreg2 using $data\reg_performance,excel append ctitle(gold_multiple)



reg gold_multiple H6 sum_diff if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(gold_multiple)
reg gold_multiple H6 Safe_switch_point if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(gold_multiple)
reg gold_multiple H6 sum_diff Safe_switch_point if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(gold_multiple)
reg gold_multiple H6 sum_diff female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(gold_multiple)
reg gold_multiple H6 Safe_switch_point female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(gold_multiple)
reg gold_multiple H6 sum_diff Safe_switch_point female  seniority if quarter > 0, cluster(hash_number)
outreg2 using $data\reg_performance,excel append ctitle(gold_multiple)

