library(lsr) 

widgetbinding <- rbind(read.table("data/Test_Results-widgetbinding1", head=FALSE), 
                       read.table("data/Test_Results-widgetbinding2", head=FALSE),
                       read.table("data/Test_Results-widgetbinding3", head=FALSE),
                       read.table("data/Test_Results-widgetbinding4", head=FALSE),
                       read.table("data/Test_Results-widgetbinding5", head=FALSE),
                       read.table("data/Test_Results-widgetbinding6", head=FALSE),
                       read.table("data/Test_Results-widgetbinding7", head=FALSE),
                       read.table("data/Test_Results-widgetbinding8", head=FALSE),
                       read.table("data/Test_Results-widgetbinding9", head=FALSE),
                       read.table("data/Test_Results-widgetbinding10", head=FALSE))
listener <- rbind(read.table("data/Test_Results-listener1", head=FALSE),
                  read.table("data/Test_Results-listener2", head=FALSE),
                  read.table("data/Test_Results-listener3", head=FALSE),
                  read.table("data/Test_Results-listener4", head=FALSE),
                  read.table("data/Test_Results-listener5", head=FALSE),
                  read.table("data/Test_Results-listener6", head=FALSE),
                  read.table("data/Test_Results-listener7", head=FALSE),
                  read.table("data/Test_Results-listener8", head=FALSE),
                  read.table("data/Test_Results-listener9", head=FALSE),
                  read.table("data/Test_Results-listener10", head=FALSE))
rp <- rbind(read.table("data/Test_Results-RP1", head=FALSE), 
            read.table("data/Test_Results-RP2", head=FALSE),
            read.table("data/Test_Results-RP3", head=FALSE),
            read.table("data/Test_Results-RP4", head=FALSE),
            read.table("data/Test_Results-RP5", head=FALSE),
            read.table("data/Test_Results-RP6", head=FALSE),
            read.table("data/Test_Results-RP7", head=FALSE),
            read.table("data/Test_Results-RP8", head=FALSE),
            read.table("data/Test_Results-RP9", head=FALSE),
            read.table("data/Test_Results-RP10", head=FALSE))

svg("times.svg")
boxplot(listener$V1, widgetbinding$V1, rp$V1, names = c("Callback", "Widget Binding", "RP"), ylab="Execution time (ms)", xlab="")
dev.off()

mean(listener$V1) # 1331.998, 1.331 s
mean(widgetbinding$V1) # 1334.202, 1.334 s
mean(rp$V1) # 1329.621, 1.329 s

cohensD(listener$V1, widgetbinding$V1) #  0.003255322
cohensD(rp$V1, widgetbinding$V1) # 0.006777315

shapiro.test(listener$V1) # p-value < 2.2e-16
shapiro.test(widgetbinding$V1) # p-value < 2.2e-16

wilcox.test(listener$V1, widgetbinding$V1) #  0.8509
wilcox.test(rp$V1, widgetbinding$V1) # 0.7282
