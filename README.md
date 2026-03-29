# Reto 2 - Patrones de diseño

Segundo reto del curso de Patrones de Diseño

## 📝 Autores

Juan Esteban García Cardona

Juan Pablo Lasprilla Correa

## Repositorio

https://github.com/juanezcere/Reto-2---Patrones-de-dise-o

## 📌 Problemática

En Medellín, muchos artistas independientes enfrentan dificultades para organizar presentaciones, ya que deben coordinar múltiples actores (sonido, transporte, equipos,, personal), en procesos informales y fragmentados que limitan su circulación.

## 🔔 Reto

Crear una plataforma que permita a los artistas independientes coordinar de manera eficiente los recursos y actores necesarios para organizar sus presentaciones en la ciudad.

## ⚒️ Arquitectura planteada

Se propone desarrollar la aplicación con el estilo arquitectónico de microservicios basado en eventos (Event-Driven Architecture), ya que al tener tantos actores involucrados (artistas, proveedores, transportadores, etc.) las acciones de uno de ellos disparan necesidades en otros.

### 🟢 Ventajas

- Desacoplamiento Extremo: El microservicio de "artistas" no necesita saber que existe un microservicio de "transporte". Solo necesita publicar un evento.

- Escalabilidad Elástica: Si durante la época de la Feria de las Flores la demanda de sonido y transporte se dispara, puede ser escalado únicamente los servicios que procesan este tipo de eventos, manteniendo el resto de la aplicación con recursos mínimos.

- Resiliencia y Tolerancia a Fallos: Si el servicio de notificaciones falla, los eventos se quedan en una cola. Una vez el servicio se recupera, procesa los mensajes pendientes. El usuario no percibe una caída del sistema completo.

- Auditoría y Trazabilidad (Event Sourcing): Puede reconstruirse la historia de una presentación paso a paso: cuándo se solicitó el sonido, cuándo confirmó el transporte y en qué momento exacto surgió un problema.

### 🔴 Desventajas

- Complejidad de Consistencia (Eventually Consistent): Los cambios no se verán reflejados de inmediato en todos los módulos. Si un artista cancela, el servicio de transporte podría tardar un tiempo en enterarse. Esto requiere un manejo cuidadoso de la interfaz de usuario (UX) para no mostrar datos contradictorios.

- Dificultad en el Debugging: Rastrear un error es más complejo que en un monolito. Un error puede ser el resultado de una cadena de eventos que pasaron por cuatro servicios distintos.

- Curva de Aprendizaje: Requiere un cambio de mentalidad en el equipo de desarrollo. Ya no se piensa en "llamar a una función", sino en "reaccionar a un mensaje". La infraestructura de mensajería (Broker) se vuelve un componente crítico que debe ser administrado.

- Gestión de Transacciones Distribuidas: Si algo sale mal en la mitad del proceso (por ejemplo, el sonido confirma pero el transporte falla), no se puede hacer un "rollback" simple de base de datos. Se debera programar eventos de compensación para deshacer lo hecho.

## ✅ Especificaciones

### 📦 Database

Base de datos de tipo relacional, independiente por microservicio.

### 💻 Backend

Código de backend en lenguaje de preferencia, distribuido en microservicios.

### 📱 Frontend

Código de frontend en lenguaje de preferencia, distribuido en microservicios.
