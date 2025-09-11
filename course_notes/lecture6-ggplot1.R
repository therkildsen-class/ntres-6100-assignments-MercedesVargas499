library(tidyverse)

mpg
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy, color=class, size=cyl), shape=5)

#si shape estuviera adentro de aes se aplicaria a una clase, tengo que elegir 
#por ej shape=trans para que se lo aplique a esa variable. 
#si lo pongo afuera se aplica a todos por igual, cambia la forma de todos 
#los puntos

ggplot(data=mpg)+
  geom_point(mapping=aes(x=cyl, y=hwy), color="red")

#se coloca afuera para que sea uniforme para todos
#vienen distintos colores en el paquete de R, buscar en google y colocar nombre

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ, y=hwy, color=class, size=cyl), shape=1) +
  geom_smooth(mapping=aes(x=displ, y=hwy))

#si quiero superponer graficos
#tambien como uso las mismas variables puedo dejar los () vacios

ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_point(mapping=aes(x=displ, y=hwy, color=class, size=cyl), shape=1) +
  geom_smooth()
#para eso tengo que poner en data las especificaciones de los ejes
#esto se hace para evitar repetir codigos

ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_point(mapping=aes(x=displ, y=hwy, color=class, size=cyl), shape=1) +
  geom_smooth() +
  facet_wrap(~year,nrow=2)+
  theme_classic()

  