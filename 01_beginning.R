# First script R 

# R as calculator 
a <- 6*7 
b <- 5*8 
a+b

# Arrays (vettori) 

flowers <- c(3, 6, 8, 10, 15, 18)
flowers 

insects <- c(10, 16, 25, 42, 61, 72) 
insects 

# Creare un grafico con certe caratteristiche, ce ne sono anche molte altre
plot(insects, flowers) 

#symbol dimensions 
plot(insects, flowers, cex=2) 
plot(insects, flowers, cex=.5)

#colors
plot(insects, flowers, col="chocolate1", cex=2) 

 plot(insects, flowers, xlab="insetti", ylab="fiori", col="red", pch=8, cex=2)

