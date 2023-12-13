# init data
setwd('your/dir/here')
library(lsr) 
library(effsize) # for VD.A

dataG1 <- read.table("G1.csv", head=TRUE, sep=";")
dataG2 <- read.table("G2.csv", head=TRUE, sep=";")




### TIME ###

shapiro.test(na.omit(dataG1$Q1.TIME.LIMIT)) # 0.06766
shapiro.test(na.omit(dataG2$Q1.TIME.LIMIT)) # non-normal

shapiro.test(na.omit(dataG1$Q2.TIME.LIMIT)) # non-normal
shapiro.test(na.omit(dataG2$Q2.TIME.LIMIT)) # non-normal

shapiro.test(na.omit(dataG1$Q3.TIME.LIMIT)) # non-normal
shapiro.test(na.omit(dataG2$Q3.TIME.LIMIT)) # non-normal

mean(dataG1$Q1.1.TIME, na.rm=TRUE) # 1017.533
mean(dataG2$Q1.1.TIME, na.rm=TRUE) # 1225.167
mean(dataG1$Q1.2.TIME, na.rm=TRUE) # 775.75
mean(dataG2$Q1.2.TIME, na.rm=TRUE) # 967.7333
mean(dataG1$Q1.TIME.LIMIT, na.rm=TRUE) # 1636.118
mean(dataG2$Q1.TIME.LIMIT, na.rm=TRUE) # 1918.333
mean(dataG1$Q2.TIME.LIMIT, na.rm=TRUE) # 804.5909
mean(dataG2$Q2.TIME.LIMIT, na.rm=TRUE) # 1108.636
mean(dataG1$Q3.1.TIME, na.rm=TRUE) # 2318.381
mean(dataG2$Q3.1.TIME, na.rm=TRUE) # 1158.048
mean(dataG1$Q3.2.TIME, na.rm=TRUE) # 628.8
mean(dataG2$Q3.2.TIME, na.rm=TRUE) # 2063.462
mean(dataG1$Q3.TIME.LIMIT, na.rm=TRUE) # 2259.095
mean(dataG2$Q3.TIME.LIMIT, na.rm=TRUE) # 2302.429

# total
timeG1Tot <- dataG1$Q1.TIME.LIMIT+dataG1$Q2.TIME.LIMIT+dataG1$Q3.TIME.LIMIT;
timeG2Tot <- dataG2$Q1.TIME.LIMIT+dataG2$Q2.TIME.LIMIT+dataG2$Q3.TIME.LIMIT;
mean(timeG1Tot, na.rm=TRUE) # 4656.529
mean(timeG2Tot, na.rm=TRUE) # 5317.294

# undo
timeG1UNDO <- dataG1$Q1.2.TIME+dataG1$Q3.2.TIME;
timeG2UNDO <- dataG2$Q1.2.TIME+dataG2$Q3.2.TIME;
mean(timeG1UNDO, na.rm=TRUE) # 1579.8
mean(timeG2UNDO, na.rm=TRUE) # 2886.5

# UI

timeG1UI <- dataG1$Q1.1.TIME+dataG1$Q2.TIME+dataG1$Q3.1.TIME
timeG2UI <- dataG2$Q1.1.TIME+dataG2$Q2.TIME+dataG2$Q3.1.TIME
mean(timeG1UI, na.rm=TRUE) # 4098.467
mean(timeG2UI, na.rm=TRUE) # 3496.647



VD.A(na.omit(dataG1$Q1.1.TIME), na.omit(dataG2$Q1.1.TIME)) # 0.4185185 (small)
VD.A(na.omit(dataG1$Q1.2.TIME), na.omit(dataG2$Q1.2.TIME)) # 0.3875 (small)
VD.A(na.omit(dataG1$Q1.TIME.LIMIT), na.omit(dataG2$Q1.TIME.LIMIT)) # 0.3039216 (medium)
VD.A(na.omit(dataG1$Q2.TIME.LIMIT), na.omit(dataG2$Q2.TIME.LIMIT)) #  0.1921488 (large)
VD.A(na.omit(dataG1$Q3.1.TIME), na.omit(dataG2$Q3.1.TIME)) # 0.8231293 (large)
VD.A(na.omit(dataG1$Q3.2.TIME), na.omit(dataG2$Q3.2.TIME)) # 0 (large)
VD.A(na.omit(dataG1$Q3.TIME.LIMIT), na.omit(dataG2$Q3.TIME.LIMIT)) # 0.5600907 (negligible)
# total
VD.A(na.omit(timeG1Tot), na.omit(timeG2Tot)) # 0.150519 (large)

# undo/redo
VD.A(dataG1$Q1.2.TIME+dataG1$Q3.2.TIME, dataG2$Q1.2.TIME+dataG2$Q3.2.TIME) # 0.2913223 (medium)

# UI
VD.A(dataG1$Q1.1.TIME+dataG1$Q2.TIME+dataG1$Q3.1.TIME, 
            dataG2$Q1.1.TIME+dataG2$Q2.TIME+dataG2$Q3.1.TIME) # 0.6012397 (small)



wilcox.test(dataG1$Q1.1.TIME, dataG2$Q1.1.TIME) # 0.4421
wilcox.test(dataG1$Q1.2.TIME, dataG2$Q1.2.TIME) # 0.2995
wilcox.test(dataG1$Q1.TIME.LIMIT, dataG2$Q1.TIME.LIMIT) # 0.04503
wilcox.test(dataG1$Q2.TIME.LIMIT, dataG2$Q2.TIME.LIMIT) # 0.0003298
wilcox.test(dataG1$Q3.1.TIME, dataG2$Q3.1.TIME) # 0.0001943
wilcox.test(dataG1$Q3.2.TIME, dataG2$Q3.2.TIME) # 0.0016
wilcox.test(dataG1$Q3.TIME.LIMIT, dataG2$Q3.TIME.LIMIT) # 0.4845
# total
wilcox.test(dataG1$Q1.TIME.LIMIT+dataG1$Q2.TIME.LIMIT+dataG1$Q3.TIME.LIMIT, 
            dataG2$Q1.TIME.LIMIT+dataG2$Q2.TIME.LIMIT+dataG2$Q3.TIME.LIMIT) # 0.0005365

# undo/redo
wilcox.test(dataG1$Q1.2.TIME+dataG1$Q3.2.TIME, dataG2$Q1.2.TIME+dataG2$Q3.2.TIME) # 0.02953

# UI
wilcox.test(dataG1$Q1.1.TIME+dataG1$Q2.TIME+dataG1$Q3.1.TIME, 
            dataG2$Q1.1.TIME+dataG2$Q2.TIME+dataG2$Q3.1.TIME) # 0.097




### CORR ###

T1succG1 <- (unname(table(dataG1$test3clickUI)[names(table(dataG1$test3clickUI)) == 1])
  + unname(table(dataG1$test3clickdata)[names(table(dataG1$test3clickdata)) == 1])
  + unname(table(dataG1$test3clickundo)[names(table(dataG1$test3clickundo)) == 1])
  + unname(table(dataG1$test3clickredo)[names(table(dataG1$test3clickredo)) == 1]))
T1succG2 <- (unname(table(dataG2$test3clickUI)[names(table(dataG2$test3clickUI)) == 1])
  + unname(table(dataG2$test3clickdata)[names(table(dataG2$test3clickdata)) == 1])
  + unname(table(dataG2$test3clickundo)[names(table(dataG2$test3clickundo)) == 1])
  + unname(table(dataG2$test3clickredo)[names(table(dataG2$test3clickredo)) == 1]))
T1failG1 <- (unname(table(dataG1$test3clickUI)[names(table(dataG1$test3clickUI)) == 0])
             + unname(table(dataG1$test3clickdata)[names(table(dataG1$test3clickdata)) == 0])
             + unname(table(dataG1$test3clickundo)[names(table(dataG1$test3clickundo)) == 0])
             + unname(table(dataG1$test3clickredo)[names(table(dataG1$test3clickredo)) == 0]))
T1failG2 <- (unname(table(dataG2$test3clickUI)[names(table(dataG2$test3clickUI)) == 0])
             + unname(table(dataG2$test3clickdata)[names(table(dataG2$test3clickdata)) == 0])
             + unname(table(dataG2$test3clickundo)[names(table(dataG2$test3clickundo)) == 0])
             + unname(table(dataG2$test3clickredo)[names(table(dataG2$test3clickredo)) == 0]))


T1CORR <- matrix(c(T1succG1,T1failG1,T1succG2,T1failG2), ncol=2)
fisher.test(T1CORR) # p: 0.07579, or: 1.955466


T2succG1 <- (unname(table(dataG1$testWriteUI1s)[names(table(dataG1$testWriteUI1s)) == 1])
             + unname(table(dataG1$testWriteData)[names(table(dataG1$testWriteData)) == 1]))
T2succG2 <- (unname(table(dataG2$testWriteUI1s)[names(table(dataG2$testWriteUI1s)) == 1])
             + unname(table(dataG2$testWriteData)[names(table(dataG2$testWriteData)) == 1]))
T2failG1 <- (unname(table(dataG1$testWriteUI1s)[names(table(dataG1$testWriteUI1s)) == 0])
             + unname(table(dataG1$testWriteData)[names(table(dataG1$testWriteData)) == 0]))
T2failG2 <- (unname(table(dataG2$testWriteUI1s)[names(table(dataG2$testWriteUI1s)) == 0])
             + unname(table(dataG2$testWriteData)[names(table(dataG2$testWriteData)) == 0]))

T2CORR <- matrix(c(T2succG1,T2failG1,T2succG2,T2failG2), ncol=2)


T3succG1 <- (unname(table(dataG1$testDnDDeltaMoveUI)[names(table(dataG1$testDnDDeltaMoveUI)) == 1])
             + unname(table(dataG1$testDnDDeltaMoveData)[names(table(dataG1$testDnDDeltaMoveData)) == 1])
             + unname(table(dataG1$testDnDUndo)[names(table(dataG1$testDnDUndo)) == 1])
             + unname(table(dataG1$testDnDRedo)[names(table(dataG1$testDnDRedo)) == 1]))
T3succG2 <- (unname(table(dataG2$testDnDDeltaMoveUI)[names(table(dataG2$testDnDDeltaMoveUI)) == 1])
             + unname(table(dataG2$testDnDDeltaMoveData)[names(table(dataG2$testDnDDeltaMoveData)) == 1])
             + unname(table(dataG2$testDnDUndo)[names(table(dataG2$testDnDUndo)) == 1])
             + unname(table(dataG2$testDnDRedo)[names(table(dataG2$testDnDRedo)) == 1]))
T3failG1 <- (unname(table(dataG1$testDnDDeltaMoveUI)[names(table(dataG1$testDnDDeltaMoveUI)) == 0])
             + unname(table(dataG1$testDnDDeltaMoveData)[names(table(dataG1$testDnDDeltaMoveData)) == 0])
             + unname(table(dataG1$testDnDUndo)[names(table(dataG1$testDnDUndo)) == 0])
             + unname(table(dataG1$testDnDRedo)[names(table(dataG1$testDnDRedo)) == 0]))
T3failG2 <- (unname(table(dataG2$testDnDDeltaMoveUI)[names(table(dataG2$testDnDDeltaMoveUI)) == 0])
             + unname(table(dataG2$testDnDDeltaMoveData)[names(table(dataG2$testDnDDeltaMoveData)) == 0])
             + unname(table(dataG2$testDnDUndo)[names(table(dataG2$testDnDUndo)) == 0])
             + unname(table(dataG2$testDnDRedo)[names(table(dataG2$testDnDRedo)) == 0]))

T3CORR <- matrix(c(T3succG1,T3failG1,T3succG2,T3failG2), ncol=2)
fisher.test(T3CORR) # p: 0.206, or: 0.6072973

# total

TTCORR <- T1CORR+T2CORR+T3CORR
fisher.test(TTCORR) # p: 0.09333, or: 1.432845 

# undo/redo

TUndosuccG1 <- (unname(table(dataG1$test3clickundo)[names(table(dataG1$test3clickundo)) == 1])
             + unname(table(dataG1$testDnDUndo)[names(table(dataG1$testDnDUndo)) == 1])
             + unname(table(dataG1$test3clickredo)[names(table(dataG1$test3clickredo)) == 1])
             + unname(table(dataG1$testDnDRedo)[names(table(dataG1$testDnDRedo)) == 1]))
TUndosuccG2 <- (unname(table(dataG2$test3clickundo)[names(table(dataG2$test3clickundo)) == 1])
             + unname(table(dataG2$testDnDUndo)[names(table(dataG2$testDnDUndo)) == 1])
             + unname(table(dataG2$test3clickredo)[names(table(dataG2$test3clickredo)) == 1])
             + unname(table(dataG2$testDnDRedo)[names(table(dataG2$testDnDRedo)) == 1]))
TUndofailG1 <- (unname(table(dataG1$test3clickundo)[names(table(dataG1$test3clickundo)) == 0])
             + unname(table(dataG1$testDnDUndo)[names(table(dataG1$testDnDUndo)) == 0])
             + unname(table(dataG1$test3clickredo)[names(table(dataG1$test3clickredo)) == 0])
             + unname(table(dataG1$testDnDRedo)[names(table(dataG1$testDnDRedo)) == 0]))
TUndofailG2 <- (unname(table(dataG2$test3clickundo)[names(table(dataG2$test3clickundo)) == 0])
             + unname(table(dataG2$testDnDUndo)[names(table(dataG2$testDnDUndo)) == 0])
             + unname(table(dataG2$test3clickredo)[names(table(dataG2$test3clickredo)) == 0])
             + unname(table(dataG2$testDnDRedo)[names(table(dataG2$testDnDRedo)) == 0]))

TundoCORR <- matrix(c(TUndosuccG1,TUndofailG1,TUndosuccG2,TUndofailG2), ncol=2)
fisher.test(TundoCORR) # p: 0.003958, or: 3.301469 


# UI

TUIsuccG1 <- (unname(table(dataG1$test3clickUI)[names(table(dataG1$test3clickUI)) == 1])
                + unname(table(dataG1$test3clickdata)[names(table(dataG1$test3clickdata)) == 1])
                + unname(table(dataG1$testWriteUI1s)[names(table(dataG1$testWriteUI1s)) == 1])
                + unname(table(dataG1$testWriteData)[names(table(dataG1$testWriteData)) == 1])
                + unname(table(dataG1$testDnDDeltaMoveUI)[names(table(dataG1$testDnDDeltaMoveUI)) == 1])
                + unname(table(dataG1$testDnDDeltaMoveData)[names(table(dataG1$testDnDDeltaMoveData)) == 1]))

TUIsuccG2 <- (unname(table(dataG2$test3clickUI)[names(table(dataG2$test3clickUI)) == 1])
              + unname(table(dataG2$test3clickdata)[names(table(dataG2$test3clickdata)) == 1])
              + unname(table(dataG2$testWriteUI1s)[names(table(dataG2$testWriteUI1s)) == 1])
              + unname(table(dataG2$testWriteData)[names(table(dataG2$testWriteData)) == 1])
              + unname(table(dataG2$testDnDDeltaMoveUI)[names(table(dataG2$testDnDDeltaMoveUI)) == 1])
              + unname(table(dataG2$testDnDDeltaMoveData)[names(table(dataG2$testDnDDeltaMoveData)) == 1]))

TUIfailG1 <- (unname(table(dataG1$test3clickUI)[names(table(dataG1$test3clickUI)) == 0])
              + unname(table(dataG1$test3clickdata)[names(table(dataG1$test3clickdata)) == 0])
              + unname(table(dataG1$testWriteUI1s)[names(table(dataG1$testWriteUI1s)) == 0])
              + unname(table(dataG1$testWriteData)[names(table(dataG1$testWriteData)) == 0])
              + unname(table(dataG1$testDnDDeltaMoveUI)[names(table(dataG1$testDnDDeltaMoveUI)) == 0])
              + unname(table(dataG1$testDnDDeltaMoveData)[names(table(dataG1$testDnDDeltaMoveData)) == 0]))

TUIfailG2 <- (unname(table(dataG2$test3clickUI)[names(table(dataG2$test3clickUI)) == 0])
              + unname(table(dataG2$test3clickdata)[names(table(dataG2$test3clickdata)) == 0])
              + unname(table(dataG2$testWriteUI1s)[names(table(dataG2$testWriteUI1s)) == 0])
              + unname(table(dataG2$testWriteData)[names(table(dataG2$testWriteData)) == 0])
              + unname(table(dataG2$testDnDDeltaMoveUI)[names(table(dataG2$testDnDDeltaMoveUI)) == 0])
              + unname(table(dataG2$testDnDDeltaMoveData)[names(table(dataG2$testDnDDeltaMoveData)) == 0]))

TUICORR <- matrix(c(TUIsuccG1,TUIfailG1,TUIsuccG2,TUIfailG2), ncol=2)
fisher.test(TUICORR) # p: 0.8978 , or: 0.9362946 



### LEVEL ###

shapiro.test(na.omit(dataG1$Q1.1.LVL)) # non normal
shapiro.test(na.omit(dataG2$Q1.1.LVL)) # non normal
shapiro.test(na.omit(dataG1$Q1.2.LVL)) # normal
shapiro.test(na.omit(dataG2$Q1.2.LVL)) # non normal
shapiro.test(na.omit(dataG1$Q2.LVL)) # non normal
shapiro.test(na.omit(dataG2$Q2.LVL)) # non normal
shapiro.test(na.omit(dataG1$Q3.1.LVL)) # normal
shapiro.test(na.omit(dataG2$Q3.1.LVL)) # non normal
shapiro.test(na.omit(dataG1$Q3.2.LVL)) # normal
shapiro.test(na.omit(dataG2$Q3.2.LVL)) # normal

boxplot(dataG1$Q1.1.LVL, dataG2$Q1.1.LVL)

mean(dataG1$Q1.1.LVL, na.rm=TRUE) # 3.272727
mean(dataG2$Q1.1.LVL, na.rm=TRUE) # 3.909091
mean(dataG1$Q1.2.LVL, na.rm=TRUE) # 4.666667
mean(dataG2$Q1.2.LVL, na.rm=TRUE) # 4.789474
mean(dataG1$Q2.LVL, na.rm=TRUE) # 4.136364
mean(dataG2$Q2.LVL, na.rm=TRUE) # 5.761905
mean(dataG1$Q3.1.LVL, na.rm=TRUE) # 7.25
mean(dataG2$Q3.1.LVL, na.rm=TRUE) # 4.136364
mean(dataG1$Q3.2.LVL, na.rm=TRUE) # 6.4
mean(dataG2$Q3.2.LVL, na.rm=TRUE) # 7.533333


wilcox.test(na.omit(dataG1$Q1.1.LVL), na.omit(dataG2$Q1.1.LVL)) # 0.5111
wilcox.test(na.omit(dataG1$Q1.2.LVL), na.omit(dataG2$Q1.2.LVL)) # 0.5431
wilcox.test(na.omit(dataG1$Q2.LVL), na.omit(dataG2$Q2.LVL)) # 0.0355
wilcox.test(na.omit(dataG1$Q3.1.LVL), na.omit(dataG2$Q3.1.LVL)) # 0.006377
wilcox.test(na.omit(dataG1$Q3.2.LVL), na.omit(dataG2$Q3.2.LVL)) #  0.1837

VD.A(na.omit(dataG1$Q1.1.LVL), na.omit(dataG2$Q1.1.LVL)) # 0.4421488 (negligible)
VD.A(na.omit(dataG1$Q1.2.LVL), na.omit(dataG2$Q1.2.LVL)) # 0.4415205 (negligible)
VD.A(na.omit(dataG1$Q2.LVL), na.omit(dataG2$Q2.LVL)) # 0.3138528 (medium)
VD.A(na.omit(dataG1$Q3.1.LVL), na.omit(dataG2$Q3.1.LVL)) # 0.7420455 (large)
VD.A(na.omit(dataG1$Q3.2.LVL), na.omit(dataG2$Q3.2.LVL)) # 0.2933333 (medium)


