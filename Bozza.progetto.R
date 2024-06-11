# Progetto esame 

# Analisi vegetazione in un'area del delta del Volga 

# Prepariamo i pacchetti che ci servono 

library(imageRy) 
library(terra)
# install.packages("ggplot2") in questo caso era da installare la prima volta ma non serve farlo tutte le altre
library(ggplot2)
# install.packages("viridis") # per avere colori che siano adatti anche a persone con daltonia  
library(viridis)

# Preparo una colorRampPalette che sia sempre quella per tutto il progetto
cl <- colorRampPalette(inferno(7)) (256)  #scelgo inferno perchè sembra essere il migliore per rendere le differenze leggere nelle immagini

# Importo le immagini scaricate sul computer
# Imposto da working directory come la cartella che contiene le immagini 
setwd("C:/Users/lucaf/OneDrive/Desktop/UNI/SCIENZE E GESTIONE DELLA NATURA/Primo anno/telerilevamento/progetto esame")

# Verifico che sia andato tutto bene 
getwd()

# Importo immagini dall'esterno, uso funzione rast.
# Il nome che assegno è legato contiene la data alla quale fa riferimento l'immagine
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
plot(astr_21_05_2021[[1]], col=cl)
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


# Per vedere quando c'è maggiore vegetazione faccio la differenza tra le immagini di giugno e agosto e giugno e maggio visto che si vede già che sono quelle con i valori di NDVI più alti (escludo praticamente marzo)
# Le differenze sono fatte sul NDVI e non sull'immagine pura perchè questo è una rappresentazione più significativa della vegetazione
#giugno - maggio
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

# notiamo che le scale sono diverse e quindi diventa difficile confrontare visivamente le immagini 
# per risolvere questo problema andiamo a usare la funzione image.plot del pacchetto fields che ci permette di impostare facilmente i valori degli assi 
# i valori della scala sono impostati a -2 e 2 perchè corrispondono ai massimi valori possibili dati dalla sottrazione tra immagini
par(mfrow=c(2,3))
image.plot(difndvigm2019, col=cl, zlim = c(-2,2))
image.plot(difndvigm2021, col=cl, zlim = c(-2,2))
image.plot(difndvigm2023, col=cl, zlim = c(-2,2))
image.plot(difndviga2019, col=cl, zlim = c(-2,2))
image.plot(difndviga2021, col=cl, zlim = c(-2,2))
image.plot(difndviga2023, col=cl, zlim = c(-2,2))

dev.off() # sempre utile fare un po' di pulizia

# Ora voglio vedere quando la biodiversità è maggiore, per farlo uso la deviazione standard, ma devo capire quale sia la componente più informativa
# faccio una PCA sulle 9 immagini che potrebbero rappresentare dei buoni candidati per ottenere questa componente

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


# calcoliamo la variabilità usando la standard deviation e capendo quale immagine è più variabile e quindi a quale momento corrisponde una maggiore biodiversità
# come argomento della funzione focal usiamo la prima componente ottenura dalla PCA appena fatta

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



par(mfrow=c(3,3))
plot(sdastr_29_05_2019, col=vir, zlim = c(0,8))
plot(sdastr_28_06_2019, col=vir, zlim = c(0,8))
plot(sdastr_22_08_2019, col=vir, zlim = c(0, 14))
plot(sdastr_21_05_2021, col=vir)
plot(sdastr_20_06_2021, col=vir)
plot(sdastr_26_08_2021, col=vir)
plot(sdastr_18_05_2023, col=vir)
plot(sdastr_20_06_2023, col=vir)
plot(sdastr_21_08_2023, col=vir)
# si nota un po' la diversità anche se non molto chiaramente. Giugno sembrerebbe essere il mese con la diversità maggiore. 
dev.off()

# voglio avere le immagini con la stessa scala in modo da poter fare un confronto visivo
# dato che la funzione plot() è poco flessibile nella scala dell'asse z uso la funzione image.plot del pacchetto fields per rappresentare le immagini, impostando il limite di scala manualmente

library(fields)

par(mfrow=c(3,3), mar = c(1,1,1,1)) # riduco i margini tra le immagini per avere una visualizzazione più ordinata
# il limite èer l'asse z è impostato usando il minimo delle immagini (0) e usando come massimo 12.5 che corrisponde ad un valore leggermente superiore al massimo più alto delle immagini
image.plot(sdastr_29_05_2019, col=vir, axes = FALSE, zlim = c(0,12.5))
image.plot(sdastr_28_06_2019, col=vir, axes = FALSE, zlim = c(0,12.5))
image.plot(sdastr_22_08_2019, col=vir, axes = FALSE, zlim = c(0,12.5))
image.plot(sdastr_21_05_2021, col=vir, axes = FALSE, zlim = c(0,12.5))
image.plot(sdastr_20_06_2021, col=vir, axes = FALSE, zlim = c(0,12.5))
image.plot(sdastr_26_08_2021, col=vir, axes = FALSE, zlim = c(0,12.5))
image.plot(sdastr_18_05_2023, col=vir, axes = FALSE, zlim = c(0,12.5))
image.plot(sdastr_20_06_2023, col=vir, axes = FALSE, zlim = c(0,12.5))
image.plot(sdastr_21_08_2023, col=vir, axes = FALSE, zlim = c(0,12.5))



# ora che abbiamo capito che giugno è il mese con la maggiore diversità e con la maggiore vegetazione facciamo un confronto diretto tra il 2019 e il 2023 per vedere se ci sono stati dei cambiamenti 
# facciamo la sottrazione tra le due immagini 

difndvigiu1923 <- ndviastr_28_06_2019 - ndviastr_20_06_2023 
plot(difndvigiu1923, col=cl)

dev.off()



# NON SERVE
# facciamo la differenza per vedere quando aumenta e quando diminuisce
# difsd2019 <- sdastr_28_06_2019 - sdastr_22_08_2019
# difsd2021 <- sdastr_20_06_2021 - sdastr_26_08_2021
# difsd2023 <- sdastr_20_06_2023 - sdastr_21_08_2023

# le plottiamo per vedere i risultati
# par(mfrow=c(1,3))
# plot(dif2019, col=cl)
# plot(dif2021, col=cl)
# plot(dif2023, col=cl)
# anche in questo caso non si nota grande differenza di diversità
# unico che mostra leggera differenza è 2021 dove giugno è più diverso che agosto


astr_28_06_2019
astr_22_08_2019
astr_20_06_2021
astr_26_08_2021
astr_20_06_2023 
astr_21_08_2023  

dev.off()








# CARINO MA NON MI è UTILE A NULLA
# ho tre bande quindi tre valori, vado a prenderli per vedere la percentuale di variabilità che ognuna delle componenti spiega
# calcolo la variabilità totale 

# totpcaastr_28_06_2019 <- sum(50.816965, 35.471333,  4.856977)

# calcolo ora la prercentuale di varaibilità spiegata dalla prima componente 
# 50.816965 * 100 / totpcaastr_28_06_2019





# CLASSIFICAZIONE NON FUNZIONA, NON POSSO CONFRONTARE LE MEDIE PERCHè SONO DIVERSE, OTTENUTE EMPIRICAMENTE
# Ora andiamo a classificare e calcolare le frequenze per avere un valore numerico di quello che accade, quindi di dove abbiamo vegetazione, dove abbiamo suolo nudo e acqua
# Lo facciamo con l'immagine pura ma solo per i mesi di giugno e agosto per vedere quando la vegetazione è al massimo (maggio escluso ad occhio)

# Con immagine pura, usiamo 2 cluster in modo da distinguere le zone con vegetazione dal resto
# clastr_28_06_2019 <- im.classify(astr_28_06_2019, num_clusters = 2)
# clastr_22_08_2019 <- im.classify(astr_22_08_2019, num_clusters = 2)
# clastr_20_06_2021 <- im.classify(astr_20_06_2021, num_clusters = 2)
# clastr_26_08_2021 <- im.classify(astr_26_08_2021, num_clusters = 2)
# clastr_20_06_2023 <- im.classify(astr_20_06_2023, num_clusters = 2)
# clastr_21_08_2023 <- im.classify(astr_21_08_2023, num_clusters = 2)


# dev.off() # sempre utile fare un po' di pulizia 

# li visualizziamo 
# par(mfrow = c(3,2)) # mostriamo tutte le immagini assieme
# plot(clastr_28_06_2019)
# plot(clastr_22_08_2019)
# plot(clastr_20_06_2021)
# plot(clastr_26_08_2021)
# plot(clastr_20_06_2023)
# plot(clastr_21_08_2023)
# in tutti i casi il layer 1 rappresenza la vegetazione DOBBIAMO FARLO TORNARE!!!!

# Facciamo anche la classificazione ma sul NDVI invece che solo sull'immagine pura, in modo che sia più rappresentativo della vegetazione 
# clndviastr_28_06_2019 <- im.classify(ndviastr_28_06_2019, num_clusters = 2)
# clndviastr_22_08_2019 <- im.classify(ndviastr_22_08_2019, num_clusters = 2)
# clndviastr_20_06_2021 <- im.classify(ndviastr_20_06_2021, num_clusters = 2)
# clndviastr_26_08_2021 <- im.classify(ndviastr_26_08_2021, num_clusters = 2)
# clndviastr_20_06_2023 <- im.classify(ndviastr_20_06_2023, num_clusters = 2)
# clndviastr_21_08_2023 <- im.classify(ndviastr_21_08_2023, num_clusters = 2)

# dev.off() #sempre utile fare un po' di pulizia


# Visualizziamo pure questi
# par(mfrow = c(3,2)) # mostriamo tutte le immagini assieme
# plot(clndviastr_28_06_2019)
# plot(clndviastr_22_08_2019)
# plot(clndviastr_20_06_2021)
# plot(clndviastr_26_08_2021)
# plot(clndviastr_20_06_2023)
# plot(clndviastr_21_08_2023)

# ora calcoliamo le frequenze per capire numericamente quando c'è più vegetazione 
# fclastr_28_06_2019 <- freq(clastr_28_06_2019)
# fclastr_22_08_2019 <- freq(clastr_22_08_2019)
# fclastr_20_06_2021 <- freq(clastr_20_06_2021)
# fclastr_26_08_2021 <- freq(clastr_26_08_2021)
# fclastr_20_06_2023 <- freq(clastr_20_06_2023)
# fclastr_21_08_2023 <- freq(clastr_21_08_2023)

# calcoliamo i totali e le proporzioni per ogni immagine nei tre anni

#28/06/2019
# totclastr_28_06_2019 <- ncell(clastr_28_06_2019)
# propclastr_28_06_2019 <- fclastr_28_06_2019 / totclastr_28_06_2019 

#22/08/2019
# totclastr_22_08_2019 <- ncell(clastr_22_08_2019)
# propclastr_22_08_2019 <- fclastr_22_08_2019 / totclastr_22_08_2019

#20/06/2021
# totclastr_20_06_2021 <- ncell(clastr_20_06_2021)
# propclastr_20_06_2021 <- fclastr_20_06_2021 / totclastr_20_06_2021

#26/08/2021
# totclastr_26_08_2021 <- ncell(clastr_26_08_2021)
# propclastr_26_08_2021 <- fclastr_26_08_2021 / totclastr_26_08_2021

#20/06/2023
# totclastr_20_06_2023 <- ncell(clastr_20_06_2023)
# propclastr_20_06_2023 <- fclastr_20_06_2023 / totclastr_20_06_2023

#21/08/2023
# totclastr_21_08_2023 <- ncell(clastr_21_08_2023)
# propclastr_21_08_2023 <- fclastr_21_08_2023 / totclastr_21_08_2023


#ora calcoliamo le percentuali 
# percastr_28_06_2019 <- propclastr_28_06_2019 * 100
# percastr_22_08_2019 <- propclastr_22_08_2019 * 100 
# percastr_20_06_2021 <- propclastr_20_06_2021 * 100 
# percastr_26_08_2021 <- propclastr_26_08_2021 * 100 
# percastr_20_06_2023 <- propclastr_20_06_2023 * 100
# percastr_21_08_2023 <- propclastr_21_08_2023 * 100 


#creiamo una matrice che contenga le infomazioni che ci interessano, quindi solo il dato di vegetazione per giugno e agosto
# la creiamo in modo che abbia l'anno in colonna e ogni riga corrisponda ad un mese
# perc <-matrix(c(percastr_28_06_2019[1,3], percastr_22_08_2019[1,3], 
#                percastr_20_06_2021[1,3], percastr_26_08_2021[1,3], 
#                 percastr_20_06_2023[1,3], percastr_21_08_2023[1,3]), 
#              nrow = 2, ncol = 3, byrow = FALSE)

# perc # visualizziamo per essere sicuri che sia tutto in ordine 


# creiamo una tabellina in excel con i valori in modo da poterli vedere
# rn <- c("Giugno", "Agosto") # diamo dei nomi almeno alle righe, colonne andinamo a ritoccarle in excel 
# write.csv2(perc, file = "tabella percentuali.csv", row.names = rn)

# proviamo anche a fare un istogramma con i valori 

# abbiamo bisogno innanzitutto di un data frame per poter usare ggplot 
# percdf <- data.frame(perc)

# ora usiamo la funzione, gli diciamo di mettere giugno e agosto sull'asse x e la percentuale di copertura di vegetazione per i due mesi sull'asse y 

# preparo il vettore le etichette dell'asse x
# class <- c("vegetazione", "suolo nudo") 

# grafico per il 2019 
# p2019 <- ggplot(percdf, aes(x=rn, y=c(percastr_28_06_2019[1,3],percastr_22_08_2019[1,3]), color=rn)) + 
#          geom_bar(stat="identity",   fill=c("green", "darkgreen")) +
#          ylim(c(0,100))
# p2019 
# grafico per il 2021
# p2021 <- ggplot(percdf, aes(x=rn, y=c(percastr_20_06_2021[1,3],percastr_26_08_2021[1,3]), color=rn)) + 
#          geom_bar(stat="identity",   fill=c("green", "darkgreen")) +
#          ylim(c(0,100))
# p2021 # verifichiamo che abbia funzionato 

# grafico per il 2023
# p2023 <- ggplot(percdf, aes(x=rn, y=c(percastr_20_06_2023[1,3],percastr_21_08_2023[1,3]), color=rn)) + 
#          geom_bar(stat="identity",   fill=c("green", "darkgreen")) +
#          ylim(c(0,100))
# p2023 #di nuovo verifichaimo che abbia funzionato 
