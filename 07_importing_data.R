# Impariamo ad importare i dati dall'esterno

# Usiamo le librerie che usiamo di solito 
library(terra)
library(imageRy)

#Usiamo una funzione: gli diciamo qual è la cartella da cui prendere le cose: set working directory. 
setwd("C:/Users/lucaf/OneDrive/Desktop/UNI/SCIENZE E GESTIONE DELLA NATURA/Primo anno/telerilevamento") #l'argomento è il percorso della cartella

# Quello che faccio è importarla, devo essere sicuro quale sia l'estensione dell'immagine e scriverlo. 
eclissi <- rast("eclissi.png") #argomenot è il nome dell'imaggine con estensione

# richiamo eclissi, mi mostra le caratteristiche 
eclissi

# la vado a plottare con i colori originali
im.plotRGB(eclissi,1,2,3)

#la potrei anche usare con bande diverse 
im.plotRGB(eclissi, 3,2,1)
im.plotRGB(eclissi, 2,3,1)

# ora posso lavorarci, per es posso fare la differenza tra due bande 
dif=eclissi[[1]] - eclissi[[2]]
dif

#provo ad importare un'altra immagine 
immtemp <- rast("immtemp.png")
im.plotRGB(immtemp, 1,2,3)
plot(immtemp)


# ora andiamo ad importare i dati da copernicus, faccio proprio come abbiamo appena fatto (devo prima salvare l'immagine sul computer nella working directory) 
soil<- rast("c_gls_SSM1km_202404210000_CEURO_S1CSAR_V1.2.1.nc")
plot(soil)

# posso anche fare una parte dell'immagine, creo l'estensione del ritaglio, gli dico quale x e y metterre.
ext <- c(25,30,55,58) #i numeri che metto sono la x minima e x massima e la y minima e massima 

# ora creo un crop (ritaglio) di quello che mi interessa, devo usare le coordinate che ho creato prima 
soilcrop <- crop(soil,ext)

#lo plotto
plot(soilcrop)
plot(soilcrop[[1]]) #per dire solo il dato senza l'errore
