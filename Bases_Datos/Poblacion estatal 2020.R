#QUARENTENA. Grupo de usuarios 
#Sesion: Visualizacion y analisis espacial de datos de Covid-19 en Mexico para principiantes
#Qgisero: @Tlacaelelmx
#Ejercicio: calculo de poblacion estatal a mitad de anio 2020 para calcular tasas de contagio por COVID-19

#####################################

#Limpiar entorno y argar paqueteria
rm(list=ls())
packages<-c("foreign", "openxlsx")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
        install.packages(setdiff(packages, rownames(installed.packages())))  
}
lapply(packages, require, character.only=TRUE)

#Cargar datos
file1 <- "Direccion de base_municipios_final_datos_01.csv"
dat1  <- read.csv(file1)
file2 <- "Direccion de base_municipios_final_datos_02.csv"
dat2  <- read.csv(file2)

#Filtrar datos por anio
da1 <- dat1[dat1$AÑO%in%2020,]
da2 <- dat2[dat2$AÑO%in%2020,]

#Agregar poblacion por municipio
da3 <- aggregate(POB~CLAVE_ENT, FUN= sum, data=da1)
da4 <- aggregate(POB~CLAVE_ENT, FUN= sum, data=da2)
Pob_Ent <- rbind(da3, da4)
names(Pob_Ent) <- c("CVE_ENT", "POB")

#Exportar datos a excel para "join" en QGIS
dir <- "Direccion"
setwd(dir)
write.xlsx(Pob_Ent, "Pob_Ent.xlsx")