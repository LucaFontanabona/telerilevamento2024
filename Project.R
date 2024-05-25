library(imageRy)  # ogni volta che riparto con R devo dirgli di leggere i pacchetti che mi servono
library(terra)

# Posso usare una funzione del pacchetto "terra" per richiamare tutte le immagini disponibili (DOVE PERò???)
im.list()

# Per invece andare ad importare l'immagine devo usare im.import("") andando a 
# mettere il nome dell'immagine tra ""
b2 <- im.import("sentinel.dolomites.b2.tif") 

# Posso anche cambiare la scala di colori dell'imagine, inserisco nella funzone 
# colorRampPalette() un vettore con i nomi dei colori. devo ricordarmi di 
# mettere all'esterno della funzione anche il numero di sfuature che voglio
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(b2, col=cl)  # ora però per mostrare l'immagine devo plottarla e dirgli di prendere quei colori che ho appena scelto 

# Carico anche le immagini di altre bande di colore oltre al blu (quindi verde, 
# rosso e infrarosso). 
b3 <- im.import("sentinel.dolomites.b3.tif")  # verde
plot(b3, col=cl)

b4 <- im.import("sentinel.dolomites.b4.tif")  # rosso
plot(b4, col=cl)

b8 <- im.import("sentinel.dolomites.b8.tif")  # infrarosso
plot(b8, col=cl)

# Posso ora creare un multiframe per aprire (e quindi visualuzzare) tutte le 
# immagino contemporaneamente. devo dirli come disporre le immagini sullo 
# schermo, in questo caso per esempio creo uno spazio di 2 x 2 
par(mfrow=c(2,2))  #dopo aver creato lo spazion mando in sequenza i comandi per inserire i grafici
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

# Posso reare un'immagine fatta di può layer sovrapposti e visualuzzarli 
# singolarmente,  
stacksent <- c(b2, b3, b4, b8)
dev.off() # funzione che mi permette di chiudere quello che sto visualuzzando
plot(stacksent, col=cl)

# Posso chiedere di visualuzzare una sola delle diverse bande ci colore, devo 
# metterci il doppio [] per indicar che prendo sia le righe ma anche tutte le 
# colonne 
plot(stacksent[[4]], col=cl)







# Exercise: plot in a multiframe the bands with different color ramps
par(mfrow=c(2,2))

clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(b2, col=clb)

clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(b3, col=clg)

clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(b4, col=clr)

cln <- colorRampPalette(c("brown", "orange", "yellow")) (100)
plot(b8, col=cln)

# RGB space
# stacksent: 
# band2 blue element 1, stacksent[[1]] 
# band3 green element 2, stacksent[[2]]
# band4 red element 3, stacksent[[3]]
# band8 nir element 4, stacksent[[4]]
im.plotRGB(stacksent, r=3, g=2, b=1)
im.plotRGB(stacksent, r=4, g=3, b=2)
im.plotRGB(stacksent, r=3, g=4, b=2)
im.plotRGB(stacksent, r=3, g=2, b=4)


pairs(stacksent)



















