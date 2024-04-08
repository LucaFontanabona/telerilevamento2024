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

# ora vogliamo avere un indice che possa quantitativamente dire la differenza, non solo "ad occhio" qualitativamente. lo dobbiamo calcolare
# si tratta del DVI (Difference Vegetation Index) quello che facciamo è prendere ogni singolo pixel della banda del nir e gli sottrae il pixel della banda del rosso. Ottengo un valore per ogni pixel, se la risoluzione è di 8 bit ho 256 (da 0 a 255) valori possibili per ogni pixel dell'immagine. 
# i valori quindi possono variare tra 255 (massimo) a -255 (se ho rosso massimo = 255 e nir minimo =0). Capiamo quindi che indice è fortemente dipendente dalla risoluzione in entrata (se ho 4 bit ho valori da -15 a +15) 
dvi1992 = m1992[[1]] - m1992[[2]] 
# ci sarebbe anche un modo per scriverla con il nome delle bande (li devo sapere però..). Ci piace un po' meno, sarebbe: 
# dvi1992 = m1992$matogrosso~2219_lrg_1 - m1992$matogrosso~2219_lrg_2

# ora posso fare il plot di quello che abbiamo appena sviluppato
cl<-colorRampPalette (c("darkblue", "yellow", "red", "black")) (100) # gli creo una colorRampPalette 
plot(dvi1992, col=cl)

# ora faccio uguale anche per il 2006, calcolo il DVI
dvi2006 = m2006[[1]] - m2006[[2]] # in tutti i casi abbiamo messo = perchè si tratta di un'operazione, in questo caso possiamo usare = (è addiritura meglio) 

# ora plotto anche questo, uso la stessa colorRampPalette di prima
plot(dvi2006, col=cl)

# esercizio: mettere i due plot vicini
dev.off() # sempre utile fare un po' di pulizia!
par(mfrow=c(1,2))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)

# abbiamo capito che dobbiamo normalizzare per confrontare immagini di bit diversi (risolve il problema dei massimi e minimi diversi), calcoliamo NDVI 
ndvi1992 = dvi1992 / (m1992[[1]] + m1992[[2]])
ndvi2006 = dvi2006 / (m2006[[1]] + m2006[[2]])

# ora posso plottare (magari già nella stessa schermata con par())
dev.off() # sempre utile fare un po' di pulizia!
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

# posso anche fare con funzione di imagery che calcola direttamente ndvi e dvi 
ndvi2006a <- im.ndvi(m2006, 1, 2) # devo dirgli l'immagine e quali bande sono quale, lui poi fa i calcoli 
ndvi2006a
plot(ndvi2006a, col=cl)
plot(ndvi2006 - ndvi2006a) 

