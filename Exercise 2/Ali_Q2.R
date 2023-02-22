## Ali's code

GC = GC%>%
  mutate(hs_index= case_when(history=='terrible'~0,
                             history=='poor'~1,
                             history=='good'~2 ))
Avg_hs_index =  mean(GC$hs_index)
print(Avg_hs_index)

phat_test_logit_default = predict(glm1, default_test, type='response')

yhat_test_logit_default = ifelse(phat_test_logit_default > 0.5, 1, 0)

kkk= cbind(phat_test_logit_default, yhat_test_logit_default, default_test$Default)

confusion_matrix = table(defualt = default_test$Default,
                         Prediction = yhat_test_logit_default)

#how accurate is the model?
accuracy=sum(diag(confusion_matrix))/sum(confusion_matrix)

confusion_matrix
accuracy

##ROC curve
treshhold = c(0.1, 0.2,0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.7, 0.8, 0.9, 1)

accuracy = foreach(kk = treshhold, .combine='rbind') %do% {
  yhat_test_logit_default = ifelse(phat_test_logit_default > kk, 1, 0)
  
  confusion_matrix = table(defualt = default_test$Default,
                           Prediction = yhat_test_logit_default)
  accuracy_t1= (sum(diag(confusion_matrix))/sum(confusion_matrix))
}



df_t <- data.frame(x = treshhold, y = accuracy)
ggplot(df_t) +
  geom_point(aes(x = treshhold, y = accuracy))