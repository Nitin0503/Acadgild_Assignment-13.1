View(x)
y<-x[,-c(1:3)]
View(y)
library(caTools)
z<-is.na(y)
z
set.seed(50)
sample=sample.split(y$churn,SplitRatio = .80)
sample
train<-subset(y,sample==TRUE)
test<-subset(y,sample==FALSE)
library(rpart)
churn_model<-rpart(churn~.,data=train)
churn_model
n= 4000 

#node), split, n, loss, yval, (yprob)
#* denotes terminal node

#1) root 4000 566 no (0.85850000 0.14150000)  
#2) total_day_minutes< 265.4 3761 424 no (0.88726403 0.11273597)  
#4) number_customer_service_calls< 3.5 3459 275 no (0.92049725 0.07950275)  
#8) international_plan=no 3137 154 no (0.95090851 0.04909149)  
#16) total_day_minutes< 244.65 2969 112 no (0.96227686 0.03772314)  
#32) total_eve_minutes< 267.7 2690  77 no (0.97137546 0.02862454) *
 #33) total_eve_minutes>=267.7 279  35 no (0.87455197 0.12544803)  
#66) total_day_minutes< 222.2 248  13 no (0.94758065 0.05241935) *
#67) total_day_minutes>=222.2 31   9 yes (0.29032258 0.70967742)  
#134) voice_mail_plan=yes 7   0 no (1.00000000 0.00000000) *
#135) voice_mail_plan=no 24   2 yes (0.08333333 0.91666667) *
#17) total_day_minutes>=244.65 168  42 no (0.75000000 0.25000000)  
#34) total_eve_minutes< 205.6 92   3 no (0.96739130 0.03260870) *
 #35) total_eve_minutes>=205.6 76  37 yes (0.48684211 0.51315789)  
#70) voice_mail_plan=yes 22   1 no (0.95454545 0.04545455) *
  #71) voice_mail_plan=no 54  16 yes (0.29629630 0.70370370)  
  #142) total_night_minutes< 189.05 19   5 no (0.73684211 0.26315789) *
  #143) total_night_minutes>=189.05 35   2 yes (0.05714286 0.94285714) *
  #9) international_plan=yes 322 121 no (0.62422360 0.37577640)  
  #18) total_intl_minutes< 13.05 259  58 no (0.77606178 0.22393822)  
#36) total_intl_calls>=2.5 209   8 no (0.96172249 0.03827751) *
  #37) total_intl_calls< 2.5 50   0 yes (0.00000000 1.00000000) *
  #19) total_intl_minutes>=13.05 63   0 yes (0.00000000 1.00000000) *
 #5) number_customer_service_calls>=3.5 302 149 no (0.50662252 0.49337748)  
#10) total_day_minutes>=160.25 183  43 no (0.76502732 0.23497268)  
#20) total_eve_minutes>=141.45 164  30 no (0.81707317 0.18292683) *
  #21) total_eve_minutes< 141.45 19   6 yes (0.31578947 0.68421053) *
  #11) total_day_minutes< 160.25 119  13 yes (0.10924370 0.89075630) *
  #3) total_day_minutes>=265.4 239  97 yes (0.40585774 0.59414226)  
#6) voice_mail_plan=yes 55   5 no (0.90909091 0.09090909) *
  #7) voice_mail_plan=no 184  47 yes (0.25543478 0.74456522)  
 #14) total_eve_minutes< 163.95 48  15 no (0.68750000 0.31250000)  
#28) total_day_minutes< 302.5 39   7 no (0.82051282 0.17948718) *
  #29) total_day_minutes>=302.5 9   1 yes (0.11111111 0.88888889) *
  #15) total_eve_minutes>=163.95 136  14 yes (0.10294118 0.89705882) *
  
library(rattle)
fancyRpartPlot(churn_model)
pred<-predict(churn_model,test,type="class")
pred
table(test$churn,pred)
(849+102)/1000
#[1] 0.951
