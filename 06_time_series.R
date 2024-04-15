# Ora dobbiamo fare la sottrazione tra immagini, sempre per quantificare il cambiamento (nel tempo)
# lavoriamo con nuove immagini, siamo stufi del mato grosso.
# richiamiamo le librerie
library(terra)
library(imageRy)

# guardo che dati ho a disposizione
im.list()

# importiamo i dati (EN01 ed EN02)
en01 <- im.import("EN_01.png") #sono mappe che non hanno infrarosso o altre cose strane, hanno i soliti 3 livelli. Descrivono il livello di inquinanti in diversei periodi del 2020. Quello che vado a fare è confrontare i diversi livelli (quindi la stessa banda di una immagine con la stessa banda dell'altra immagine). 
en13 <- im.import("EN_13.png")

dev.off() #sempre utile fare un po' di pulizia 

par(mfrow=c(2,1)) #preferisco metterle una sopra all'altra che una vicino all'altra, si vede meglio
im.plotRGB.auto(en01) #usiamo questa funzione per fare il plot, ha RGB già incorporato, plottiamo le due immagini 
im.plotRGB.auto(en13)

#facciamo la differenza della prima banda 
difen = en01[[1]] - en13[[1]]

# plottiamo la differenza che abbiamo ottenuto prima
cl <- colorRampPalette(c("blue", "white", "red")) (100) #creiamo una colorRampPalette, mettiamo il rosso come massimo considerando che sta ad indicare una temperatura più alta
plot(difen, col=cl)
#otteniamo una quantificazione della differenza. Abbiamo iniziato a lavorare con un'immagine a 8 bit quindi con range da 0 a 255. 


dev.off() #sempre utile fare un po' di pulizia 


#ora applichiamo ai ghiacci della Groenlandia, non direttamente sul ghiaccio ma usiamo un proxy (non direttamente la misura del ghiaccio ma un'altra variabile che lo rappresenta): la temperatura della superficie (del suolo, non nell'aria)
#con copernicus abbiamo dati globali e non solo locali. i dati ci sono già, greenland 
g2000 <- im.import("greenland.2000.tif") #è un'immagine a 16 bit (quindi 65k valori possibili), noi vediamo però qualcosa come 16k valori, è dovuto ad una riduzione dell'immagine (utile perchè alleggerisce). 
clg <- colorRampPalette(c("black" , "blue", "white", "red")) (100) # simile a prima, solo che aggiungiamo il nero
plot(g2000, col=clg) #in questo caso il nero rappresenta la temperatura minore, il rosso la temperatura maggiore

#importiamo anche le altre immagini
g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")

#facciamo un multiframe con le immagini dal 2000 al 2015 
dev.off() #sempre utile fare un po' di pulizia 
par(mfrow=c(2,2))
plot(g2000, col=clg)
plot(g2005, col=clg)
plot(g2010, col=clg)
plot(g2015, col=clg)

# posso anche creare uno stack con tutto assieme dentro 
dev.off() #sempre utile fare un po' di pulizia 
greenland <- c(g2000, g2005, g2010, g2015)
plot(greenland, col=cl) #usiamo i colori di prima senza il nero

# ora posso fare la differenza usando lo stack 
dev.off() #sempre utile fare un po' di pulizia 
difg = greenland[[1]] - greenland[[4]] 
plot(difg, col=cl) #quello che ho fatto è togliere dal 2000 il 2015. Dove è blu ho temperaturea più bassa 

#voglio però avere la colorRampPalette invertita per avere il rosso come colore che rappresenta il livello di aumento della temperatura
dev.off() #sempre utile fare un po' di pulizia 
clgreen <- colorRampPalette(c("red", "white", "blue")) (100)
plot(difg, col=clgreen)


# potrei anche dare a tre livelli di una mappona le diverse annate di campionamento. 
im.plotRGB(greenland, 1,2,4) #creo mappa e gli dico di mettere nel rosso il 2000, nel verde il 2005 e nel blu il 2015, dove ho prevalenza di verde vuol dire che quell'anno ho temperature maggiori e uguale per blu. Nel nostro caso non si vede molto bene, dobbiamo considerare che non ci sono grandi differenze in temperatura (che quindi non si rispecchiano in grandi differenze in colore). 
