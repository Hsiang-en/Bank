library(haven)
panel_multiple <- read_dta("Documents/Esun/panel_multiple.dta")
View(panel_multiple)

#install.packages("dplyr")
#library(dplyr)

#install.packages("ggplot2")
#library(ggplot2)

# twoway (scatter performance_allyear_multiple sum_diff)(lfit performance_allyear_multiple sum_diff)
# gender*seniority
allyear1 <- summarise(panel_multiple, performance=ifelse(quarter==0, performance_multiple, 0), sum_diff=sum_diff, seniority=seniority, female=female)
allyear1 <- filter(allyear1, performance>0)

allyear1 <- mutate(allyear1, high_seniority = ifelse(seniority>4.9 | seniority==4.9, 1, 0))
allyear1$high_seniority <- factor(allyear1$high_seniority, levels=c(0, 1), labels=c("lower seniority", "higher seniority"))
allyear1$female <- factor(allyear1$female, levels=c(0, 1), labels=c("male", "female"))

plot1 <- ggplot(allyear1, aes(y=performance, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('performance') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + high_seniority) + labs(caption = "performance on sum_diff by gender and seniority which is divided into higher and lower group by median.")
plot1

allyear11 <- filter(allyear1, sum_diff<1500)
plot11 <- ggplot(allyear11, aes(y=performance, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('performance') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + high_seniority) + labs(caption = "performance on sum_diff by gender and seniority which is divided into higher and lower group by median.The observation whose sum_diff is 1780 is ruled out")
plot11


# gender*(seniority in quantile)
allyear2 <- summarise(panel_multiple, performance=ifelse(quarter==0, performance_multiple, 0), sum_diff=sum_diff, seniority=seniority, female=female)
allyear2 <- filter(allyear2, performance>0)

allyear2 <- mutate(allyear2, Q_seniority = ifelse(seniority>7.8 | seniority==7.8, 1, 0))
allyear2$Q_seniority[allyear2$seniority <7.8 & (allyear2$seniority>4.9 | allyear2$seniority==4.9)] <- 2
allyear2$Q_seniority[allyear2$seniority <4.9 & (allyear2$seniority>3.3 | allyear2$seniority==3.3)] <- 3
allyear2$Q_seniority[allyear2$seniority <3.3 & (allyear2$seniority>0.5 | allyear2$seniority==0.5)] <- 4

allyear2$Q_seniority <- factor(allyear2$Q_seniority, levels=c(1, 2, 3, 4), labels=c("top 25%", "25% to 50%", "50% to 75%", "75% to 100%"))
allyear2$female <- factor(allyear2$female, levels=c(0, 1), labels=c("male", "female"))

plot2 <- ggplot(allyear2, aes(y=performance, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('performance') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + Q_seniority)+ labs(caption = "performance on sum_diff by gender and seniority which is divided into four groups by quantile.") 
plot2

allyear22 <- filter(allyear2, sum_diff<1500)
plot22 <- ggplot(allyear22, aes(y=performance, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('performance') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + Q_seniority)+ labs(caption = "performance on sum_diff by gender and seniority which is divided into four groups by quantile.The observation whose sum_diff is 1780 is ruled out")  
plot22



#箱型圖
plot3 <- ggplot(allyear1, aes(x=performance, y=sum_diff)) + geom_boxplot(mapping = aes(group=performance, x=performance, y=sum_diff), colour="deepskyblue1") + xlab('sum_diff') + ylab('performance') + facet_wrap(~female + high_seniority)+ labs(caption = "Boxplot:performance on sum_diff by gender and seniority which is divided into higher and lower group by median.") 
plot3

allyear33 <- filter(allyear1, sum_diff<1500)
plot33 <-  ggplot(allyear33, aes(x=performance, y=sum_diff)) + geom_boxplot(mapping = aes(group=performance, x=performance, y=sum_diff), colour="deepskyblue1") + xlab('sum_diff') + ylab('performance') + facet_wrap(~female + high_seniority) + labs(caption = "Boxplot:performance on sum_diff by gender and seniority which is divided into higher and lower group by median.The observation whose sum_diff is 1780 is ruled out")
plot33



#
#graph1 <- filter(allyear1, female=="male" & high_seniority=="higher seniority")
#plot111 <- ggplot(graph1, aes(x=performance, y=sum_diff)) + geom_boxplot(mapping = aes(group=performance, x=performance, y=sum_diff), colour="deepskyblue1") + xlab('sum_diff') + ylab('performance')
#plot111

#graph2 <- filter(allyear1, female=="male" & high_seniority=="lower seniority")
#plot222 <- ggplot(graph2, aes(x=performance, y=sum_diff)) + geom_boxplot(mapping = aes(group=performance, x=performance, y=sum_diff), colour="deepskyblue1") + xlab('sum_diff') + ylab('performance')
#plot222

#graph3 <- filter(allyear1, female=="female" & high_seniority=="higher seniority")
#plot333 <- ggplot(graph3, aes(x=performance, y=sum_diff)) + geom_boxplot(mapping = aes(group=performance, x=performance, y=sum_diff), colour="deepskyblue1") + xlab('sum_diff') + ylab('performance')
#plot333

#graph4 <- filter(allyear1, female=="female" & high_seniority=="lower seniority")
#plot4 <- ggplot(graph4, aes(x=performance, y=sum_diff)) + geom_boxplot(mapping = aes(group=performance, x=performance, y=sum_diff), colour="deepskyblue1") + xlab('sum_diff') + ylab('performance')
#plot4




plot4 <- ggplot(allyear2, aes(x=performance, y=sum_diff)) + geom_boxplot(mapping = aes(group=performance, x=performance, y=sum_diff), colour="deepskyblue1") + xlab('sum_diff') + ylab('performance') + facet_wrap(~female + Q_seniority) + labs(caption = "Boxplot:performance on sum_diff by gender and seniority which is divided into four groups by quantile.") 
plot4

allyear44 <- filter(allyear1, sum_diff<1500)
plot44 <- ggplot(allyear44, aes(y=performance, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('performance') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + Q_seniority) + labs(caption = "Boxplot:performance on sum_diff by gender and seniority which is divided into four groups by quantile.The observation whose sum_diff is 1780 is ruled out") 
plot4


#四季資料
allyear5 <- summarise(panel_multiple, performance=ifelse(quarter>0, performance_multiple, 0), sum_diff=sum_diff, seniority=seniority, female=female)
allyear5 <- filter(allyear5, performance>0)

allyear5 <- mutate(allyear5, high_seniority = ifelse(seniority>4.9 | seniority==4.9, 1, 0))
allyear5$high_seniority <- factor(allyear5$high_seniority, levels=c(0, 1), labels=c("lower seniority", "higher seniority"))
allyear5$female <- factor(allyear5$female, levels=c(0, 1), labels=c("male", "female"))

plot5 <- ggplot(allyear5, aes(y=performance, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('performance') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + high_seniority) +labs(caption = "Quarter data:performance on sum_diff by gender and seniority which is divided into higher and lower group by median")
plot5

allyear55 <- filter(allyear1, sum_diff<1500)
plot55 <- ggplot(allyear11, aes(y=performance, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('performance') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + high_seniority) +labs(caption = "Quarter data:performance on sum_diff by gender and seniority which is divided into higher and lower group by median.The observation whose sum_diff is 1780 is ruled out")
plot55


# gender*(seniority in quantile)
allyear6 <- summarise(panel_multiple, performance=ifelse(quarter>0, performance_multiple, 0), sum_diff=sum_diff, seniority=seniority, female=female)
allyear6 <- filter(allyear6, performance>0)

allyear6 <- mutate(allyear6, Q_seniority = ifelse(seniority>7.8 | seniority==7.8, 1, 0))
allyear6$Q_seniority[allyear6$seniority <7.8 & (allyear6$seniority>4.9 | allyear6$seniority==4.9)] <- 2
allyear6$Q_seniority[allyear6$seniority <4.9 & (allyear6$seniority>3.3 | allyear6$seniority==3.3)] <- 3
allyear6$Q_seniority[allyear6$seniority <3.3 & (allyear6$seniority>0.5 | allyear6$seniority==0.5)] <- 4

allyear6$Q_seniority <- factor(allyear6$Q_seniority, levels=c(1, 2, 3, 4), labels=c("top 25%", "25% to 50%", "50% to 75%", "75% to 100%"))
allyear6$female <- factor(allyear6$female, levels=c(0, 1), labels=c("male", "female"))

plot6 <- ggplot(allyear6, aes(y=performance, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('performance') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + Q_seniority) + labs(caption = "quarter data:Boxplot:performance on sum_diff by gender and seniority which is divided into four groups by quantile.") 
plot6

allyear66 <- filter(allyear6, sum_diff<1500)
plot66 <- ggplot(allyear66, aes(y=performance, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('performance') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + Q_seniority) + labs(caption = "Quarter data:performance on sum_diff by gender and seniority which is divided into four groups by quantile.The observation whose sum_diff is 1780 is ruled out") 
plot66






















#對其他三種績效
#基金
fund1 <- summarise(panel_multiple, fund=ifelse(quarter==0, fund_multiple, 0), sum_diff=sum_diff, seniority=seniority, female=female)
fund1 <- filter(fund1, fund>0)

fund1 <- mutate(fund1, high_seniority = ifelse(seniority>4.9 | seniority==4.9, 1, 0))
fund1$high_seniority <- factor(fund1$high_seniority, levels=c(0, 1), labels=c("lower seniority", "higher seniority"))
fund1$female <- factor(fund1$female, levels=c(0, 1), labels=c("male", "female"))

plot1 <- ggplot(fund1, aes(y=fund, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('fund') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + high_seniority) + labs(caption = "fund on sum_diff by gender and seniority which is divided into higher and lower group by median.")
plot1

fund11 <- filter(fund1, sum_diff<1500)
plot11 <- ggplot(fund11, aes(y=fund, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('fund') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + high_seniority) + labs(caption = "fund on sum_diff by gender and seniority which is divided into higher and lower group by median.The observation whose sum_diff is 1780 is ruled out")
plot11


# gender*(seniority in quantile)
fund2 <- summarise(panel_multiple, fund=ifelse(quarter==0, fund_multiple, 0), sum_diff=sum_diff, seniority=seniority, female=female)
fund2 <- filter(fund2, fund>0)

fund2 <- mutate(fund2, Q_seniority = ifelse(seniority>7.8 | seniority==7.8, 1, 0))
fund2$Q_seniority[fund2$seniority <7.8 & (fund2$seniority>4.9 | fund2$seniority==4.9)] <- 2
fund2$Q_seniority[fund2$seniority <4.9 & (fund2$seniority>3.3 | fund2$seniority==3.3)] <- 3
fund2$Q_seniority[fund2$seniority <3.3 & (fund2$seniority>0.5 | fund2$seniority==0.5)] <- 4

fund2$Q_seniority <- factor(fund2$Q_seniority, levels=c(1, 2, 3, 4), labels=c("top 25%", "25% to 50%", "50% to 75%", "75% to 100%"))
fund2$female <- factor(fund2$female, levels=c(0, 1), labels=c("male", "female"))

plot2 <- ggplot(fund2, aes(y=fund, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('fund') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + Q_seniority)+ labs(caption = "fund on sum_diff by gender and seniority which is divided into four groups by quantile.") 
plot2

fund22 <- filter(fund2, sum_diff<1500)
plot22 <- ggplot(fund22, aes(y=fund, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('fund') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + Q_seniority)+ labs(caption = "fund on sum_diff by gender and seniority which is divided into four groups by quantile.The observation whose sum_diff is 1780 is ruled out")  
plot22


#四季資料
fund3 <- summarise(panel_multiple, fund=ifelse(quarter>0, fund_multiple, 0), sum_diff=sum_diff, seniority=seniority, female=female)
fund3 <- filter(fund3, fund>0)

fund3 <- mutate(fund3, high_seniority = ifelse(seniority>4.9 | seniority==4.9, 1, 0))
fund3$high_seniority <- factor(fund3$high_seniority, levels=c(0, 1), labels=c("lower seniority", "higher seniority"))
fund3$female <- factor(fund3$female, levels=c(0, 1), labels=c("male", "female"))

plot3 <- ggplot(fund3, aes(y=fund, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('fund') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + high_seniority) +labs(caption = "Quarter fund on sum_diff by gender and seniority which is divided into higher and lower group by median")
plot3

fund33 <- filter(fund3, sum_diff<1500)
plot33 <- ggplot(fund33, aes(y=fund, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('fund') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + high_seniority) +labs(caption = "Quarter fund on sum_diff by gender and seniority which is divided into higher and lower group by median.The observation whose sum_diff is 1780 is ruled out")
plot33


# gender*(seniority in quantile)
fund4 <- summarise(panel_multiple, fund=ifelse(quarter>0, fund_multiple, 0), sum_diff=sum_diff, seniority=seniority, female=female)
fund4 <- filter(fund4, fund>0)

fund4 <- mutate(fund4, Q_seniority = ifelse(seniority>7.8 | seniority==7.8, 1, 0))
fund4$Q_seniority[fund4$seniority <7.8 & (fund4$seniority>4.9 | fund4$seniority==4.9)] <- 2
fund4$Q_seniority[fund4$seniority <4.9 & (fund4$seniority>3.3 | fund4$seniority==3.3)] <- 3
fund4$Q_seniority[fund4$seniority <3.3 & (fund4$seniority>0.5 | fund4$seniority==0.5)] <- 4

fund4$Q_seniority <- factor(fund4$Q_seniority, levels=c(1, 2, 3, 4), labels=c("top 25%", "25% to 50%", "50% to 75%", "75% to 100%"))
fund4$female <- factor(fund4$female, levels=c(0, 1), labels=c("male", "female"))

plot4 <- ggplot(fund4, aes(y=fund, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('fund') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + Q_seniority) + labs(caption = "quarter fund performance on sum_diff by gender and seniority which is divided into four groups by quantile.") 
plot4

fund44 <- filter(fund4, sum_diff<1500)
plot44 <- ggplot(fund44, aes(y=fund, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('fund') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + Q_seniority) + labs(caption = "Quarter fund on sum_diff by gender and seniority which is divided into four groups by quantile.The observation whose sum_diff is 1780 is ruled out") 
plot44

















#保險
insurance1 <- summarise(panel_multiple, insurance=ifelse(quarter==0, insurance_multiple, 0), sum_diff=sum_diff, seniority=seniority, female=female)
insurance1 <- filter(insurance1, insurance>0)

insurance1 <- mutate(insurance1, high_seniority = ifelse(seniority>4.9 | seniority==4.9, 1, 0))
insurance1$high_seniority <- factor(insurance1$high_seniority, levels=c(0, 1), labels=c("lower seniority", "higher seniority"))
insurance1$female <- factor(insurance1$female, levels=c(0, 1), labels=c("male", "female"))

plot1 <- ggplot(insurance1, aes(y=insurance, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('insurance') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + high_seniority) + labs(caption = "insurance on sum_diff by gender and seniority which is divided into higher and lower group by median.")
plot1

insurance11 <- filter(insurance1, sum_diff<1500)
plot11 <- ggplot(insurance11, aes(y=insurance, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('insurance') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + high_seniority) + labs(caption = "insurance on sum_diff by gender and seniority which is divided into higher and lower group by median.The observation whose sum_diff is 1780 is ruled out")
plot11


# gender*(seniority in quantile)
insurance2 <- summarise(panel_multiple, insurance=ifelse(quarter==0, insurance_multiple, 0), sum_diff=sum_diff, seniority=seniority, female=female)
insurance2 <- filter(insurance2, insurance>0)

insurance2 <- mutate(insurance2, Q_seniority = ifelse(seniority>7.8 | seniority==7.8, 1, 0))
insurance2$Q_seniority[insurance2$seniority <7.8 & (insurance2$seniority>4.9 | insurance2$seniority==4.9)] <- 2
insurance2$Q_seniority[insurance2$seniority <4.9 & (insurance2$seniority>3.3 | insurance2$seniority==3.3)] <- 3
insurance2$Q_seniority[insurance2$seniority <3.3 & (insurance2$seniority>0.5 | insurance2$seniority==0.5)] <- 4

insurance2$Q_seniority <- factor(insurance2$Q_seniority, levels=c(1, 2, 3, 4), labels=c("top 25%", "25% to 50%", "50% to 75%", "75% to 100%"))
insurance2$female <- factor(insurance2$female, levels=c(0, 1), labels=c("male", "female"))

plot2 <- ggplot(insurance2, aes(y=insurance, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('insurance') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + Q_seniority)+ labs(caption = "insurance on sum_diff by gender and seniority which is divided into four groups by quantile.") 
plot2

insurance22 <- filter(insurance2, sum_diff<1500)
plot22 <- ggplot(insurance22, aes(y=insurance, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('insurance') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + Q_seniority)+ labs(caption = "insurance on sum_diff by gender and seniority which is divided into four groups by quantile.The observation whose sum_diff is 1780 is ruled out")  
plot22


#四季資料
insurance3 <- summarise(panel_multiple, insurance=ifelse(quarter>0, insurance_multiple, 0), sum_diff=sum_diff, seniority=seniority, female=female)
insurance3 <- filter(insurance3, insurance>0)

insurance3 <- mutate(insurance3, high_seniority = ifelse(seniority>4.9 | seniority==4.9, 1, 0))
insurance3$high_seniority <- factor(insurance3$high_seniority, levels=c(0, 1), labels=c("lower seniority", "higher seniority"))
insurance3$female <- factor(insurance3$female, levels=c(0, 1), labels=c("male", "female"))

plot3 <- ggplot(insurance3, aes(y=insurance, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('insurance') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + high_seniority) +labs(caption = "Quarter insurance on sum_diff by gender and seniority which is divided into higher and lower group by median")
plot3

insurance33 <- filter(insurance3, sum_diff<1500)
plot33 <- ggplot(insurance33, aes(y=insurance, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('insurance') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + high_seniority) +labs(caption = "Quarter insurance on sum_diff by gender and seniority which is divided into higher and lower group by median.The observation whose sum_diff is 1780 is ruled out")
plot33


# gender*(seniority in quantile)
insurance4 <- summarise(panel_multiple, insurance=ifelse(quarter>0, insurance_multiple, 0), sum_diff=sum_diff, seniority=seniority, female=female)
insurance4 <- filter(insurance4, insurance>0)

insurance4 <- mutate(insurance4, Q_seniority = ifelse(seniority>7.8 | seniority==7.8, 1, 0))
insurance4$Q_seniority[insurance4$seniority <7.8 & (insurance4$seniority>4.9 | insurance4$seniority==4.9)] <- 2
insurance4$Q_seniority[insurance4$seniority <4.9 & (insurance4$seniority>3.3 | insurance4$seniority==3.3)] <- 3
insurance4$Q_seniority[insurance4$seniority <3.3 & (insurance4$seniority>0.5 | insurance4insurance4$seniority==0.5)] <- 4

insurance4$Q_seniority <- factor(insurance4$Q_seniority, levels=c(1, 2, 3, 4), labels=c("top 25%", "25% to 50%", "50% to 75%", "75% to 100%"))
insurance4$female <- factor(insurance4$female, levels=c(0, 1), labels=c("male", "female"))

plot4 <- ggplot(insurance4, aes(y=insurance, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('insurance') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + Q_seniority) + labs(caption = "quarter insurance performance on sum_diff by gender and seniority which is divided into four groups by quantile.") 
plot4

insurance44 <- filter(insurance4, sum_diff<1500)
plot44 <- ggplot(insurance44, aes(y=insurance, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('insurance') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + Q_seniority) + labs(caption = "Quarter insurance on sum_diff by gender and seniority which is divided into four groups by quantile.The observation whose sum_diff is 1780 is ruled out") 
plot44













#金品
gold1 <- summarise(panel_multiple, gold=ifelse(quarter==0, gold_multiple, 0), sum_diff=sum_diff, seniority=seniority, female=female)
gold1 <- filter(gold1, gold>0)

gold1 <- mutate(gold1, high_seniority = ifelse(seniority>4.9 | seniority==4.9, 1, 0))
gold1$high_seniority <- factor(gold1$high_seniority, levels=c(0, 1), labels=c("lower seniority", "higher seniority"))
gold1$female <- factor(gold1$female, levels=c(0, 1), labels=c("male", "female"))

plot1 <- ggplot(gold1, aes(y=gold, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('gold') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + high_seniority) + labs(caption = "gold on sum_diff by gender and seniority which is divided into higher and lower group by median.")
plot1

gold11 <- filter(gold1, sum_diff<1500)
plot11 <- ggplot(gold11, aes(y=gold, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('gold') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + high_seniority) + labs(caption = "gold on sum_diff by gender and seniority which is divided into higher and lower group by median.The observation whose sum_diff is 1780 is ruled out")
plot11


# gender*(seniority in quantile)
gold2 <- summarise(panel_multiple, gold=ifelse(quarter==0, gold_multiple, 0), sum_diff=sum_diff, seniority=seniority, female=female)
gold2 <- filter(gold2, gold>0)

gold2 <- mutate(gold2, Q_seniority = ifelse(seniority>7.8 | seniority==7.8, 1, 0))
gold2$Q_seniority[gold2$seniority <7.8 & (gold2$seniority>4.9 | gold2$seniority==4.9)] <- 2
gold2$Q_seniority[gold2$seniority <4.9 & (gold2$seniority>3.3 | gold2$seniority==3.3)] <- 3
gold2$Q_seniority[gold2$seniority <3.3 & (gold2$seniority>0.5 | gold2$seniority==0.5)] <- 4

gold2$Q_seniority <- factor(gold2$Q_seniority, levels=c(1, 2, 3, 4), labels=c("top 25%", "25% to 50%", "50% to 75%", "75% to 100%"))
gold2$female <- factor(gold2$female, levels=c(0, 1), labels=c("male", "female"))

plot2 <- ggplot(gold2, aes(y=gold, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('gold') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + Q_seniority)+ labs(caption = "gold on sum_diff by gender and seniority which is divided into four groups by quantile.") 
plot2

gold22 <- filter(gold2, sum_diff<1500)
plot22 <- ggplot(gold22, aes(y=gold, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('gold') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + Q_seniority)+ labs(caption = "gold on sum_diff by gender and seniority which is divided into four groups by quantile.The observation whose sum_diff is 1780 is ruled out")  
plot22


#四季資料
gold3 <- summarise(panel_multiple, gold=ifelse(gold>0, insurance_multiple, 0), sum_diff=sum_diff, seniority=seniority, female=female)
gold3 <- filter(gold3, gold>0)

gold3 <- mutate(gold3, high_seniority = ifelse(seniority>4.9 | seniority==4.9, 1, 0))
gold3$high_seniority <- factor(gold3$high_seniority, levels=c(0, 1), labels=c("lower seniority", "higher seniority"))
gold3$female <- factor(gold3$female, levels=c(0, 1), labels=c("male", "female"))

plot3 <- ggplot(gold3, aes(y=gold, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('gold') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + high_seniority) +labs(caption = "Quarter gold on sum_diff by gender and seniority which is divided into higher and lower group by median")
plot3

gold33 <- filter(gold3, sum_diff<1500)
plot33 <- ggplot(gold33, aes(y=gold, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('gold') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + high_seniority) +labs(caption = "Quarter gold on sum_diff by gender and seniority which is divided into higher and lower group by median.The observation whose sum_diff is 1780 is ruled out")
plot33


# gender*(seniority in quantile)
gold4 <- summarise(panel_multiple, gold=ifelse(quarter>0, gold_multiple, 0), sum_diff=sum_diff, seniority=seniority, female=female)
gold4 <- filter(gold4, gold>0)

gold4 <- mutate(gold4, Q_seniority = ifelse(seniority>7.8 | seniority==7.8, 1, 0))
gold4$Q_seniority[gold4$seniority <7.8 & (gold4$seniority>4.9 | gold4$seniority==4.9)] <- 2
gold4$Q_seniority[gold4$seniority <4.9 & (gold4$seniority>3.3 | gold4$seniority==3.3)] <- 3
gold4$Q_seniority[gold4$seniority <3.3 & (gold4$seniority>0.5 | gold4$seniority==0.5)] <- 4

gold4$Q_seniority <- factor(gold4$Q_seniority, levels=c(1, 2, 3, 4), labels=c("top 25%", "25% to 50%", "50% to 75%", "75% to 100%"))
gold4$female <- factor(gold4$female, levels=c(0, 1), labels=c("male", "female"))

plot4 <- ggplot(gold4, aes(y=gold, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('gold') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + Q_seniority) + labs(caption = "quarter gold performance on sum_diff by gender and seniority which is divided into four groups by quantile.") 
plot4

gold44 <- filter(gold4, sum_diff<1500)
plot44 <- ggplot(gold44, aes(y=gold, x=sum_diff)) + geom_point(colour="deepskyblue1") + xlab('sum_diff') + ylab('gold') + geom_smooth(method="lm", colour="steelblue") + facet_wrap(~female + Q_seniority) + labs(caption = "Quarter gold on sum_diff by gender and seniority which is divided into four groups by quantile.The observation whose sum_diff is 1780 is ruled out") 
plot44









