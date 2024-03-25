# iniziamo a lavorare con spectral indexes 

# per prima cosa dobbiamo richiamare i pacchetti che ci servono: 
library(imageRy)
library(terra) 

# andiamo a cercare l'immagine che ci serve, richiamo la lista 
im.list()

# oggi usiamo immagini di Mato Grosso 1992 e poi 2006, dobbiamo importarle 
m1922 <- im.import("matogrosso_l5_1992219_lrg.jpg")

# immagine è creata facendo plot RGB, ha già le bande suddivise in questo modo: 
# band 1 = nir = R 
# band 2 = red = G
# band 3 = green = B 
# andiamo a ricreare il plot: 
im.plotRGB(m1992, 1,2,3 )

# exercise: put the nir ontop of the G component 
im.plotRGB(m1992, 2,1,3 ) # in questo caso il nir (che rappresenta la vegetazione) è di colore verde, si vede un poco di impatto umano cioè un poco di suolo nudo

# per evidenziare il suolo nudo lo si fa diventare giallo (occhio umano lo vede meglio), cambiando il nir in blu 
im.plotRGB(m1992, 2,3,1 )

# ora importiamo anche l'altra immagine, quella del 2006. notare come nel nome ci sia il riferimento al satellite (in questo caso ast, nel caso precedente l5). 
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg") # si vede bene come l'uomo abbia impattato, vegetazione molto ridotta 

# riplotto mettendo il nir nelle diverse lunghezze: 
im.plotRGB(m2006, 2,1,3 ) # nir in verde
im.plotRGB(m2006, 2,3,1 ) # nir in blu 

# ora facciamo un mega multiframe con tutte le immagini, vogliamo sulla prima riga il 92 e sulla seconda il 2006, per poterli visualizzare tutti assieme e fare risaltare l'impatto antropico
par(mfrow= c(2,3))
im.plotRGB(m1992, 1,2,3 ) # nir in rosso 1992 (come di default)
im.plotRGB(m1992, 2,1,3 ) # nir in verde 1992 
im.plotRGB(m1992, 2,3,1 ) # nir in blu 1992
im.plotRGB(m2006, 1,2,3 ) # nir in rosso 2006 (come di default)
im.plotRGB(m2006, 2,1,3 ) # nir in verde 2006 
im.plotRGB(m2006, 2,3,1 ) # nir in blu 2006 

# ora vogliamo avere un indice che possa quantitativamente dire la differenza, non solo "ad occhio", qualitativamente. 
# considerazioni sui bit
# 



dev.off() # sempre utile fare un po' di pulizia!








