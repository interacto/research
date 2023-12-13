library(lsr) 

widgetbinding_vals <- ((read.table("data/Test_Results-widgetbinding1", head=FALSE)/1000)+
  (read.table("data/Test_Results-widgetbinding2", head=FALSE)/1000)+
  (read.table("data/Test_Results-widgetbinding3", head=FALSE)/1000)+
  (read.table("data/Test_Results-widgetbinding4", head=FALSE)/1000)+
  (read.table("data/Test_Results-widgetbinding5", head=FALSE)/1000)+
  (read.table("data/Test_Results-widgetbinding6", head=FALSE)/1000)+
  (read.table("data/Test_Results-widgetbinding7", head=FALSE)/1000)+
  (read.table("data/Test_Results-widgetbinding8", head=FALSE)/1000)+
  (read.table("data/Test_Results-widgetbinding9", head=FALSE)/1000)+
  (read.table("data/Test_Results-widgetbinding10", head=FALSE)/1000))/10;

listener_vals <- ((read.table("data/Test_Results-listener1", head=FALSE)/1000)+
  (read.table("data/Test_Results-listener2", head=FALSE)/1000)+
  (read.table("data/Test_Results-listener3", head=FALSE)/1000)+
  (read.table("data/Test_Results-listener4", head=FALSE)/1000)+
  (read.table("data/Test_Results-listener5", head=FALSE)/1000)+
  (read.table("data/Test_Results-listener6", head=FALSE)/1000)+
  (read.table("data/Test_Results-listener7", head=FALSE)/1000)+
  (read.table("data/Test_Results-listener8", head=FALSE)/1000)+
  (read.table("data/Test_Results-listener9", head=FALSE)/1000)+
  (read.table("data/Test_Results-listener10", head=FALSE)/1000))/10;

# The 71 first values refer to test that involve comlex user interactions
listener_vals_complex <- listener_vals[1:71,]
widgetbinding_vals_complex <- widgetbinding_vals[1:71,]

shapiro.test(listener_vals$V1) # p-value < 2.2e-16
shapiro.test(widgetbinding_vals$V1) # p-value < 2.2e-16

wilcox.test(widgetbinding_vals$V1, listener_vals$V1) # p-value = 0.9472

mean(widgetbinding_vals$V1) # 1.334202
mean(listener_vals$V1) # 1.331998

svg("times.svg")
boxplot(listener_vals$V1, widgetbinding_vals$V1, names = c("Callback", "Interacto"), ylab="Execution time (s)", xlab="", cex.lab=1.5, cex.axis=1.5)
dev.off()

# ------
wilcox.test(widgetbinding_vals_complex, listener_vals_complex) # p-value = 0.9902

mean(widgetbinding_vals_complex) # 1.383725
mean(listener_vals_complex) # 1.381321

boxplot(listener_vals_complex, widgetbinding_vals_complex, names = c("Callback", "Interacto"), ylab="Execution time (s)", xlab="", cex.lab=1.5, cex.axis=1.5)



