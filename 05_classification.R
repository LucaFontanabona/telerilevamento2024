# lezione sulla classificazione delle immagini
# installo e apro i pacchetti che mi servono

install.packages("ggplot2")
library(terra)
library(imageRy)
library(ggplot2)

# come al solito importiamo le immagini 
im.list()
# lavoriamo come esempio sulle immagini del sole date da Solar Orbiter
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
sun # per vedere l'immagine

# ora classifichiamo le immagini 
sunc <- im.classify(sun, num_clusters = 3) # gli diamo come primo argomento l'immagine da classificare, gli diciamo che il numero di cluster che deve essere 3
sunc # come prima vogliamo vedere quello che abbiamo creato

# ora lavoriamo con le nostre del matogrosso, importiamo 
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg" )
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# facciamo la classificazione 
m1992c <- im.classify(m1992, num_clusters = 2) # sta volta gli diciamo di fare due cluster: foresta e human (all'interno del quale mette sia suolo nudo che acqua torbida)
# per il 1992 quello che abbiamo come risultato è: 
# classe 1 = foresta 
# classe 2 = human 

m2006c <- im.classify(m2006, num_clusters = 2) # ovviamente anche in questo caso due cluster 
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
