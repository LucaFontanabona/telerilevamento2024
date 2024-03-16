# I pacchetti in R sono un insieme di funzioni che qualcuno (gentilmente) ha 
# creato e che rende disponibili al mondo intero
# li possiamo prendere ed installare dal CRAN oppure da altre parti come GitHub. 
# la funzione è install.packages() per pacchetti dal CRAN
install.packages("terra")  
install.packages("devtools")  # pacchetto che ci viene utile dopo

# Per poter però usare le funzioni presenti all'interno dei pacchetti però 
# bisogna leggerli prima, si usa la funzione library()
library(terra) 
library(devtools)

# per installare da GitHub invece devo usare una funzione specifica del 
# pacchetto "devtools": install_github(""). l'argomento della funzione è l'user da 
# cui prendo il pacchetto e il nome del pacchetto separati da / 

install_github("ducciorocchini/imageRy")

library(imageRy)  # serve di vuovo per leggere la il contenuto della funzione
