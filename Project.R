library(imageRy)  # ogni volta che riparto con R devo dirgli di leggere i pacchetti che mi servono, li metto tutti all'inizio
library(terra)
# install.packages("ggplot2")
library(ggplot2)
# install.packages("viridis") # per avere colori che siano adatti anche a persone con daltonia  
library(viridis)


viridisc <- colorRampPalette(viridis(7)) (256) 



# Per invece andare ad importare l'immagine devo usare im.import("") andando a 
# mettere il nome dell'immagine tra ""
# b2 <- im.import("sentinel.dolomites.b2.tif") 

# Posso anche cambiare la scala di colori dell'imagine, inserisco nella funzone 
# colorRampPalette() un vettore con i nomi dei colori. devo ricordarmi di 
# mettere all'esterno della funzione anche il numero di sfuature che voglio
# cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
# plot(b2, col=cl)  # ora però per mostrare l'immagine devo plottarla e dirgli di prendere quei colori che ho appena scelto 


# Posso ora creare un multiframe per aprire (e quindi visualuzzare) tutte le 
# immagino contemporaneamente. devo dirli come disporre le immagini sullo 
# schermo, in questo caso per esempio creo uno spazio di 2 x 2 
# par(mfrow=c(2,2))  #dopo aver creato lo spazion mando in sequenza i comandi per inserire i grafici

# Posso creare un'immagine fatta di può layer sovrapposti e visualuzzarli 
# singolarmente,  
# stacksent <- c(b2, b3, b4, b8)
# dev.off() # funzione che mi permette di chiudere quello che sto visualuzzando
# plot(stacksent, col=cl)


# RGB space
# stacksent: 
# band2 blue element 1, stacksent[[1]] 
# band3 green element 2, stacksent[[2]]
# band4 red element 3, stacksent[[3]]
# band8 nir element 4, stacksent[[4]]
# im.plotRGB(stacksent, r=3, g=2, b=1)
# im.plotRGB(stacksent, r=4, g=3, b=2)
# im.plotRGB(stacksent, r=3, g=4, b=2)
# im.plotRGB(stacksent, r=3, g=2, b=4)


pairs(stacksent) # che cosa fa questa funzione?? 



# immagine è creata facendo plot RGB, ha già le bande suddivise in questo modo: 
# band 1 = nir = R 
# band 2 = red = G
# band 3 = green = B 
# andiamo a ricreare il plot: 
# im.plotRGB(m1992, 1,2,3 )

# per evidenziare il suolo nudo lo si fa diventare giallo (occhio umano lo vede meglio), cambiando il nir in blu 
# im.plotRGB(m1992, 2,3,1 )


# ora vogliamo avere un indice che possa quantitativamente dire la differenza, non solo "ad occhio" qualitativamente. lo dobbiamo calcolare
# si tratta del DVI (Difference Vegetation Index) quello che facciamo è prendere ogni singolo pixel della banda del nir e gli sottrae il pixel della banda del rosso. Ottengo un valore per ogni pixel, se la risoluzione è di 8 bit ho 256 (da 0 a 255) valori possibili per ogni pixel dell'immagine. 
# i valori quindi possono variare tra 255 (massimo) a -255 (se ho rosso massimo = 255 e nir minimo =0). Capiamo quindi che indice è fortemente dipendente dalla risoluzione in entrata (se ho 4 bit ho valori da -15 a +15) 
# dvi1992 = m1992[[1]] - m1992[[2]] 
# ci sarebbe anche un modo per scriverla con il nome delle bande (li devo sapere però..). Ci piace un po' meno, sarebbe: 
# dvi1992 = m1992$matogrosso~2219_lrg_1 - m1992$matogrosso~2219_lrg_2

# ora posso fare il plot di quello che abbiamo appena sviluppato
# plot(dvi1992, col=cl)

# ora faccio uguale anche per il 2006, calcolo il DVI
# dvi2006 = m2006[[1]] - m2006[[2]] # in tutti i casi abbiamo messo = perchè si tratta di un'operazione, in questo caso possiamo usare = (è addiritura meglio) 

# ora plotto anche questo, uso la stessa colorRampPalette di prima
# plot(dvi2006, col=cl)


# abbiamo capito che dobbiamo normalizzare per confrontare immagini di bit diversi (risolve il problema dei massimi e minimi diversi), calcoliamo NDVI 
# posso anche fare con funzione di imagery che calcola direttamente ndvi e dvi 
ndvi2006a <- im.ndvi(m2006, 1, 2) # devo dirgli l'immagine e quali bande sono quale, lui poi fa i calcoli 
ndvi2006a
plot(ndvi2006a, col=cl)
plot(ndvi2006 - ndvi2006a) 





# ora classifichiamo le immagini 
# sunc <- im.classify(sun, num_clusters = 3) # gli diamo come primo argomento l'immagine da classificare, gli diciamo che il numero di cluster che deve essere 3
# sunc # come prima vogliamo vedere quello che abbiamo creato

# ora lavoriamo con le nostre del matogrosso, importiamo 
# m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg" )
# m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# facciamo la classificazione 
# m1992c <- im.classify(m1992, num_clusters = 2) # sta volta gli diciamo di fare due cluster: foresta e human (all'interno del quale mette sia suolo nudo che acqua torbida)
# per il 1992 quello che abbiamo come risultato è: 
# classe 1 = foresta 
# classe 2 = human 

# m2006c <- im.classify(m2006, num_clusters = 2) # ovviamente anche in questo caso due cluster 
# di nuovo ci appuntiamo quale clsse corrisponde a quale copertura: 
# classe 1 = foresta 
# classe 2 = human 

# calcolo le frequenze, non mi basta avere la suddivisione per classi, voglio avere dei numeri che mi descrivano il cambiamento nel tempo
f1992 <- freq(m1992c)
f1992 # voglio vedere i numeri

# facciamo la proporzione, dividiamo le frequenze per il totale dei pixel (ci sono anche altre righe nel risultato che non consideriamo)
tot1992 <- ncell(m1992) # usiamo ncell() per calcolare il numero totale di pixel 
prop1992 = f1992 / tot1992 
prop1992 # di nuovo vediamo il risultato

 # se vogliamo fare le percentuali devo moltiplicare la proporzione per 100 
perc1992 = prop1992 * 100 
perc1992 
# ottengo che il 83% è foresta e che human è 17% 

# calcolo le frequenze per 2006 proprio come prima 
f2006 <- freq(m2006c)
f2006
# facciamo la proporzione 
tot2006 <- ncell(m2006) 
tot2006 # notiamo che il numero di pixel è diverso, bisogna fare il totale dell'immagine non usare il totale di prima
prop2006 = f2006 / tot2006 
prop2006
# faccio come prima le percentuali 
perc2006 = prop2006 * 100 
perc2006
# ora otteniamo che la foresta è 45% di foresta e il 55% di human, vediamo solo osservando i numeri che c'è stato un cambiamento, vogliamo rendere visibile questo cambiamento con un istogramma
# dobbiamo creare un data frame con data.frame(), è il "formato" che devo inserire nella funzione che crea l'istogramma
# mettiamo nella prima colonna cosa rappresenta la classe (forest e human), nella seconda i valori per il 1992 (83 e 17) e nella terza colonna ci mettiamo i valori per il 2006 (55 e 45)

# creiamo una tabella che contenga i nostri dati per poi farci un grafico 
class <- c("forest", "human") # prima colonna della tabella 
p1992 <- c(83, 17) # seconda colonna
p2006 <- c(45, 55) # terza colonna 
tabout <- data.frame(class, p1992, p2006) # crea la tabella 
tabout # visualizziamo la tabella 

# ora facciamo un grafico con i valori che abbiamo ottenuto, abbiamo bisogno del pacchetto ggplo2 (l'abbiamo già caricato all'inizio)
ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity",   fill="red")
# primo argomento è la tabella da plottare, poi ci vogliono aestetics, cioè cosa vogliamo sulla x e sulla y e come vogliamo colorarlo) 
# poi fuori dal grafico devo dirgli quale tipo di grafico voglio (devo metterci un +), nel tipo di grafico devo mettere dei parametri, sta= "identity" quando non sto facendo una statistica ma prendo il dato così com'è, fill= da il colore

# ora lo facciamo uguale per 2006
ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="red")

# ora voglio fondere i due grafici diversi, devo usare il pacchetto patchwork che fonde, meglio associa i due grafici. 
# devo installare il pacchetto: 
install.packages("patchwork")
library(patchwork) # leggiamo il pacchetto

# do un nome ai grafici fatti prima 
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity",   fill="red")
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity",   fill="red")
p1 + p2 # è un modo molto banale e molto potente per unire due grafici, li mette uno affianco all'altro

# se voglio metterli uno sopra all'altro faccio / 
p1 / p2

# ma in questo caso però ho scale diverse, i grafici sono ingannevoli, non chiari, devo mettere la scala uguale quindi. Devo aggiungerlo come funzione (con il +) in fondo
# metto ylim= i valori che fanno da limite 
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity",   fill="red") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity",   fill="red") + ylim(c(0,100))
p1 + p2 
# ora vedo molto meglio quanto è aumentata la perdita di foresta e quanto è aumentato l'impatto umano. 




















# Ora dobbiamo fare la sottrazione tra immagini, sempre per quantificare il cambiamento (nel tempo)
# lavoriamo con nuove immagini, siamo stufi del mato grosso.

# importiamo i dati (EN01 ed EN02)
en01 <- im.import("EN_01.png") #sono mappe che non hanno infrarosso o altre cose strane, hanno i soliti 3 livelli. Descrivono il livello di inquinanti in diversei periodi del 2020. 
# Quello che vado a fare è confrontare i diversi livelli (quindi la stessa banda di una immagine con la stessa banda dell'altra immagine). 
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




















# Impariamo ad importare i dati dall'esterno

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





















# Variabilità


#usiamo l'mmagine sentinel 
sent <- im.import("sentinel.png") #è un'immagine con 4 bande ma una è di controllo, ci servono solo 3 livelli

# la plottiamo con solo le tre bande che ci servono 
im.plotRGB(sent, 1, 2, 3)
#NIR = banda 1, red = banda 2, green = banda 3. Questo vuol dire che la parte rossa (relazionata al NIR) è la parte di bosco e prateria. 


# ora calcoliamo la deviazione standard (ma solo su una banda, non tutte e tre), quello che facciamo questo caso è sceglierne una, nella prossima lezione facciamo analisi multivariata
# di solito si usa il livello che maggiormente descrive gli oggetti, quindi in questo caso il nir. 
nir <- sent[[1]] #per evitare di scrivere sent[[1]] tutte le volte. 



# funzione focal, si usa per calcolare la variabilità, si usa la moving window 
sd3 <- focal(nir, matrix(1/9, 3,3), fun=sd) 
#primo oggetto è su cosa si basa, poi dobbiamo descrivergli la finestra usando una matrice (sono stessi elementi come in vettore ma disposti in 2 dimensioni)
# all'interno di matrix dobbiamo mettere tre argomenti, il primo il range di pixel da prendere (mettiamo da quale a quale quindi 1/9), come sono diposti (in questo caso non c'è dubbio ma dobbiamo mettere come diporli quindi 3,3)
# in focal dobbiamo anche mettere la funzione che vogliamo calcolare, quindi nel nostro caso sd (standard deviation)
# diamo il nome al tutto per es sd3, importante non sd perchè altrimenti riconosce sd come oggetto e non come funzione 

#plottiamo questa diversità
plot(sd3) #vediamo che non si nota moltissimo la variabilità 


# ora proviamo ad allargare la moving window a 7x7
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7, col=viridisc)

# facciamo uno stack con i due calcoli di deviazione standard per vederli assieme 
stacksd <- c(sd3, sd7)
plot(stacksd, col= viridisc)
# notiamo come allargando si sfochi l'immagine 

# ora gaurdiamo il 13 x 13 per vedere come cambia 
sd13 <- focal(nir, matrix(1/169, 13, 13), fun=sd)
plot(sd13, col=viridisc)
stacksd <- c(sd3, sd7, sd13)
plot(stacksd, col= viridisc)
# anche in questo caso si vede bene come aumenti la sfocatura dovuto al fatto che usiamo un numero sempre maggiore di pixel per calcolare la nostra deviazione standard.





















# analisi multivariata 
# funzione compresa in imageRy che ha compito di compattare in una sola dimensioni. Le componenti che restituisce sono le stesse in numero di quelle di partenza (nel nostro caso 4 perchè le bande sono 4) ma estrae la componente principale 
# richiamiamo le librerie 


pairs(sentdo) #attenzione, correlazione non è causalità. 

#calcoliamo la pca 
pcimage <- im.pca(sentdo)
# restituisce i range delle varie componenti, la prima è quella a variabilità maggiore (la principale). Numericamente vengono un po' diversi se faccio diverse ripetizioni, questo è dovuto al fatto che si basa su un campione estratto casualmente 
# sotto c'è anche la correlazione tra banda e componenti estratte dall'analisi. 

# sommiamo i vari range di tutti gli assi ottenuti per avere la variabilità totale
tot <- sum(1705.70050, 570.32676, 43.70992, 25.22304)

# calcolo la percentuale di variabilità che è spiegata da una certa componente 
1705.70050 * 100 /tot #restituisce la percentuale di variabilità spiegata dalla prima componente 
570.32676 * 100 / tot #percentuale dalla seconda 

# creo una colorRampPalette
vir <- colorRampPalette(viridis(7))(100) 
plot(pcimage, col=vir) #vedo che la prima compontente è molto ben rappresentativa delle bande (immagine ancora si capisce), mentre nell'ultima non si capisce più nulla (immagine non chiara), solo rumore di fondo

# vedo che posso anche scrivere direttamente plot(pcimage, col=viridis(100)) ed evitare di fare la colorampalette 
plot(pcimage, col=viridis(100))
# posso anche cambiare il colore 
plot(pcimage, col=plasma(100))





















