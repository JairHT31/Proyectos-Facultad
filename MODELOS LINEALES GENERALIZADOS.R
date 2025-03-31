#HERNANDEZ TORRES JAIR

#314101765

#SEMINARIO MODELOS LINEALES GENERALIZADOS, 2025-2

########################################             REGRESIÓN LINEAL MULTIPLE


library(ggplot2)

rm(list = ls(all.names = TRUE))
gc()

setwd("C:\\Users\\Jair HT\\Desktop\\SEMINARIO ESTADISTICA")


options(digits=4)  

library(multcomp)

ARTERIAL <-read.csv("Preg1A.csv")




ARTERIAL$sex=factor(ARTERIAL$sex, levels=c(1,2), labels=c("HOMBRE","MUJER") )
str(ARTERIAL)
summary(ARTERIAL[c("bpsystol", "bmi","age","sex")])

library(ggplot2)


#GRAFICO DE DISPERSION DE LOS DATOS CRUDOS.
ggplot(ARTERIAL, aes(x = bmi, y = bpsystol, color = factor(sex))) +
  geom_point() +  
  scale_color_manual(values = c("HOMBRE" = "red", "MUJER" = "blue")) +  
  labs(x = "IMC", y = "Presión Sistólica", title = "IMC vs. Presión Sistólica") +
  theme_minimal() +  
  theme(legend.position = "bottom",
        plot.title.position = "panel",  
        plot.title = element_text(hjust = 0.5),
        panel.background = element_rect(fill = "lightgray"),  
        plot.background = element_rect(fill = "white")
        ) +  
  guides(color = guide_legend(title = " ", labels = c("HOMBRE", "MUJER")))  


library(GGally)  

levels(ARTERIAL$sex)

#MODELO DE RGRESION LINEAL MULTIPLE 1

MODELO1 <-lm(bpsystol ~ bmi + age + sex, data = ARTERIAL)

summary(MODELO1)


#ANALISIS DE SUPUESTOS:


#A) LINEALIDAD:
X11()
plot(MODELO1, 1, caption = "Modelo 1")

x11()
library(car)
residualPlots(MODELO1)
#Age NO CUMPLE linealidad.

#B) HOMOCEDASTICIDAD:
X11()
plot(MODELO1,3)

lmtest::bptest(MODELO1)

#Los Residuos NO TIENEN Varianza constante


#C) NORMALIDAD:
X11()
plot(MODELO1,2)


residuales_stan = broom::augment(MODELO1)$.std.resid
shapiro.test(residuales_stan)
nortest::lillie.test(residuales_stan)
tseries::jarque.bera.test(residuales_stan)

#Las 3 pruebas indicaron que NO SE RECHAZA H0 por tanto es plausile decir que HAY NORMALIDAD

#D) INDEPENDENCIA

lmtest::dwtest(MODELO1) # prueba Durbin-Watson

lmtest::bgtest(MODELO1) ##prueba Breusch-Godfrey

#NO se rechaza H0, EXISTE INDEPENDENCIA.


#E) ALEATORIEDAD.

#Prueba de rachas
aleatorios <- broom::augment(MODELO1)

lawstat::runs.test(aleatorios$.std.resid, plot.it = FALSE)
#NO se rechaza H0, EXISTE aleatoriedad


#F)OUTLIERS
X11()
plot(MODELO1, 5)
#Al parecer por  lo menos graficamente NO hay datos ATIPICOS.

#CONCLUSION:
#El modelo globalmente tiene buena LINEALIDAD, pero en cuanto a covariables la EDAD NO cumplea LINEALIDAD
#Otro problema del MODELO es la HOMOCEDASTICIDAD.
#Por tanto vamos a corregir esos detalles para que el modelo pueda ser tratado desde una perspectiva de inferencia de manera adecuada.

#A) Mejorar LINEALIDAD dE AGE
#Vamos a mejorar la linealidad de la covariable AGE con el procedimiento de BOXTIDWELL
car::boxTidwell( bpsystol ~ age, ~ bmi + sex  , data=ARTERIAL)
#EL MODELO BOXTIDWEL SUGIERE UNA POTENCIA DE 4
MODELO2 = lm(bpsystol ~ bmi + I((age)^(4)) + sex, data=ARTERIAL)
summary(MODELO2)


X11()
residualPlots(MODELO2)

#De acuerdo a Tukey Test con significancia de 0.05 NO SE RECHAZA H0 para el MODELO2
#por tanto EXISTE relacion lineal de todas las covariables con la variable Bystol 


#HOMOCEDASTICIDAD.

lmtest::bptest(MODELO2)
#Con un p-value de 0.06 MAYOR a 0.05 podriamos NO RECHAZAR h0, por tanto EXISTE Homocedasticidad, 
#pero vamos a mejorarla ya que esta cerca del rechazo.
# ENtonces vamos a proceder a mejorar Homocedasticidad con BOX COX para transformar la VARIABLE DEPENDIENTE

#TRANSFORMACION BOX - COX 
powerTransform(MODELO2)
 #Nos sugiere un parametro lamda = 0.2394, es decir una transformacion de tipo RAIZ cuadrada, pues es lo que 
#el parametro LAMDA sugiere
MODELO3 = lm(I((bpsystol)^(0.5)) ~ bmi + I((age)^(4)) + sex, data=ARTERIAL)
summary(MODELO3)


lmtest::bptest(MODELO2)
lmtest::bptest(MODELO3)
#En este caso para el MODELO3 no se RECHAZA H=0, EXISTE HOMOCEDASTICIDAD.
#Vamos a ver que pasa con todos los demas supuestos:

#A) LINEALIDAD:
X11()
plot(MODELO3, 1, caption = "Modelo 3")
#NO Rechaza H0: Existe LINEALIDAD

X11()
residualPlots(MODELO3)


#B) HOMOCEDASTICIDAD:


lmtest::bptest(MODELO3)
#NO rechaza H0 Existe HOMOCEDASTICIAD



#C) NORMALIDAD:
X11()
plot(MODELO3,2)


residuales_stan3 = broom::augment(MODELO3)$.std.resid
shapiro.test(residuales_stan3)

#NO rechaza H0, EXISTE NORMALIDAD

#D) INDEPENDENCIA

lmtest::dwtest(MODELO3) # prueba Durbin-Watson

#EXISTE NORMALIDAD


#E) ALEATORIEDAD.

#Prueba de rachas
aleatorios3 <- broom::augment(MODELO3)

lawstat::runs.test(aleatorios3$.std.resid, plot.it = FALSE)

#EISTE ALEATORIEDAD

#F)OUTLIERS
X11()
plot(MODELO3, 5)
#Tenemos 3 datos Atipicos.


#EL MODELO3 ya cumple con todos los supuestos, ya podemos trabajar con el.

#Se puede indicar que para una persona de cierta edad y sexo, tener un índice de masa corporal alto
#se asocia con una alta presión arterial sistólica?


#Tenemos el siguiente modelo:
#  E(bpsystol)^(0.5));bmi,(age)^(4)),sex)=b0 + b1bmi + b2(age)^(4) + b3sex

#Como queremos analizar el primedio de la presion sistolica en funcion del IMC con una edad y sexo especificos,
#entonces unicamente el IMC será variable para el analisis.

#E(bpsystol)^(0.5));bmi=X,(age)^(4))=C1,sex=C2)=b0 + b1X + b2C1 + b3C2

#Vamos a comparar 2 promedios, el primero con un IMC = x, otro con un IMC = x+C3, esto porque queremos ver si un IMC alto influye en una mayor Psistolica  



##E(bpsystol)^(0.5));bmi=X,(age)^(4))=C1,sex=C2)=b0 + b1X + b2C1 + b3C2 < E(bpsystol)^(0.5));bmi=X+C3,(age)^(4))=C1,sex=C2)=b0 + b1(X+C3) + b2C1 + b3C2
#en terminos d elos betas se tiene:
#b0 + b1X + b2C1 + b3C2 < b0 + b1(X+C3) + b2C1 + b3C2
#b1x < b1x + b1C3
#0 < b1C3
#0 < b1

#Es decir queremos comprobar si: 0 < b13
#Para eso haremos uso de la PRUEBA T, contrastando la siguiente hipotesis:

# H0: b1 ≤ 0 VS  Ha: b1 > 0


K=matrix(c(0,1,0,0), ncol=4, nrow=1, byrow=TRUE)
m=c(0)
summary(glht(MODELO3, linfct=K, rhs=m, alternative="greater"))

# LA prueba RECHAZA H0, por tanto se tiene que b1 > 0 lo que en resumen implica que podemos afirmar que
#Dada una cierta edad y sexo, un IMC alto en promedio se asocia con una presión sistólica alta.





#CONTRUCCION DE UNA GRAFICA DE DISPERSION CON LAS CURVAS PREDICTORAS DEL MODELO3
#SIENDO MUY HONESTOS ME ES MENCIONAR QUE EN ESTA PARTE DEL CODIGO ME APOYE DE INTELIGENCIA ARTIFICIAL
#PORQUE SE ME COMPLICÓ CONSIDERABLEMENTE UNIR AMAS GRAFICAS YA QUE MI CAPACIDAD SOLO ME DIO
#PARA HACER EL GRAFICO DE DISPERSION POR UN LADO Y EL GRAFICO DEL AJUSTE PUNTUAL POR OTRO
#NO SUPE COMO UNIR AMBAS GRAFICAS EN UNA SOLA.
X11()

MODELO3 <- lm(I((bpsystol)^(0.5)) ~ bmi + I((age)^(4)) + sex, data = ARTERIAL)

coeficientes <- coef(MODELO3)


prediccion_bpsystol <- function(bmi, coeficientes, edad, sex) {
  pred_bpsystol_0_5 <- coeficientes[1] + coeficientes[2] * bmi + coeficientes[3] * (edad^4) + coeficientes[4] * sex
  return(pred_bpsystol_0_5^2)
}


bmi_min <- min(ARTERIAL$bmi, na.rm = TRUE)
bmi_max <- max(ARTERIAL$bmi, na.rm = TRUE)
bmi_values <- seq(bmi_min, bmi_max, by = 0.5)


y_values_h30 <- sapply(bmi_values, prediccion_bpsystol, coeficientes, 30, 0)
y_values_h45 <- sapply(bmi_values, prediccion_bpsystol, coeficientes, 45, 0)
y_values_h65 <- sapply(bmi_values, prediccion_bpsystol, coeficientes, 65, 0)

y_values_m30 <- sapply(bmi_values, prediccion_bpsystol, coeficientes, 30, 1)
y_values_m45 <- sapply(bmi_values, prediccion_bpsystol, coeficientes, 45, 1)
y_values_m65 <- sapply(bmi_values, prediccion_bpsystol, coeficientes, 65, 1)


plot(bmi_values, y_values_h30, type = "l", col = "blue", lty = 1, lwd = 4, 
     xlab = "Índice de Masa Corporal", ylab = "Presión Sistólica", 
     main = "Estimación Puntual", ylim = c(80, 180))

lines(bmi_values, y_values_h45, col = "red", lty = 1, lwd = 4)
lines(bmi_values, y_values_h65, col = "green", lty = 1, lwd = 4)

lines(bmi_values, y_values_m30, col = "blue", lty = 2, lwd = 4)
lines(bmi_values, y_values_m45, col = "red", lty = 2, lwd = 4)
lines(bmi_values, y_values_m65, col = "green", lty = 2, lwd = 4)


datos_filtrados <- ARTERIAL[ARTERIAL$age %in% c(30, 45, 62), ]


colores <- ifelse(datos_filtrados$age == 30, "red", 
                  ifelse(datos_filtrados$age == 45, "blue", "green"))


formas <- ifelse(datos_filtrados$sex == "HOMBRE", 16, 17) 


points(datos_filtrados$bmi, datos_filtrados$bpsystol, col = colores, pch = formas, cex = 1.2)


legend("bottomright", 
       inset = c(-0.3, 0),  
       xpd = TRUE,
       legend = c("Hombre 30 años", "Hombre 45 años", "Hombre 65 años", 
                  "Mujer 30 años", "Mujer 45 años", "Mujer 65 años",
                  "Edad 30 años", "Edad 45 años", "Edad 62 años", 
                  "Hombres", "Mujeres"), 
       col = c("blue", "red", "green", "blue", "red", "green", 
               "red", "blue", "green", "black", "black"), 
       lty = c(1, 1, 1, 2, 2, 2, NA, NA, NA, NA, NA), 
       pch = c(NA, NA, NA, NA, NA, NA, 16, 16, 16, 16, 17), 
       cex = 0.8, box.lwd = 0.5)


#CONCLUSIONES:
#En general podemos observar como si existe una relacion entre un IMC alta con una presion sistolica ALTA, no solo
#graficamente si no tamien comprobada por la prueba de hipotesis realizada anteriormente.
#Sin embargo podemo observar tambien que la edad y el sexo inluye pues los hombres se ven más afectados en su presion
#sistolica d eacuerdo a su IMC que las mujeres, a su vez observamos que a mayor edad, mayor influencia del IMC
#en la presión sistolica.
# En las lineas de predicciones podemos observar el modelo dada cierta edad y cierto sexo



#Recta verde continua
# E(bpsystol)^(0.5));bmi,(age)^(4))=62,sex=hombre)=b0 + b1bmi + b2(62)^(4) 
#Este modelo representa los parametros para sexo hombre y edad de 62 años

#Recta verde punteada
# E(bpsystol)^(0.5));bmi,(age)^(4))=62,sex=mujer)=b0 + b1bmi + b2(62)^(4) + b3
#Este modelo representa los parametros para sexo mujer y edad de 62 años


#Recta roja continua
# E(bpsystol)^(0.5));bmi,(age)^(4))=45,sex=hombre)=b0 + b1bmi + b2(45)^(4) 
#Este modelo representa los parametros para sexo hombre y edad de 45 años


#Recta azul continua
# E(bpsystol)^(0.5));bmi,(age)^(4))=30,sex=hombre)=b0 + b1bmi + b2(30)^(4) 
#Este modelo representa los parametros para sexo homrey edad de 30 años

#Recta roja punteada
# E(bpsystol)^(0.5));bmi,(age)^(4))=45,sex=mujer)=b0 + b1bmi + b2(45)^(4) + b3
#Este modelo representa los parametros para sexo mujer y edad de 45 años

#Recta azul punteada
# E(bpsystol)^(0.5));bmi,(age)^(4))=30,sex=mujer)=b0 + b1bmi + b2(30)^(4) + b3
#Este modelo representa los parametros para sexo mujer y edad de 30 años

#Asi podemos observar como aquellas rectas asociadas a hombres y a mayores edades presentan mayor respuesta a la
#presion sistolica en función del aumento del IMC.











###########################################           REGRESIÓN GAMMA






#i. Explorando los diferentes modelos lineales generalizados comúnmente usados cuando la variable dependiente
#es continua (normal, gamma, inversa gaussiana), presente un modelo que le parezca adecuado
#para modelar E(bpsystol; bmi, sex, age).
# Verificar si los paquetes están instalados





ARTERIAL2 <-read.csv("Preg1A.csv")

summary(ARTERIAL2)

ARTERIAL2$sex=factor(ARTERIAL2$sex, levels=c(1,2), labels=c("HOMBRE","MUJER") )
summary(ARTERIAL2)



#a. Considere por simplicidad que no hay interacción entre las covariables del modelo.
#b. Deberá explorar la transformación de ambas covariables: bmi y age.


#CONSTRUCCIÓN DE MAYAS PARA EL PROCEDIMEITNO DE AUTOMATIZACION
malla_poli <- seq(from = 1, to = 5, by = 1)
malla_pot <- seq(from = -3, to = 3, by = 0.5)

(IMCPoli <- cbind("IMCpoly", malla_poli))
(IMCPot  <- cbind("IMCpot", malla_pot))
(EDADPoli <- cbind("EDADpoly", malla_poli))
(EDADPot  <- cbind("EDADpot", malla_pot))

(CompLin <- rbind(IMCPoli, IMCPot, EDADPoli, EDADPot))



Distribuciones <- c("gaussian", "Gamma", "inverse.gaussian")
FunLigas <- c("identity", "log", "inverse", "1/mu^2")

nFunLigas <- length(FunLigas)
nDist <- length(Distribuciones)
nIMC <- dim(rbind(IMCPoli, IMCPot))[1]  # 18 transformaciones de BMI
nEDAD <- dim(rbind(EDADPoli, EDADPot))[1] # 18 transformaciones de AGE

ModelList <- list(NA)
AICList <- list(NA)
BICList <- list(NA)
FormList <- list(NA)


#PROCESO DE AUTOMATIZACIÓN, ME BASE EN EL CODIGO DEL PROFESOR Y EN APOYO DE IA
index <- 0
for (i in 1:nIMC) {
  for (j in 1:nEDAD) {
    
    if (CompLin[i,1] == "IMCpoly") {
      trans_bmi <- paste0("poly(bmi,", CompLin[i,2], ", raw=TRUE)")
    } else {
      if (CompLin[i,2] == 0) {
        trans_bmi <- "I(log(bmi))"
      } else {
        trans_bmi <- paste0("I(bmi^(", CompLin[i,2], "))")
      }
    }
    
    
    if (CompLin[j,1] == "EDADpoly") {
      trans_age <- paste0("poly(age,", CompLin[j,2], ", raw=TRUE)")
    } else {
      if (CompLin[j,2] == 0) {
        trans_age <- "I(log(age))"
      } else {
        trans_age <- paste0("I(age^(", CompLin[j,2], "))")
      }
    }
    
    
    formstring <- paste0("bpsystol ~ ", trans_bmi, " + ", trans_age, " + sex")
    form <- as.formula(formstring)
    
    for(j in 1:nDist){
      for(l in 1:nFunLigas){
        
        if(FunLigas[l]=="1/mu^2"){
          if(Distribuciones[j]=="inverse.gaussian"){
            index=index+1
            Dist=get(Distribuciones[j])  
            Mod.A.Prueba=glm(form, data=ARTERIAL2, family = Dist(link=FunLigas[l]))
            ModelList[[index]]=Mod.A.Prueba
            AICList[[index]]=AIC(Mod.A.Prueba)
            BICList[[index]]=BIC(Mod.A.Prueba)
            FormList[[index]]=formstring
          }
        }else{
          index=index+1
          Dist=get(Distribuciones[j])
          Mod.A.Prueba=glm(form, data=ARTERIAL2, family = Dist(link=FunLigas[l]))
          ModelList[[index]]=Mod.A.Prueba
          AICList[[index]]=AIC(Mod.A.Prueba)
          BICList[[index]]=BIC(Mod.A.Prueba)
          FormList[[index]]=formstring
        }
      }
    }
  }
}  
#Verificar que se modelaron todos los posibles modelos a partir de las diferentes
#combinaciones de las transformaciones de IMC y EDAD

total_modelos <- length(ModelList)
total_modelos

##?ndice del modelo con menor AIC

MinAIC=which.min(unlist(AICList))
ModMinAIC=ModelList[[MinAIC]]
ModMinAIC$family

AICList[[MinAIC]]
BICList[[MinAIC]]
FormList[[MinAIC]]


#Los otros modelos
AICs=unlist(AICList)
DatAICs=cbind(Index=1:length(AICs), AICs)
DatAICs=DatAICs[order(AICs),]


ModAIC2=ModelList[[DatAICs[3,1]]]
ModAIC2$family

AICList[[DatAICs[3,1]]]
BICList[[DatAICs[3,1]]]
FormList[[DatAICs[3,1]]]


#c. Deberá describir el procedimiento y criterio usado para seleccionar el modelo.
#La explicacion la hago en el MARKDOWN.




#Deberá argumentar que el modelo satisface los supuestos.

#Verificacion de supuestos.

#Aqui en DHARMA:
# GRAFICA 1 COMPONENTE ALEATORIO Y FUNCION LIGA:NO RECHAZAR H0 implica que NO EXISTE EVIDENCIA ENCONTRA DEL MOEDLO
#ES decir puedo usar el Modelo.

#GRAFICA 2 COMPONENTE LINEA: LA grafica esta bien, Existe linealidad

# I M P OR T AN TE
#Si tenemos 2 o 3 modelos que pasan los SUPUESTOS se debe elegir el de
#MEJOR INTERPRETACION.



#MODELOGL2
MODELOGL2=glm(bpsystol ~ bmi + I(age^(4)) + sex, data = ARTERIAL2, family = Gamma(link="identity"))
library(DHARMa)
set.seed(123)
MODELOGL2Residualesres <- simulateResiduals(fittedModel = MODELOGL2)
X11()
plot(MODELOGL2Residualesres)



# EL MODELOGL2 Gana por pasar supuestos con MEJOR LINEALIDAD.
# Tambien gana por MEJOR INTERPRETACION


# VERIFICAR que la funcion liga IDENTIDAD no genera valores negativos para la media:
modelo_gamma <- glm(bpsystol ~ bmi + I(age^4) + sex, 
                    family = Gamma(link = "identity"), 
                    data = ARTERIAL2)


predicciones <- predict(modelo_gamma, type = "response")

any(predicciones < 0)  # Devuelve TRUE si hay predicciones negativas
sum(predicciones < 0)   # Cantidad de valores negativos

# Como no se generan predicciones negativas lo cual no es posible para la dist Gamma entonces 
#podemos usar la funcion liga identidad sin problema.




#e. Deberá indicar con claridad cuál es la expresión matemática que se usa para modelar
#E(bpsystol; bmi, sex, age).

#Bpsystol ~ Gamma(m,phi)
#m = E(bpsystol;bmi,(age)^(4)),sex)=b0 + b1bmi + b2(age)^(4) + b3sex




# ii. Repita los incisos iii) y iv) de la pregunta 1 con el modelo en i).

MODELOGL2=glm(bpsystol ~ bmi + I(age^(4)) + sex, data = ARTERIAL2, family = Gamma(link="identity"))

#iii. ¿Se puede indicar que para una persona de cierta edad y sexo, tener un índice de masa corporal alto
#se asocia con una alta presión arterial sistólica? Argumente su respuesta, indicando con claridad la
#prueba o pruebas de hipótesis usadas y las hipótesis que se están contrastando.

#E(bpsystol;bmi=X,(age)^(4))=C1,sex=C2)=b0 + b1X + b2C1 + b3C2 < E(bpsystol;bmi=X+C3,(age)^(4))=C1,sex=C2)=b0 + b1(X+C3) + b2C1 + b3C2
#en terminos d elos betas se tiene:

#b0 + b1X + b2C1 + b3C2 < b0 + b1(X+C3) + b2C1 + b3C2

#Es decir queremos comprobar si: 0 < b1

#Para eso haremos uso de la PRUEBA T, contrastando la siguiente hipotesis:

# H0: b1 ≤ 0 VS  Ha: b1 > 0


K=matrix(c(0,1,0,0), ncol=4, nrow=1, byrow=TRUE)
m=c(0)
summary(glht(MODELOGL2, linfct=K, rhs=m, alternative="greater"))

#Estimate Std. Error z value Pr(>z)    
#1 <= 0    1.210      0.136    8.91 <2e-16 ***

#Se rechaza H0 por tanto se cumple Ha: b1 > 0, y por tanto podemos concluir que
#igual con este modelo implica que podemos afirmar que
#Dada una cierta edad y sexo, un IMC alto en promedio se asocia con una presión sistólica alta.




#iv. Para complementar la interpretación de los resultados del inciso iii), presente una gráfica resumen con
#la estimación puntual asociada a la relación entre bpsystol y bmi. Para esto considere sólo tres posibles
#edades: 30, 45 y 65, así como la diferenciación entre mujeres y hombres. Comente e interprete lo que
#observa en la gráfica, indicando con claridad a qué parámetro corresponde la curva/recta.



#GRAFICA DE DISPERSION Y DE PREDICCION PUNTUAL DEL MODELOGL2
X11()
par(mfrow = c(1, 2)) 

MODELOGL2=glm(bpsystol ~ bmi + I(age^(4)) + sex, data = ARTERIAL2, family = Gamma(link="identity"))

coeficientes <- coef(MODELOGL2)
prediccion_bpsystol <- function(bmi, coeficientes, edad, sex) {
  pred_bpsystol_0_5 <- coeficientes[1] + coeficientes[2] * bmi + coeficientes[3] * (edad^4) + coeficientes[4] * sex
  
}


bmi_min <- min(ARTERIAL2$bmi, na.rm = TRUE)
bmi_max <- max(ARTERIAL2$bmi, na.rm = TRUE)

bmi_values <- seq(bmi_min, bmi_max, by = 0.5)

y_values_h30 <- sapply(bmi_values, prediccion_bpsystol, coeficientes = coeficientes, edad = 30, sex = 0)
y_values_h45 <- sapply(bmi_values, prediccion_bpsystol, coeficientes = coeficientes, edad = 45, sex = 0)
y_values_h65 <- sapply(bmi_values, prediccion_bpsystol, coeficientes = coeficientes, edad = 65, sex = 0)

y_values_m30 <- sapply(bmi_values, prediccion_bpsystol, coeficientes = coeficientes, edad = 30, sex = 1)
y_values_m45 <- sapply(bmi_values, prediccion_bpsystol, coeficientes = coeficientes, edad = 45, sex = 1)
y_values_m65 <- sapply(bmi_values, prediccion_bpsystol, coeficientes = coeficientes, edad = 65, sex = 1)

plot(bmi_values, y_values_h30, type = "l", col = "blue", lty = 1, lwd = 2, 
     xlab = "bmi", ylab = "bpsystol", 
     main = "Predicción de bpsystol para diferentes edades y sexos",
     ylim = c(80, 180)) 


lines(bmi_values, y_values_h45, col = "red", lty = 1,lwd = 2)   
lines(bmi_values, y_values_h65, col = "green", lty = 1,lwd = 2) 

lines(bmi_values, y_values_m30, col = "blue", lty = 2,lwd = 2)  
lines(bmi_values, y_values_m45, col = "red", lty = 2,lwd = 2)   
lines(bmi_values, y_values_m65, col = "green", lty = 2,lwd = 2)


legend("bottomright", 
       legend = c("Hombre 30", "Hombre 45", "Hombre 62", 
                  "Mujer 30", "Mujer 45", "Mujer 62"), 
       col = c("blue", "red", "green", "blue", "red", "green"), 
       lty = c(1, 1, 1, 2, 2, 2), 
       cex = 0.8)   

datos_filtrados <- ARTERIAL2[ARTERIAL2$age %in% c(30, 45, 62), ]


colores <- ifelse(datos_filtrados$age == 30, "red", 
                  ifelse(datos_filtrados$age == 45, "blue", "green"))


formas <- ifelse(datos_filtrados$sex == "HOMBRE", 16, 17)  


plot(datos_filtrados$bmi, datos_filtrados$bpsystol, 
     col = colores,          
     pch = formas,           
     xlab = "Índice de Masa Corporal (BMI)", 
     ylab = "Presión Sistólica (bpsystol)", 
     main = "Gráfico de Dispersión: bpsystol vs bmi",
     xlim = c(15,40), 
     ylim = c(80, 180))
legend("topright",                          
       legend = c("Edad 30", "Edad 45", "Edad 62"),  
       col = c("red", "blue", "green"),      
       pch = 16,                             
       title = "Leyenda por Edad",
       cex = 0.8,                            
       box.lwd = 0.5)

legend("bottomright",                       
       legend = c("Hombres (círculos)", "Mujeres (triángulos)"),  
       col = c("black", "black"),            
       pch = c(16, 17),                      
       title = "Leyenda por Sexo",
       cex = 0.8,                            
       box.lwd = 0.5)






# nuevamente con este nuevo modelo de lineal general podemos concluir que:
#CONCLUSIONES:
#En general podemos observar como si existe una relacion entre un IMC alta con una presion sistolica ALTA, no solo
#graficamente si no tamien comprobada por la prueba de hipotesis realizada anteriormente.
#Sin embargo podemo observar tambien que la edad y el sexo influye pues los hombres se ven más afectados en su presion
#sistolica d eacuerdo a su IMC que las mujeres, a su vez observamos que a mayor edad, mayor influencia del IMC
#en la presión sistolica.
# En las lineas de predicciones podemos observar el modelo dada cierta edad y cierto sexo


# En general las predicciones no cambiaron mucho entre el Modelo de regresionmultiple y el nuevo
#Modelo lineal general, para determinar cual es mas eficiente podemos tomar en cuenta
#la complejidad de ambos modelos, la facilidad de su interpretación y el AIC de cada uno 






#iii. Comparando el modelo en i) con el usado en la pregunta 1, compare las conclusiones e interpretaciones
#que se pueden obtener e indique qué modelo prefiere usar. Argumente con claridad su respuesta, por
#ejemplo, debe incluir los valores de AIC o BIC, así como ventajas y desventajas en la interpretación.


#El modelo de regresion lineal multiple de la pregunta 1 esta dado por:
MODELORM = lm(I((bpsystol)^(0.5)) ~ bmi + I((age)^(4)) + sex, data=ARTERIAL2)

#EL modelo Lineal General esta dado por:

MODELOGL2=glm(bpsystol ~ bmi + I(age^(4)) + sex, data = ARTERIAL2, family = Gamma(link="identity"))
#Notemos que la escala de la variable independiente en el MODELORM esta en una escala RAIZ CUADRADA
#Por tanto debemos llevarlo a una escala SIN raiz cuadrada, esto es asi porque queremos llevar la escala
#Del MODELORM a la escala del MODELO GL2, el cual no tiene transformación en su variable dependiente
#Para ello primero pasamos el MODELORM a la escala del MODELOGL2 y calculamos su AIC: 




#TUVE LA SUERTE DE QUE LA ESCALA QUE DEIA TRANSFORMAR, FUE LA MISMA ESCALA QUE LE PROFESOR EXPLICO EN CLASE
#ES DECIR PASAR DE UNA ESCALA RAIZ CUADRADA A UNA SIN RAIZ CUADRADA
#POR TANTO AQUI SE USA TAL CUAL EL CODIGO DEL PROFESOR PARA RESOLVER LA ESCALA
loglikY=sum( log( (dnorm(sqrt(ARTERIAL2$bpsystol), MODELORM$fitted.values, sigma(MODELORM))+dnorm(-sqrt(ARTERIAL2$bpsystol), MODELORM$fitted.values, sigma(MODELORM))  )*(1/(2*sqrt(ARTERIAL2$bpsystol)))  ) )
(AICY=-2*(loglikY)+2*(2+1))


#AIC MODELORM = 3532

AIC(MODELOGL2)
#AIC MODELOGL2 = 3532

#Notemos que amos modelos tienen el mismo AIC, lo cual tiene todo el sentido pues al pasar la escala
#del MODELORM a la escala del MODELOGL2 tienen practicamente la misma estructura matematica:

#LAS CONCLUSIONES DE TODO ESTE ASUNTO ESTAN EN EL RMARKDOWN.

















###########################################           REGRESIÓN BERNOULLI




INSECTOS <-read.csv("Preg3vA.csv")

summary(INSECTOS)

n=c(2,50-2,4, 49-4,18,47-18, 18, 38-18,23,29-23,34,50-34,
    1,50-1,13,49-13,19,50-19,26,50-26,40,50-40,29,50-39,
    27,50-27,36,50-36,45,50-45,47,50-47,47,50-47,49,50-49)
Y=c("Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No",
    "Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No",
    "Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No")
Z=c(2, 2, 2.64, 2.64, 3.48, 3.48, 4.59, 4.59,6.06,6.06,8,8,
    2, 2, 2.64, 2.64, 3.48, 3.48, 4.59, 4.59,6.06,6.06,8,8,
    2, 2, 2.64, 2.64, 3.48, 3.48, 4.59, 4.59,6.06,6.06,8,8)
X=c("A","A","A","A","A","A","A","A","A","A","A","A",
    "B","B","B","B","B","B","B","B","B","B","B","B",
    "C","C","C","C","C","C","C","C","C","C","C","C")

#DATOS AGRUPADOS
DatosMuertes= data.frame(cbind(n,Y,Z,X))
summary(DatosMuertes)
DatosMuertes$n=as.numeric(as.character(DatosMuertes$n))
summary(DatosMuertes)
str(DatosMuertes)


#DATOS DESAGRUPADOS
head(DatosMuertes)
library(tidyverse)
Datos=DatosMuertes %>% group_by(Y,Z,X) %>%
  do( data.frame(unos= rep(1, .$n)) )
head(Datos)
sum(DatosMuertes$n)
summary(Datos)
Datos=as.data.frame(Datos)
Datos[sapply(Datos, is.character)] <- lapply(Datos[sapply(Datos, is.character)],                                              as.factor)
summary(Datos)
levels(Datos$Y)
str(Datos)


as.numeric(Datos$Y)



Datos$X <- as.factor(Datos$X)


Datos$Z <- as.numeric(as.character(Datos$Z))

str(Datos)




#Presente una gráfica de dispersión en donde en el eje x se incluye la dosis del insecticida y en el eje
#y la proporción de insectos muertos observados para cada combinación dosis-insecticida, distinguiendo
#con un color el insecticida asociado. Describa lo que se observa.



library(ggplot2)
library(dplyr)

#PARA LA GRAFICA NECESITÉ CALCULAR LA PROPORCION DE EXITOS POR CADA COMINACION DE DOSIS X INSECTICIDAD

Datos$Y <- ifelse(Datos$Y == "Yes", 1, 0)

DatosBin <- Datos %>%
  group_by(Z, X) %>%
  summarise(Proporcion_muertos = mean(Y))


X11()
ggplot(DatosBin, aes(x = Z, y = Proporcion_muertos, color = X)) +
  geom_point(size = 4) + 
  labs(x = "Dosis", y = "Proporción de insectos muertos", color = "Insecticida") +
  theme_minimal() +
  scale_color_manual(values = c("red", "green", "blue")) 









#Ajuste modelos para datos binarios (ligas: logit, probit, cloglog) en donde incluya como covariables a
#Insecticide y lnD (lnD = ln(Deposit)), así como su interacción. Describa las expresiones del componente
#lineal o sistemático para cada insecticida como función de lnD. Indique si alguno de los modelos parece
#adecuado para realizar el análisis deseado.

summary(Datos$Z)


MODELOGIT=glm(Y~X*log(Z), family = binomial(link="logit"), data=Datos)
summary(MODELOGIT)

MODEPROB=glm(Y~X*log(Z), family = binomial(link="probit"), data=Datos)
summary(MODEPROB)

MODECLL=glm(Y~X*log(Z), family = binomial(link="cloglog"), data=Datos)
summary(MODECLL)

#GUIANDONOS EN EL AIC DE LOS 3 MODELOS PODEMOS CONCLUIR QUE:
#CON UN DE AIC: 805.8 EL MODELO CON LIGA PROBIT RESULTA MÁS ADECUADO.






#Ajuste modelos para datos binarios (ligas: logit, probit, cloglog) en donde adicional a las covariables
#incluidas en ii), también incluya a la interacción de Insecticide con lnD2. Describa las expresiones
#del componente lineal o sistemático para cada insecticida como función de lnD. Indique si alguno de
#los modelos parece adecuado para realizar el análisis deseado y argumente si tiene alguna ventaja la
#inclusión de los términos cuadráticos en el modelo.

# Crear lnD2 como el cuadrado de lnD
Datos$lnD2 <- (log(Datos$Z))^2

# Ajustar modelo logit
MODELOGIT <- glm(Y ~ X * log(Z) + X:lnD2, family = binomial(link = "logit"), data = Datos)
summary(MODELOGIT)

# Ajustar modelo probit
MODEPROB <- glm(Y ~ X * log(Z) + X:lnD2, family = binomial(link = "probit"), data = Datos)
summary(MODEPROB)

# Ajustar modelo cloglog
MODECLL <- glm(Y ~ X * log(Z) + X:lnD2, family = binomial(link = "cloglog"), data = Datos)
summary(MODECLL)




#PARA LOS MODELOS CON lND AL CUADRADO TENEMOS QUE AQUELLOS CON UN MEJOR AIC ES EL MODELO
#CON LIGA LOGIT Y PROBIT CON UN AIC DE 798 CADA UNO.


#ENTONCES TENEMOS LOS MODELOS:



MODEPROB1=glm(Y~X*log(Z), family = binomial(link="probit"), data=Datos)
summary(MODEPROB)

coef(MODEPROB1)

library(multcomp)
K = matrix(c(0, 1, 0, 0, 0, 0,   # Probar si XB = 0
             0, 0, 1, 0, 0, 0,   # Probar si XC = 0
             0, 0, 0, 1, 0, 0,   # Probar si log(Z) = 0
             0, 0, 0, 0, 1, 0,   # Probar si XB:log(Z) = 0
             0, 0, 0, 0, 0, 1),  # Probar si XC:log(Z) = 0
           ncol=6, byrow=TRUE)
m = c(0, 0, 0, 0, 0)
summary(glht(MODEPROB1, linfct=K, rhs=m), test=Chisqtest())


#EN ESTE CASO SE RECHAZA H0, ES DECIR LOS COEFICIENTES SON SIGNIFICATIVOS, POR TANTO 
#COOPERAN EN EL MODELO



MODELOGIT2 <- glm(Y ~ X * log(Z) + X:lnD2, family = binomial(link = "logit"), data = Datos)
summary(MODELOGIT)
coef(MODELOGIT2)
library(multcomp)
K = matrix(c(0,1,0,0,0,0,0,0,0,   # Probar si XB = 0
             0,0,1,0,0,0,0,0,0,   # Probar si XC = 0
             0,0,0,1,0,0,0,0,0,   # Probar si log(Z) = 0
             0,0,0,0,1,0,0,0,0,   # Probar si XB:log(Z) = 0
             0,0,0,0,0,1,0,0,0,
             0,0,0,0,0,0,1,0,0,
             0,0,0,0,0,0,0,1,0,
             0,0,0,0,0,0,0,0,1
),  # Probar si XC:log(Z) = 0
ncol=9, byrow=TRUE)
m = c(0, 0, 0, 0, 0,0,0,0)
summary(glht(MODELOGIT2, linfct=K, rhs=m), test=Chisqtest())

#EN ESTE CASO TAMBIEN SE RECHAZA H0, ES DECIR LOS COEFICIENTES SON SIGNIFICATIVOS, POR TANTO 
#COOPERAN EN EL MODELO







MODEPROB2 <- glm(Y ~ X * log(Z) + X:lnD2, family = binomial(link = "probit"), data = Datos)
summary(MODEPROB)


library(multcomp)
K = matrix(c(0,1,0,0,0,0,0,0,0,   # Probar si XB = 0
             0,0,1,0,0,0,0,0,0,   # Probar si XC = 0
             0,0,0,1,0,0,0,0,0,   # Probar si log(Z) = 0
             0,0,0,0,1,0,0,0,0,   # Probar si XB:log(Z) = 0
             0,0,0,0,0,1,0,0,0,
             0,0,0,0,0,0,1,0,0,
             0,0,0,0,0,0,0,1,0,
             0,0,0,0,0,0,0,0,1
),  # Probar si XC:log(Z) = 0
ncol=9, byrow=TRUE)
m = c(0, 0, 0, 0, 0,0,0,0)
summary(glht(MODEPROB2, linfct=K, rhs=m), test=Chisqtest())

#EN ESTE CASO TAMBIEN SE RECHAZA H0, ES DECIR LOS COEFICIENTES SON SIGNIFICATIVOS, POR TANTO 
#COOPERAN EN EL MODELO



#VERIFICACIÓN DE SUPUESTOS.

#MODELO 1
MODEPROB1=glm(Y~X*log(Z), family = binomial(link="probit"), data=Datos)

library(statmod)
MODEPROB1qr <- qresid( MODEPROB1)
X11()
qqnorm( MODEPROB1qr, las=1 ); qqline( MODEPROB1qr) 
nortest::lillie.test(MODEPROB1qr)
shapiro.test(MODEPROB1qr)
library(DHARMa)  #Los residuales simulados también son útiles en este caso
set.seed(123)
MODEPROB1D <- simulateResiduals(fittedModel = MODEPROB1)
X11()
plot(MODEPROB1D )

#EN LOS TEST LILLIEFORS Y SHAPIRO, NO SE RECHAZA H0, ES PLAUSIBLE SUPONER QUE LOS RESIDUALES TIENEN NORMALIDAD
#Aqui en DHARMA:
# GRAFICA 1 COMPONENTE ALEATORIO Y FUNCION LIGA:NO RECHAZAR H0 implica que NO EXISTE EVIDENCIA ENCONTRA DEL MOEDLO
#ES decir puedo usar el Modelo.

#GRAFICA 2 COMPONENTE LINEA: LA grafica esta bien, Existe linealidad

#COMO NO RECHAZAMOS H0, ENTONCES NO EXISTE EVIDENCIA ENCONTRA DE EL COMPONENTE ALEATORIO Y LA
#FUNCIÓN LIGA, ADEMÁS DE QUE LA LINEALIDAD TAMBIEN ESTA MUY PRESENTE.





#MODELO2
MODELOGIT2 <- glm(Y ~ X * log(Z) + X:lnD2, family = binomial(link = "logit"), data = Datos)
library(statmod)
MODELOGIT2qr <- qresid( MODELOGIT2)
X11()
qqnorm( MODELOGIT2qr, las=1 ); qqline( MODELOGIT2qr) 
nortest::lillie.test(MODELOGIT2qr)
shapiro.test(MODELOGIT2qr)
library(DHARMa)  #Los residuales simulados también son útiles en este caso
set.seed(123)
MODELOGIT2D <- simulateResiduals(fittedModel = MODELOGIT2)
X11()
plot(MODELOGIT2D )

#AQUI CON LA PRUEBA LILLIEFORS TENEMOS QUE SE RECHAZA H0, POR TANTO SEGUN ESTA PRUEBA LOS RESIDUALES NO SON NORMALES
#CON SHAPIRO TENEMOS POR POCO QUE SI RECAHZA H0, EN COMBINACIÓN DE AMBAS PODRIAMOS DECIR QUE 
#NORMALIDAD DE LOS RESIDUALES NO ES CONCLUYENTE.


#POR OTRO LADO CON DHARMA TENEMOS QUE LA ALEATORIAD Y LA FUNCIÓN LIGA NO TIENEN PROBLEMAS.
#EL COMPONENTE LINEAL ES MENOS AJUSTADO QUE EN EL MODELO ANTERIOR.



#MODELO3
MODEPROB2 <- glm(Y ~ X * log(Z) + X:lnD2, family = binomial(link = "probit"), data = Datos)
library(statmod)
MODEPROB2qr <- qresid( MODEPROB2)
X11()
qqnorm( MODEPROB2qr, las=1 ); qqline( MODEPROB2qr) 
nortest::lillie.test(MODEPROB2qr)
shapiro.test(MODEPROB2qr)
library(DHARMa)  #Los residuales simulados también son útiles en este caso
set.seed(123)
MODEPROB2D <- simulateResiduals(fittedModel = MODEPROB2)
X11()
plot(MODEPROB2D )

#EN ESTE CASO CON SHAPIRO Y LILLIFORS NO SE RECHAZAN H0, POR TANTO EN AMBAS PRUEBAS SE ACEPTA NORMALIDAD EN LOS RESIDUALES
#EN DHARMA SE TIENE QUE EL COMPONENTE ALEATORIO Y LA FUNCION LIGA NO TIENEN PROBLEMAS.
#AQUI SE VE AFECTADA UN POCO LA LINEALIDAD EN COMPARAICON AL PRIMER MODELO


AIC(MODEPROB1)
AIC(MODELOGIT2)
AIC(MODEPROB2)

#DADO QUE TENEMOS LOS SIGUIENTES AIC'S
#AIC(MODEPROB1)
# 805.8
#AIC(MODELOGIT2)
# 798
# AIC(MODEPROB2)
# 798

#EL MODELO QUE MEJOR SUPERO LOS SUPUESTOS D EINFERENCIA FUE EL MODELO MODEPROB1
#LOS OTROS 2 MODELOS NO ESTAN TAN MAL EN LOS SUPUESTOS Y TIENEN MEJOR AIC.
#COMO EL MODELO MODEPROB2 FUE EL QUE MEJOR SUPERO LOS SUPUESTOS DE INFERENCIA Y SU
#AIC NO ES TAN ALEJADO DEL AIC DE LOS OTROS 2 MODELOS VAMOS A ESCOGER DICHO MODELO
#PRRA PODER RESOLVER TODO EL PROBLEMA.












################################################## REGRESIÓN POISSON Y BINOMIAL NEGATIVA.


CANCER <-read.csv("Preg4.csv")

options(digits=4)  

library(multcomp)

CANCER <-read.csv("Preg4.csv")



#Presente una gráfica de dispersión en donde en el eje x se incluyan los grupos de edad (ordenados
#de menor edad a mayor) y en el eje y la tasa de incidencia (Cases/Pop) por cada cruce Age-City,
#distinguiendo con un color la Ciudad. Describa lo que se observa.



# Convertir a factor
CANCER$Age <- factor(CANCER$Age, levels = c("40-54", "55-59", "60-64", "65-69", "70-74"))
CANCER$City <- factor(CANCER$City, levels = c("Fredericia", "Horsens", "Kolding", "Vejle"))

str(CANCER)
summary(CANCER)





CANCER$TasaIncidencia <- CANCER$Cases / CANCER$Pop  

X11()
ggplot(CANCER, aes(x = Age, y = TasaIncidencia, color = City)) +
  geom_point(size = 3, alpha = 0.7) +
  labs(x = "Edades", y = "Tasa de Incidencia", title = "Dispersión de la Tasa de Incidencia por Edad y Ciudad") +
  theme_minimal() +
  scale_x_discrete()


#ii. Como un primer modelo considere la distribución Poisson con liga logarítmica y las covariables Age y
#City, así como su interacción. Dado que las dos covariables son categóricas, este modelo con interacciones
#tiene muchos parámetros y es deseable trabajar con uno más simple. Para esto considere un segundo
#modelo donde sólo se usa como covariable a Age. Realice una prueba de hipótesis para argumentar
#si es posible considerar el segundo modelo [recuerde que dado que los modelos son anidados, podría
#usar la función anova(mod1, mod2, test = ”Chisq”), también puede usar multcomp, pero hay muchos
#parámetros y podría ser tedioso]. Complemente su decisión con lo que se observa en la gráfica en i) y
#con medidas como AIC o BIC.


CANCER$logtPop=log(CANCER$Pop)


#MODELO1
MODELO1 <- glm(Cases ~ Age*City+offset(logtPop), family=poisson(link="log"), data=CANCER)
summary(MODELO1)


#MODELO2
MODELO2 <- glm(Cases ~ Age+offset(logtPop) , family=poisson(link="log"), data=CANCER)
summary(MODELO2)
deviance(MODELO2)/df.residual(MODELO2)




#VAMOS A ANALIZAR SI PODEMOS QUEDARNOS CON EL MODELO MAS SIMPLE
#PARA ELLO HAREMOS UNA PRUEBA DE HIPOTESIS EN LA CUAL REQUERIMOS DE
#QUE LOS MODELOS CONTENGAN UNICAMENTE VARIABLES CATEGORICAS.
#EN NUESTRO CASO, ASI ES, EL MODELO SOLO TIENE VARIABLES CATEGORICAS
#LA PRUEA DE HIPOTESIS SERÁ A SIGUIENTE:


#H0: EL MODELO REDUCIDO (MODELO2)
#VS
#Ha: NECESITAMOS EL MODELO COMPLEJO.

anova(MODELO1, MODELO2, test = "Chisq")

#P VALUE = 0.32 NO SE RECHAZA H0, EL MODELO2 ES PLAUSIBLE DE IGUAL FORMA
#MODELO 1 AIC: 121.5
#MODELO 2 AIC: 108.5


#Considerando el modelo seleccionado en ii), ajuste un modelo binomial negativo. Compare ambos
#modelos e indique cuál podría ser adecuado para realizar el análisis deseado. Con el modelo seleccionado,
#calcule intervalos de confianza simultáneos de las tasas de incidencia para cada grupo de edad, incluya
#estos en la gráfica presentada en i). Comente los resultados, en particular si se puede indicar que a
#mayor edad existe mayor incidencia de cáncer de pulmón.

#MODELO2
MODELO2 <- glm(Cases ~ Age+offset(logtPop) , 
               family=poisson(link="log"), data=CANCER)
summary(MODELO2)

# Regla de dedo para analizar si hay un problema por 
# considerar el parámetro de dispersión igual a 1
deviance(MODELO2)/df.residual(MODELO2)

library(DHARMa)  
set.seed(1234)
MOD2res <- simulateResiduals(fittedModel = MODELO2)
X11()
plot(MOD2res )

library(MASS)
MODELO2B <- glm.nb(Cases ~ Age+offset(logtPop), 
                   data=CANCER, link="log")
summary(MODELO2B)
deviance(MODELO2B)/df.residual(MODELO2B)

library(DHARMa)  
set.seed(1234)
MOD2Bres <- simulateResiduals(fittedModel = MODELO2B)
X11()
plot(MOD2Bres )

#EL PARAMETRO DE DISPERSIÓN DE AMBOS MODELOS ES EL MISMO = 1.32
#EN CUANTO A LA PRUEBA DHARMA AMBOS PASAN LA VERIFICACIÓN DE SUPUESTOS SIN EMBARGO
#EL MODELO BINOMIAL TIENE MEJOR LINEALIDAD,
#EN CUANTO AIC TENEMOS:
#AIC POISSON = 108.5
#AIC BINOMIALN = 110.5
#DADO QUE EL AIC DE AMBOS REALMENTE ES SIMILAR Y EL BINOMIAL TIENE MEJOR LINEALIDAD USAREMOS ESE.






#calcule intervalos de confianza simultáneos de las tasas de incidencia para cada grupo de edad, incluya
#estos en la gráfica presentada en i).



  library(multcomp)
  
  K <- matrix(c(1, 0, 0, 0, 0,
                1, 1, 0, 0, 0,  
                1, 0, 1, 0, 0,  
                1, 0, 0, 1, 0,  
                1, 0, 0, 0, 1),
              ncol=5, byrow=TRUE)
  
  
  fitE <- glht(MODELO2B, linfct = K)
  

  fitci <- confint(fitE, level = 0.95)
  
  
  print(fitci)

# Pasar a TASAS DE INCIDENCIA
  
  exp(fitci$confint) 
  
  
  
#GRAFICA CON INTERVALOS DE CONFIANZA
  
  
  
  ci_tasas <- exp(fitci$confint[, "Estimate"])  
  ci_lwr <- exp(fitci$confint[, "lwr"])       
  ci_upr <- exp(fitci$confint[, "upr"])         
  
  
  ci_data <- data.frame(
    Age = 1:5,  
    TasaIncidencia = ci_tasas,  
    lwr = ci_lwr,  
    upr = ci_upr   
  )
  
  x11()
  
  ggplot(CANCER, aes(x = Age, y = TasaIncidencia, color = City)) +
    geom_point(size = 3, alpha = 0.7) +  
    geom_errorbar(data = ci_data, aes(ymin = lwr, ymax = upr), width = 0.2, color = "black") +  
    labs(x = "Edades", y = "Tasa de Incidencia", title = "Dispersión de la Tasa de Incidencia por Edad y Ciudad con Intervalos de Confianza") +
    theme_minimal() +
    scale_x_discrete()
  
  

  
#  iv. Los incisos anteriores usaron a la variable Age como categórica, sin embargo, eso dificulta un poco la
#  interpretación, además de que por su naturaleza esa variable se podría haber registrado sin categorizar.
#  Con los datos actuales, una aproximación sería usar el punto medio de cada intervalo de edad que define
#  las categorías de Age y usar la variable resultante como una variable continua, llámela Ageprima. Ajuste
#  modelos usando la distribución Poisson y Binomial Negativa con la covariable Ageprima, también
#  considere la opción de incluir a Ageprima2. Entre esos 4 modelos indique cuál podría ser adecuado
#  para realizar el análisis. Con ese modelo indique si a mayor edad existe mayor incidencia de cáncer de
#  pulmón, por ejemplo, argumentando si la función es creciente considerando que el intervalo de edad
#  que es de interés es entre 40 y 74 años. Presente una gráfica que complemente su análisis.
  
  
  

#AQUI VAMOS A CALCULAR EL PUNTO MEDIO DE CADA GRUPO DE EDAD PARA PODER TRABAJAR CON UNA VARIABLE CONTINUA EN LUGAR DE CATEGORICA
calcular_punto_medio <- function(intervalo) {
  limites <- as.numeric(unlist(strsplit(as.character(intervalo), "-")))
  return(mean(limites))
}


CANCER$Ageprima <- sapply(as.character(CANCER$Age), calcular_punto_medio)


head(CANCER)
str(CANCER)

MODEPOISS1 <- glm(Cases ~ Ageprima+offset(logtPop) ,family=poisson(link="log"), data=CANCER)
summary(MODEPOISS1)

MODEPOISS2 <- glm(Cases ~ Ageprima+I((Ageprima)^(2))+offset(logtPop) ,family=poisson(link="log"), data=CANCER)
summary(MODEPOISS2)

MODEBIN<- glm.nb(Cases ~ Ageprima+offset(logtPop), data=CANCER, link="log")
summary(MODEBIN)

MODEBIN2<- glm.nb(Cases ~ Ageprima+I((Ageprima)^(2))+offset(logtPop), data=CANCER, link="log")
summary(MODEBIN2)

#VERIFIACIÓN DE SUPUESTOS DE LOS 4 MODELOS

#MODEPOISS1

deviance(MODEPOISS1)/df.residual(MODEPOISS1)

library(DHARMa)  
set.seed(1234)
MODEPOISS1res <- simulateResiduals(fittedModel = MODEPOISS1)
X11()
plot(MODEPOISS1res )

#MODEPOISS2
deviance(MODEPOISS2)/df.residual(MODEPOISS2)

library(DHARMa)  
set.seed(1234)
MODEPOISS2res <- simulateResiduals(fittedModel = MODEPOISS2)
X11()
plot(MODEPOISS2res )

#MODEBIN
deviance(MODEBIN)/df.residual(MODEBIN)

library(DHARMa)  
set.seed(1234)
MODEBINres <- simulateResiduals(fittedModel = MODEBIN)
X11()
plot(MODEBINres )

#MODEBIN2

deviance(MODEBIN2)/df.residual(MODEBIN2)

library(DHARMa)  
set.seed(1234)
MODEBIN2res <- simulateResiduals(fittedModel = MODEBIN2)
X11()
plot(MODEBIN2res )


AIC(MODEPOISS1)
AIC(MODEPOISS2)
AIC(MODEBIN)
AIC(MODEBIN2)

# AIC(MODEPOISS1)
#[1] 107.9
#> AIC(MODEPOISS2)
#[1] 104.5
#> AIC(MODEBIN)
#[1] 109.9
#> AIC(MODEBIN2)
#[1] 106.5

#POR VERIFIACIÓN DE SUPUESTOS, EL MODELO BINOMIAL CUADRATICO Y POISSON CUADRATICO CON MEJORES, 
#POR LINEALIDAD ES MEJOR EL BINOMIAL CUADRATICO
#POR AIC ES MEJOR EL MODELO POISSON CUADRATICO, SIN EMBARGO EL BINOMIAL CUADRATICO NO SE ALEJA TANTO DEL DICHO ANTERIRO
#CONCLUSION, TRABAJAREMOS CON EL BINOMIAL CUADRÁTICO.



#Con ese modelo indique si a mayor edad existe mayor incidencia de cáncer de
#pulmón, por ejemplo, argumentando si la función es creciente considerando que el intervalo de edad
#que es de interés es entre 40 y 74 años.

MODEBIN2<- glm.nb(Cases ~ Ageprima+I((Ageprima)^(2))+offset(logtPop), data=CANCER, link="log")
summary(MODEBIN2)

#EL MODELO TEORICO ES:
#LN(E(CASES;AGEPRIMA))=B0 + B1AGEPRIMA +B2AGEPRIMA^2 + LN(Pop)
#PARA DETERMINAR SI ES CRECIENTE EN EL INTERVALO DE EDADES DE LOS 40 A 74, APLICAMOS LO APRENDIDO EN CALCULO
#DERIVAMOS LA FUNCIÓN Y DETERMINAMOS DONDE ES MAYOR QUE CERO:


#AL DERIVAR RESPECTO AGEPRIMA SE OBTIENE QUE:
#dLN(E(CASES,AGEPRIMA))/AGEPRIMA = B1+2B2AGEPRIMA

#CONSTRUIMOS UNA FUNCIÓN QUE AYUDE A SIMULAR LAS DERIVADAS PARA LOS DISTINTOS VALORES DEL RANGO DE EDAD.
coeficientes <- coef(MODEBIN2)
beta1 <- coeficientes["Ageprima"]
beta2 <- coeficientes["I((Ageprima)^(2))"]


derivada <- function(ageprima) {
  return(beta1 + 2 * beta2 * ageprima)
}


edad_rango <- seq(40, 74, by = 1)  
derivadas_rango <- sapply(edad_rango, derivada)


resultado <- data.frame(Edad = edad_rango, Derivada = derivadas_rango)


print(resultado)


#EXPLICACIÓN DE LO OBSERVADO EN MARKDOWN.





coeficientes <- coef(MODEBIN2)


edad_seq <- seq(min(CANCER$Ageprima), max(CANCER$Ageprima), by=1)


Pop_seq <- sapply(edad_seq, function(e) {
  val <- CANCER$Pop[CANCER$Ageprima == e]
  if (length(val) == 0) return(mean(CANCER$Pop)) else return(val)
})


Pop_seq_clean <- sapply(Pop_seq, function(val) {
  if (length(val) > 1) return(mean(val)) else return(val)
  return(val)
})


pred_log_seq <- coeficientes["(Intercept)"] + 
  coeficientes["Ageprima"] * edad_seq + 
  coeficientes["I((Ageprima)^(2))"] * (edad_seq^2) + log(Pop_seq_clean)


pred_cases_seq <- exp(pred_log_seq)  
pred_tasa_seq <- pred_cases_seq / Pop_seq_clean  


pred_df <- data.frame(Edad = edad_seq, TasaPredicha = pred_tasa_seq)


x11()
ggplot(CANCER, aes(x = Ageprima, y = TasaIncidencia, color = City)) + 
  geom_point(size = 3, alpha = 0.7) +  
  geom_line(data = pred_df, aes(x = Edad, y = TasaPredicha), color = "blue", size = 1) +  
  labs(x = "Edad", y = "Tasa de Incidencia", title = "Tasa de Incidencia: Datos vs Predicción") +
  theme_minimal()






















