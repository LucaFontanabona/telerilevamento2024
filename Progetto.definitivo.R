# Progetto esame 

# Analisi vegetazione nrll'area del delta del Volga 

# Prepariamo i pacchetti che ci servono 

library(imageRy) 
library(terra)
# install.packages("ggplot2") in questo caso era da installare la prima volta ma non serve farlo tutte le altre
library(ggplot2)
# install.packages("viridis") # per avere colori che siano adatti anche a persone con daltonia  
library(viridis)
library(fields) # ci serve alla fine per rappresentare immagini 

# Preparo una colorRampPalette che sia sempre quella per la maggior parte del progetto
cl <- colorRampPalette(inferno(7)) (256)  #scelgo inferno perchè sembra essere il migliore per rendere le differenze nelle immagini

# Importo le immagini scaricate sul computer
# Imposto da working directory come la cartella che contiene le immagini 
setwd("C:/Users/lucaf/OneDrive/Desktop/UNI/SCIENZE E GESTIONE DELLA NATURA/Primo anno/telerilevamento/progetto esame")

# Verifico che sia andato tutto bene 
getwd()

# Importo immagini dall'esterno, uso funzione rast().
# Il nome che assegno contiene la data in cui è stata scattata l'immagine
astr_08_03_2019 <- rast("2019-03-08-23_59_Sentinel-2_L2A_False_color.jpg")
astr_29_05_2019 <- rast("2019-05-29-23_59_Sentinel-2_L2A_False_color.jpg")
astr_28_06_2019 <- rast("2019-06-28-23_59_Sentinel-2_L2A_False_color.jpg")
astr_22_08_2019 <- rast("2019-08-22-23_59_Sentinel-2_L2A_False_color.jpg")
astr_01_04_2021 <- rast("2021-04-01-23_59_Sentinel-2_L2A_False_color.jpg")
astr_21_05_2021 <- rast("2021-05-21-23_59_Sentinel-2_L2A_False_color.jpg")
astr_20_06_2021 <- rast("2021-06-20-23_59_Sentinel-2_L2A_False_color.jpg")
astr_26_08_2021 <- rast("2021-08-26-23_59_Sentinel-2_L2A_False_color.jpg")
astr_19_03_2023 <- rast("2023-03-19-23_59_Sentinel-2_L2A_False_color.jpg")
astr_18_05_2023 <- rast("2023-05-18-23_59_Sentinel-2_L2A_False_color.jpg")
astr_20_06_2023 <- rast("2023-06-20-23_59_Sentinel-2_L2A_False_color.jpg")
astr_21_08_2023 <- rast("2023-08-21-23_59_Sentinel-2_L2A_False_color.jpg")
# Sono tutte immagini in false color, quindi con il nir rappresentate come rosso, il rosso come verde e il verde come blu

# Visualizziamo assieme tutte le immagini, teniamo su ogni riga un anno 
par(mfrow=c(3,4))
im.plotRGB(astr_08_03_2019, 1,2,3) #COLORI SEMBRANO NON REALI, COME MAI?? 
im.plotRGB(astr_29_05_2019, 1,2,3)
im.plotRGB(astr_28_06_2019, 1,2,3)
im.plotRGB(astr_22_08_2019, 1,2,3)
im.plotRGB(astr_01_04_2021, 1,2,3)
im.plotRGB(astr_21_05_2021, 1,2,3)
im.plotRGB(astr_20_06_2021, 1,2,3)
im.plotRGB(astr_26_08_2021, 1,2,3)
im.plotRGB(astr_19_03_2023, 1,2,3)
im.plotRGB(astr_18_05_2023, 1,2,3)
im.plotRGB(astr_20_06_2023, 1,2,3)
im.plotRGB(astr_21_08_2023, 1,2,3)

dev.off() #sempre utile fare un po' di pulizia 

# Rappresentiamo anche solo il nir per vedere meglio la vegetazione
par(mfrow=c(3,4))
plot(astr_21_05_2021[[1]], col=cl) # il nir è rappresentato nella prima banda dell'immagine
plot(astr_29_05_2019[[1]], col=cl)
plot(astr_28_06_2019[[1]], col=cl)
plot(astr_22_08_2019[[1]], col=cl)
plot(astr_01_04_2021[[1]], col=cl)
plot(astr_21_05_2021[[1]], col=cl)
plot(astr_20_06_2021[[1]], col=cl)
plot(astr_26_08_2021[[1]], col=cl)
plot(astr_19_03_2023[[1]], col=cl)
plot(astr_18_05_2023[[1]], col=cl)
plot(astr_20_06_2023[[1]], col=cl)
plot(astr_21_08_2023[[1]], col=cl)

dev.off() # Sempre utile fare un po' di pulizia


# Calcoliamo NDVI per vedere in quali zone e soprattutto in quale momento la vegeazione è al suo massimo 

ndviastr_08_03_2019 <- im.ndvi(astr_08_03_2019, 1,2)
ndviastr_29_05_2019 <- im.ndvi(astr_29_05_2019, 1,2)
ndviastr_28_06_2019 <- im.ndvi(astr_28_06_2019, 1,2)
ndviastr_22_08_2019 <- im.ndvi(astr_22_08_2019, 1,2)
ndviastr_01_04_2021 <- im.ndvi(astr_01_04_2021, 1,2)
ndviastr_21_05_2021 <- im.ndvi(astr_21_05_2021, 1,2)
ndviastr_20_06_2021 <- im.ndvi(astr_20_06_2021, 1,2)
ndviastr_26_08_2021 <- im.ndvi(astr_26_08_2021, 1,2)
ndviastr_19_03_2023 <- im.ndvi(astr_19_03_2023, 1,2)
ndviastr_18_05_2023 <- im.ndvi(astr_18_05_2023, 1,2)
ndviastr_20_06_2023 <- im.ndvi(astr_20_06_2023, 1,2)
ndviastr_21_08_2023 <- im.ndvi(astr_21_08_2023, 1,2)

# Plottiamo tutto sempre mettendo le immagini come prima, quindi ogni anno so una riga 
par(mfrow=c(3,4))
plot(ndviastr_08_03_2019, col=cl)
plot(ndviastr_29_05_2019, col=cl)
plot(ndviastr_28_06_2019, col=cl)
plot(ndviastr_22_08_2019, col=cl)
plot(ndviastr_01_04_2021, col=cl)
plot(ndviastr_21_05_2021, col=cl)
plot(ndviastr_20_06_2021, col=cl)
plot(ndviastr_26_08_2021, col=cl)
plot(ndviastr_19_03_2023, col=cl)
plot(ndviastr_18_05_2023, col=cl)
plot(ndviastr_20_06_2023, col=cl)
plot(ndviastr_21_08_2023, col=cl)


dev.off() #sempre utile fare un po' di pulizia



# Per vedere quando c'è maggiore vegetazione faccio la differenza tra le immagini di giugno e agosto e giugno e maggio visto che si vede 
# già che sono quelle con i valori di NDVI più alti (escludo praticamente marzo). 
# Le differenze sono fatte sul NDVI e non sull'immagine pura perchè questo è una rappresentazione più significativa della vegetazione

# giugno - maggio
difndvigm2019 <- ndviastr_28_06_2019 - ndviastr_29_05_2019
difndvigm2021 <- ndviastr_20_06_2021 - ndviastr_21_05_2021
difndvigm2023 <- ndviastr_20_06_2023 - ndviastr_18_05_2023

# giugno - agosto
difndviga2019 <- ndviastr_28_06_2019 - ndviastr_22_08_2019
difndviga2021 <- ndviastr_20_06_2021 - ndviastr_26_08_2021
difndviga2023 <- ndviastr_20_06_2023 - ndviastr_21_08_2023


# Plottiamo le differenze per vedere i risultati, su una riga metto la differenza giugno - maggio, sull'altra giugno - agosto
par(mfrow=c(2,3))
plot(difndvigm2019, col=cl)
plot(difndvigm2021, col=cl)
plot(difndvigm2023, col=cl)
plot(difndviga2019, col=cl)
plot(difndviga2021, col=cl)
plot(difndviga2023, col=cl)

# Notiamo che le scale sono diverse e quindi diventa difficile confrontare visivamente le immagini. 
# Per risolvere questo problema andiamo a usare la funzione image.plot del pacchetto fields che ci permette di impostare facilmente i 
# valori degli assi. Tali valori sono impostati a -2 e 2 perchè corrispondono ai massimi valori possibili dati dalla sottrazione tra 
# immagini
par(mfrow=c(2,3))
image.plot(difndvigm2019, col=cl, zlim = c(-2,2))
image.plot(difndvigm2021, col=cl, zlim = c(-2,2))
image.plot(difndvigm2023, col=cl, zlim = c(-2,2))
image.plot(difndviga2019, col=cl, zlim = c(-2,2))
image.plot(difndviga2021, col=cl, zlim = c(-2,2))
image.plot(difndviga2023, col=cl, zlim = c(-2,2))

dev.off() # sempre utile fare un po' di pulizia



# Ora voglio vedere quando la biodiversità è maggiore, per farlo uso la deviazione standard, ma devo capire quale sia la componente più 
# informativa.
# Faccio una PCA sulle 9 immagini (di nuovo escludo marzo) e ottengo le componenti principali

# PCA per il 2019
pcaastr_29_05_2019 <- im.pca(astr_29_05_2019)
pcaastr_28_06_2019 <- im.pca(astr_28_06_2019)
pcaastr_22_08_2019 <- im.pca(astr_22_08_2019)

# PCA per il 2021
pcaastr_21_05_2021 <- im.pca(astr_21_05_2021)
pcaastr_20_06_2021 <- im.pca(astr_20_06_2021)
pcaastr_26_08_2021 <- im.pca(astr_26_08_2021)

# PCA per il 2023
pcaastr_18_05_2023 <- im.pca(astr_18_05_2023)
pcaastr_20_06_2023 <- im.pca(astr_20_06_2023)
pcaastr_21_08_2023 <- im.pca(astr_21_08_2023)


# Calcoliamo la variabilità usando la standard deviation per cercare di capire quale immagine è più variabile e quindi a quale momento 
# corrisponde una maggiore biodiversità. 
# Come argomento della funzione focal usiamo la prima componente ottenura dalla PCA appena fatta.

# per il 2019
sdastr_29_05_2019 <- focal(pcaastr_29_05_2019[[1]], matrix(1/9, 3,3), fun=sd)
sdastr_28_06_2019 <- focal(pcaastr_28_06_2019[[1]], matrix(1/9, 3,3), fun=sd) 
sdastr_22_08_2019 <- focal(pcaastr_22_08_2019[[1]], matrix(1/9, 3,3), fun=sd)

#per il 2021
sdastr_21_05_2021 <- focal(pcaastr_21_05_2021[[1]], matrix(1/9, 3,3), fun=sd)
sdastr_20_06_2021 <- focal(pcaastr_20_06_2021[[1]], matrix(1/9, 3,3), fun=sd)
sdastr_26_08_2021 <- focal(pcaastr_26_08_2021[[1]], matrix(1/9, 3,3), fun=sd)

# per il 2023
sdastr_18_05_2023 <- focal(pcaastr_18_05_2023[[1]], matrix(1/9, 3,3), fun=sd)
sdastr_20_06_2023 <- focal(pcaastr_20_06_2023[[1]], matrix(1/9, 3,3), fun=sd)
sdastr_21_08_2023 <- focal(pcaastr_21_08_2023[[1]], matrix(1/9, 3,3), fun=sd)


# creiamo una nuova scala di colori per rendere meglio le immagini che abbiamo ottenuto 
vir <- colorRampPalette(viridis(7)) (256)

# Plottiamo le immagini come abbiamo sempre fatto per avere un confronto visivo
par(mfrow=c(3,3))
plot(sdastr_29_05_2019, col=vir)
plot(sdastr_28_06_2019, col=vir)
plot(sdastr_22_08_2019, col=vir)
plot(sdastr_21_05_2021, col=vir)
plot(sdastr_20_06_2021, col=vir)
plot(sdastr_26_08_2021, col=vir)
plot(sdastr_18_05_2023, col=vir)
plot(sdastr_20_06_2023, col=vir)
plot(sdastr_21_08_2023, col=vir)
# Si nota un problema: le immagini hanno scale diverse e quindi risulta difficile confrontare visivamente i colori. 

dev.off() # sempre utile fare un po' di pulizia


# Voglio quindi avere le immagini con la stessa scala
# Dato che la funzione plot() è poco flessibile nella scala dell'asse z uso la funzione image.plot del pacchetto fields per 
# rappresentare le immagini, impostando il limite di scala manualmente

par(mfrow=c(3,3), mar = c(1,1,1,1)) # riduco i margini tra le immagini per avere una visualizzazione più ordinata

# Il limite per l'asse z è impostato usando il minimo delle immagini (0) e usando come massimo 12.5 che corrisponde ad un valore 
# leggermente superiore al massimo più alto delle immagini (il massimo più alto sarebbe stato 12.37).
# È stato anche scelto di omettere gli assi x e y dato che rappresentano solo la dimensione dell'immagine, per avere un quadro più pulito
image.plot(sdastr_29_05_2019, col=vir, axes = FALSE, zlim = c(0,12.5)) 
image.plot(sdastr_28_06_2019, col=vir, axes = FALSE, zlim = c(0,12.5))
image.plot(sdastr_22_08_2019, col=vir, axes = FALSE, zlim = c(0,12.5))
image.plot(sdastr_21_05_2021, col=vir, axes = FALSE, zlim = c(0,12.5))
image.plot(sdastr_20_06_2021, col=vir, axes = FALSE, zlim = c(0,12.5))
image.plot(sdastr_26_08_2021, col=vir, axes = FALSE, zlim = c(0,12.5))
image.plot(sdastr_18_05_2023, col=vir, axes = FALSE, zlim = c(0,12.5))
image.plot(sdastr_20_06_2023, col=vir, axes = FALSE, zlim = c(0,12.5))
image.plot(sdastr_21_08_2023, col=vir, axes = FALSE, zlim = c(0,12.5))




# Ora che abbiamo capito che giugno è il mese con la maggiore diversità e con la maggiore vegetazione facciamo un confronto diretto
# tra il 2019 e il 2023 per vedere se ci sono stati dei cambiamenti significativi e quindi se c'è stato deterioramento dell'habitat.

# Facciamo la sottrazione tra le due immagini 
difndvigiu1923 <- ndviastr_28_06_2019 - ndviastr_20_06_2023 

# La plottiamo usando i colori inferno per rendere meglio le differenze
plot(difndvigiu1923, col=cl)

dev.off() # sempre utile fare un po' di pulizia 



# Dato che la sottrazione non mostra chiaramente una tendenza negli anni facciamo la classificazione e poi il calcolo delle frequenze. 
# Lavoriamo sull'NDVI che come prima rispecchia al meglio la vegetazione 

# giugno 2019
clndviastr_28_06_2019 <- im.classify(ndviastr_28_06_2019, num_clusters = 2 )

# giugno 2023
clndviastr_20_06_2023 <- im.classify(ndviastr_20_06_2023, num_clusters = 2)


# plottiamo vicini per vedere come sono venuti 
par(mfrow=c(1,2))
plot(clndviastr_28_06_2019, col=vir)
plot(clndviastr_20_06_2023, col=vir)
# nel nostro caso hanno la prima banda come quella della vegetazione in entrambi i casi

dev.off() # sempre utile fare un po' di pulizia 


# Per completare facciamo la proporzione tra pixel di vegetazione e pixel di suolo nudo o acqua e vediamo in quale immagine abbiamo 
# valori maggiori

# Calcolo le frequenze dei due cluster
fclndviastr_28_06_2019 <- freq(clndviastr_28_06_2019)
fclndviastr_20_06_2023 <- freq(clndviastr_20_06_2023)

# Calcolo il numero totale di pixel per ogni immagine (dovrebbe essere uguale ma per sicurezza lo facciamo due volte)
totclndviastr_28_06_2019 <- ncell(clndviastr_28_06_2019)
totclndviastr_20_06_2023 <- ncell(clndviastr_20_06_2023)

# Calcolo la proporzione del numero dei pixel dei due cluster rispetto al totale 
propclndviastr_28_06_2019 <- fclndviastr_28_06_2019 / totclndviastr_28_06_2019
propclndviastr_20_06_2023 <- fclndviastr_20_06_2023 / totclndviastr_20_06_2023

# Calcolo la percentuale 
percclndviastr_28_06_2019 <- propclndviastr_28_06_2019 * 100 
percclndviastr_20_06_2023 <- propclndviastr_20_06_2023 * 100


# Ora vogliamo esportare i dati in forma carina in modo che siano visualizzabili nella presentazione 
perc <-matrix(c(percclndviastr_28_06_2019[1,3], percclndviastr_20_06_2023[1,3]), nrow = 1, ncol = 2, byrow = T)
colnames(perc) <- c("2019", "2023")
rownames(perc) <- "Vegetazione"

perc # verifichiamo che sia andato tutto a buon fine 

# esportiamo i dati in un file excel in modo da creare la tabella
write.csv2(perc, file = "tabella percentuali.csv")


# Facciamo anche un grafico sempre per mostrare i risultati 
# Trasponiamo la matrice
perct <- t(perc)

# Creiamo un dataframe per la funzione ggplot
percdf <- data.frame(perct) 

# Prepariamo i valori da mettere sull'asse x
anni <- c("2019", "2023")

# Creiamo il plot 
p19_23 <- ggplot(percdf, aes(x=anni, y=Vegetazione)) + 
            geom_bar(stat="identity",   fill="darkgreen") +
            ylim(c(0,100))

# Lo andiamo a visualizzare per verificare che tutto abbia funzionato
p19_23 

dev.off() # sempre utile fare un po' di pulizia, anche alla fine
