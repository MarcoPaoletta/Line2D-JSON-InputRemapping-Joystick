# Line2D - JSON - Input Remapping - Joystick
* Proyecto para utilizar nodo [Line2D](https://docs.godotengine.org/es/stable/classes/class_line2d.html), archivos [JSON](https://docs.godotengine.org/es/stable/classes/class_json.html), sistema de input remmaping, es decir, cambiar las entradas de teclado, y realizar un joystick para movil
* Cuando nos movemos con las teclas WASD por defecto, se creara un efecto de linea gracias al nodo Line2D teniendo tres colores
* Al presionar la tecla TAB, se abrira una ventana mediante la cual podremos cambiar las entradas de teclado
* En la parte inferior derecha, hay un joystick dedicado para mover el personaje en movil
---
# Manejo con el archivo JSON
* En esta ocasion, utilizamos archivos JSON para poder guardar informacion de una manera legible para el usuario y que asi pueda modificarla. Esto es distinto a la forma de almacenar datos presentes en [Dictionaries-Save-Load](https://github.com/MarcoPaoletta/Dictionaries-Save-Load/blob/master/rsc/gamehandler/gamehandler.gd) porque aqui se almacenan de una forma ilegible
* La ruta que se utiliza en Godot para almacenar archivos es *user://nombre_del_archivo*. En este caso es *user://data.json* y se encuentra en *C:\Users\usuario\AppData\Roaming\Godot\app_userdata\Line2D - JSON - Input Remapping - Joystick*
* Cuando abrimos el archivo JSON, nos encontramos con un diccionario almacenado en el. Toda la logica de guardado y cargado de datos se encuentra presente en [global.gd](https://github.com/MarcoPaoletta/Line2D-JSON-InputRemapping-Joystick/blob/master/rsc/global/global.gd)
<img height= 300px src = https://github.com/MarcoPaoletta/Line2D-JSON-InputRemapping-Joystick/blob/master/JSON.png>

## Datos que se pueden modificar en el JSON y son aplicados dentro del juego
* **keys:** son [scancodes](https://docs.godotengine.org/es/stable/classes/class_json.html) de cada tecla mediante los cuales el jugador se va a mover
* **background_color**: escala de colores en rgb, es decir, que se van a mezclar los colores rojo, verde y azul para el fondo
* **player_trail_color**: cada trail o rastro del jugador, siendo en total tres, tiene cada uno un color expresado en [hexadecimal](https://desafiohosting.com/que-es-codigo-colores-web/#Sistema_Hexadecimal)

---
# Descargar Godot Engine e importar el proyecto
---

## Descargar Godot Engine

* Accedemos al sitio oficial de [Godot Engine](https://godotengine.org/download) en la parte de descargas
* Seleccionamos nuestro sistema operativo
* Descargamos la **Standard version**
* Extraemos el archivo comprimido
* Esto nos dejara el ejecutable de Godot Engine

---

## Importar el proyecto

* Una vez descargado los archivos del proyecto, movemos la carpeta a una ruta de preferencia
* Abrimos Godot Engine y en la parte de la derecha buscamos el boton **Import** o **Importar**
* Escribimos la ruta del proyecto o buscamos manualmente en la carpeta del proyecto el archivo project.godot 
* Nos abrira el projecto y podremos ejecutarlo desde ahi tocando **F5** o en la parte superior derecha con el boton de play
