# Possiamo usare R come una calcolatrice, chiedergli quindi di fare semplici 
# calcoli aritmetici. 
# vediamo già il ruolo della freccetta <-, si usa per fare l'assegnazione,
# sarebbe a dire dare un nome ad un certo oggetto. R lavora per oggetti
# se ad un calcolo non do il nome non lo posso poi richiamare. 

a <- 6 * 7  # assegno la moltiplicazione di 6 x 7 all'oggetto "a" 
b <- 5 * 8  # uguale con 5 x 8 

a + b  # ora posso chiedere ad R di dirmi quanto fa 6x7 + 5x8, cioè a + b

# Vettori 
# se voglio creare un oggetto che abbia al suo interno più di un elemento devo 
# usare la funzione concatenate, che prende tutti gli elementi separati da 
# virgole e crea un vettore. La posizione è importante, gli elementi di un 
# vettore sono indicizzati

flowers <- c(3, 6, 8, 10, 15, 18)  # prendo dei valori (inventati) per il numero di fiori in una serie di stazioni
flowers  # R l'avrebbe già fatto, per vedere cosa ha fatto (e controllarlo) richiamo l'oggetto creato

insects <- c(10, 16, 25, 42, 61, 73)  # prendo il velore del numero di insetti per ognuna delle stazioni di prima 
insects

# Plot 
# posso ora creare un plot con i due oggetti, vedere magari se si riesce ad 
# intuire una relazione di qualche tipo
plot(flowers, insects)    

# La funzione plot() ha un sacco di parametri: 

# simboli: posso scegliere che simboli utilizzare, per farlo devo dire che il 
# parametro pch sia = ad un certo numero che corrisponde ad un determinato 
# simbolo (trovo la corrispondenza su tabelle su internet)
plot(flowers, insects, pch=19)

# anche la dimensione dei simboli sul grafico può essere cambiata, si usa 
# parametro cex = questa volta però devo mettere di quante volte ingrandisco 
# il mio simbolo
plot(flowers, insects, pch=19, cex=2)
plot(flowers, insects, pch=19, cex=.5)  # al posto di 0.5 posso scrivere anche solo .5 

# Posso cambiare anche il colore del mio simbolo, devo scrivere col= "" 
# all'interno delle virgolette metterò il nome del colore, anche in questo caso 
# ci sono delle tabelle con i nomi dei colori in R
plot(flowers, insects, pch=19, cex=.5, col="chocolate1") 

# Posso anche inserire il nome dell'asse x e y, basta usare xlab="" e ylab=""
plot(insects, flowers, xlab="insetti", ylab="fiori", col="red", pch=8, cex=2)


