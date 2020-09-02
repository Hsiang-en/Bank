library(haven)
Exam_score <- read_dta("~/Documents/Esun/Exam_score.dta")

# for plot
Exam <- filter(Exam_score, quarter==0)

plot1 <- ggplot(Exam, aes(x=sum_diff)) + geom_bar(fill="darkcyan") + theme(axis.text.x = element_text(angle = 45)) + scale_x_continuous(limits =c(0,1800),breaks = c(0,100,200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700))
plot1

plot2 <- ggplot(Exam, aes(x=Safe_switch_point)) + geom_bar(fill="darkcyan") + theme(axis.text.x = element_text(angle = 45)) + scale_x_continuous(limits =c(0,135),breaks = c(0,10,20,30,40,50,60,70,80,90,100,110,120,130)) 
plot2

plot3 <- ggplot(Exam, aes(x=time_switch_point)) + geom_bar(fill="darkcyan") + theme(axis.text.x = element_text(angle = 45)) + scale_x_continuous(limits =c(0,215),breaks = c(0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210))
plot3

plot4 <- ggplot(Exam, aes(x=sum_coinright)) + geom_bar(fill="darkcyan") + theme(axis.text.x = element_text(angle = 45)) + scale_x_continuous(limits =c(0,10.45),breaks = c(0,1,2,3,4,5,6,7,8,9,10))
plot4

plot5 <- ggplot(Exam, aes(x=sum_fin)) + geom_bar(fill="darkcyan") + theme(axis.text.x = element_text(angle = 45)) + scale_x_continuous(limits =c(0,5.45),breaks = c(0,1,2,3,4,5))
plot5

plot6 <- ggplot(Exam, aes(x=sum_cog)) + geom_bar(fill="darkcyan") + theme(axis.text.x = element_text(angle = 45)) + scale_x_continuous(limits =c(0,3.45),breaks = c(0,1,2,3))
plot6


install.packages("csv")
library(csv)
write.csv(Exam, "Documents/Esun/Exam.csv")

library(readr)
Happiness <- read_csv("~/Documents/Esun/Happiness.csv")

df <- left_join(Exam, Happiness, by="hash_No")

df <- mutate(df, Happiness_from_myself = ifelse(Happiness_from_others == 0 & Happiness_from_others_and_myself ==0,1,0))

df <- filter(df, Happiness_from_others_and_myself ==0)
df <- mutate(df, happiness=ifelse(Happiness_from_others == 1,1,ifelse(Happiness_from_myself==1,2,0)))
df$happiness<- factor(df$happiness, levels=c(1, 2), labels=c("Happiness from others","Happiness from myself"))

plot7<-ggplot(df, aes(x=happiness)) + geom_bar(bins = 25, fill="lightskyblue") + theme(axis.text.x = element_text(vjust=0.5,angle = 30)) 
plot7


plot8<- ggplot(df, aes(x=Safe_switch_point, y=performance_multiple)) + geom_jitter(fill="lightskyblue") + geom_smooth(colour="darkcyan",method="lm",se=FALSE) + theme(axis.text.x = element_text(angle = 45)) + scale_x_continuous(limits =c(0,135),breaks = c(0,10,20,30,40,50,60,70,80,90,100,110,120,130)) 
plot8


plot9<- ggplot(df, aes(x=sum_diff, y=performance_multiple)) + geom_jitter(fill="lightskyblue") + geom_smooth(colour="darkcyan",method="lm",se=FALSE) + theme(axis.text.x = element_text(angle = 45)) + scale_x_continuous(limits =c(0,1800),breaks = c(0,100,200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700))
plot9



df <- mutate(df, high_seniority=ifelse(seniority>4.9 | seniority==4.9,1,0))

plot99<- ggplot(df, aes(x=sum_diff, y=performance_multiple)) + geom_jitter(fill="lightskyblue") + geom_smooth(colour="darkcyan",method="lm",se=FALSE) + theme(axis.text.x = element_text(angle = 45)) + scale_x_continuous(limits =c(0,1800),breaks = c(0,100,200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700)) + facet_wrap(~female+high_seniority)
plot99


df9 <- filter(df, sum_diff<1000)
df9$high_seniority <- factor(df9$high_seniority, levels=c(0, 1), labels=c("lower seniority", "higher seniority"))
df9$female <- factor(df9$female, levels=c(0, 1), labels=c("male", "female"))
plot99<- ggplot(df9, aes(x=sum_diff, y=performance_multiple)) + geom_jitter(fill="lightskyblue") + geom_smooth(colour="darkcyan",method="lm",se=FALSE) + theme(axis.text.x = element_text(angle = 30)) + scale_x_continuous(limits =c(0,1000),breaks = c(0,100,200,300,400,500,600,700,800,900,1000)) + facet_wrap(~female+high_seniority)
plot99



#df1<-filter(df, sum_diff<1000)
  
#plot10<- ggplot(df1, aes(x=sum_diff, y=performance)) + geom_jitter(fill="lightskyblue") + geom_smooth(method="lm",se=FALSE) + theme(axis.text.x = element_text(angle = 45)) 
#plot10 

plot11<- ggplot(df, aes(x=seniority, y=performance_multiple)) + geom_jitter(fill="lightskyblue") + geom_smooth(colour="darkcyan",method="lm",se=FALSE) + theme(axis.text.x = element_text(angle = 45)) + scale_x_continuous(limits =c(0,14),breaks = c(0,1,2,3,4,5,6,7,8,9,10,11,12,13))  
plot11

df2<- df %>% group_by(female)
df3<-mutate(df2, meanp=mean(performance_multiple))
df4<-filter(df3,hash_number==1 | hash_number==3)

plot12<-ggplot(df4, aes(x=female, y=meanp)) + geom_col(fill="darkcyan") + theme(text = element_text(family = "LiHei Pro",size=12),axis.text.x = element_text(angle = 0)) + scale_x_continuous(limits =c(-0.45,1.45),breaks = c(0,1),labels = c("男","女"))+xlab("性別")+ylab("綜合業績倍數")
plot12

plot13<-ggplot(df, aes(x=H6, y=performance_multiple)) + geom_jitter(fill="lightskyblue") + geom_smooth(colour="darkcyan",method="lm",se=FALSE) + theme(text = element_text(family = "LiHei Pro"),axis.text.x = element_text(angle = 45)) + scale_x_continuous(limits =c(0,7.45),breaks = c(0,1,2,3,4,5,6,7))+xlab("對於客戶抱怨銷售的產品：您的快樂程度是")
plot13

plot14<- ggplot(df, aes(x=Happiness_from_others)) + geom_bar(fill="darkcyan") + theme(text = element_text(family = "LiHei Pro",size=12),axis.text.x = element_text(angle = 0)) + scale_x_continuous(limits =c(-0.45,1.45),breaks = c(0,1),labels = c("自己","他人"))+xlab("快樂感來自")
plot14

plot15<- ggplot(df, aes(x=National_University)) + geom_bar(fill="darkcyan") + theme(text = element_text(family = "LiHei Pro",size=12),axis.text.x = element_text(angle = 0)) + scale_x_continuous(limits =c(-0.45,1.45),breaks = c(0,1),labels = c("私立學校","國立學校"))+xlab("最高學歷就讀")
plot15

plot16<- ggplot(df, aes(x=National_or_Famous_Private_Unive)) + geom_bar(fill="darkcyan") + theme(text = element_text(family = "LiHei Pro",size=12),axis.text.x = element_text(angle = 0)) + scale_x_continuous(limits =c(-0.45,1.45),breaks = c(0,1),labels = c("其他學校","國立學校或私立名校"))+xlab("最高學歷就讀")
plot16

plot17<- ggplot(df, aes(x=Exam_score)) + geom_histogram(binwidth = 1,fill="darkcyan") + theme(text = element_text(family = "LiHei Pro",size=12),axis.text.x = element_text(angle = 0)) + scale_x_continuous(limits =c(0,100),breaks = c(0,10,20,30,40,50,60,70,80,90,100)) +xlab("錄取分數")
plot17

df$H1 <- as.numeric(df$Q1)
df$H2 <- as.numeric(df$Q2)
df$H3 <- as.numeric(df$Q3)
df$H4 <- as.numeric(df$Q4)
df$H5 <- as.numeric(df$Q5)
df$H6 <- as.numeric(df$Q6)
df$H7 <- as.numeric(df$Q7)
df$H8 <- as.numeric(df$Q8)
df$H9 <- as.numeric(df$Q9)
df$H10 <- as.numeric(df$Q10)

plotH1 <- ggplot(df, aes(x=H1)) + geom_bar( fill="darkcyan") + theme(text = element_text(family = "LiHei Pro"),axis.text.x = element_text(angle = 0)) + scale_x_continuous(limits =c(0,7.45),breaks = c(0,1,2,3,4,5,6,7))+ labs(x = "除了工作以外的日常生活")
plotH1

plotH2 <- ggplot(df, aes(x=H2)) + geom_bar( fill="darkcyan") + theme(text = element_text(family = "LiHei Pro"),axis.text.x = element_text(angle = 0)) + scale_x_continuous(limits =c(0,7.45),breaks = c(0,1,2,3,4,5,6,7))+ labs(x = "與工作相關的日常生活")
plotH2

plotH3 <- ggplot(df, aes(x=H3)) + geom_bar( fill="darkcyan") + theme(text = element_text(family = "LiHei Pro"),axis.text.x = element_text(angle = 0)) + scale_x_continuous(limits =c(0,7.45),breaks = c(0,1,2,3,4,5,6,7))+ labs(x = "向客戶介紹產品")
plotH3

plotH4 <- ggplot(df, aes(x=H4)) + geom_bar( fill="darkcyan") + theme(text = element_text(family = "LiHei Pro"),axis.text.x = element_text(angle = 0)) + scale_x_continuous(limits =c(0,7.45),breaks = c(0,1,2,3,4,5,6,7))+ labs(x = "客戶購買您所介紹的產品")
plotH4

plotH5 <- ggplot(df, aes(x=H5)) + geom_bar( fill="darkcyan") + theme(text = element_text(family = "LiHei Pro"),axis.text.x = element_text(angle = 0)) + scale_x_continuous(limits =c(0,7.45),breaks = c(0,1,2,3,4,5,6,7))+ labs(x = "客戶向您表達他滿意您銷售的產品")
plotH5

plotH6 <- ggplot(df, aes(x=H6)) + geom_bar( fill="darkcyan") + theme(text = element_text(family = "LiHei Pro"),axis.text.x = element_text(angle = 0)) + scale_x_continuous(limits =c(0,7.45),breaks = c(0,1,2,3,4,5,6,7))+ labs(x = "客戶向您抱怨您銷售的產品")
plotH6

plotH7 <- ggplot(df, aes(x=H7)) + geom_bar( fill="darkcyan") + theme(text = element_text(family = "LiHei Pro"),axis.text.x = element_text(angle = 0)) + scale_x_continuous(limits =c(0,7.45),breaks = c(0,1,2,3,4,5,6,7))+ labs(x = "舊客戶介紹他的親人或朋友給您")
plotH7

plotH8 <- ggplot(df, aes(x=H8)) + geom_bar( fill="darkcyan") + theme(text = element_text(family = "LiHei Pro"),axis.text.x = element_text(angle = 0)) + scale_x_continuous(limits =c(0,7.45),breaks = c(0,1,2,3,4,5,6,7))+ labs(x = "您獲得業績獎金")
plotH8

plotH9 <- ggplot(df, aes(x=H9)) + geom_bar( fill="darkcyan") + theme(text = element_text(family = "LiHei Pro"),axis.text.x = element_text(angle = 0)) + scale_x_continuous(limits =c(0,7.45),breaks = c(0,1,2,3,4,5,6,7))+ labs(x = "您的個人業績表現領先同行同事")
plotH9

plotH10 <- ggplot(df, aes(x=H10)) + geom_bar( fill="darkcyan") + theme(text = element_text(family = "LiHei Pro"),axis.text.x = element_text(angle = 0)) + scale_x_continuous(limits =c(0,7.45),breaks = c(0,1,2,3,4,5,6,7))+ labs(x = "您的分行團體業績表現領先其他分行")
plotH10

install.packages("csv")
library(csv)
write.csv(df, "~/Documents/Esun/All.csv")

