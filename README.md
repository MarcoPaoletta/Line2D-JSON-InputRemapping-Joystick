# Line2D - JSON - Input Remapping - Joystick
* Proyecto para utilizar nodo [Line2D](https://docs.godotengine.org/es/stable/classes/class_line2d.html), archivos [JSON](https://docs.godotengine.org/es/stable/classes/class_json.html), sistema de input remapping, es decir, cambiar las entradas de teclado, y realizar un joystick para movil
* Cuando nos movemos con las teclas WASD por defecto, se creara un efecto de linea gracias al nodo Line2D teniendo tres colores
* Al presionar la tecla TAB, se abrira una ventana mediante la cual podremos cambiar las entradas de teclado
* En la parte inferior derecha, hay un joystick dedicado para mover el personaje en movil
---
# Manejo con el archivo JSON
* En esta ocasion, utilizamos archivos JSON para poder guardar informacion de una manera legible para el usuario y que asi pueda modificarla. Esto es distinto a la forma de almacenar datos presentes en [Dictionaries-Save-Load](https://github.com/MarcoPaoletta/Dictionaries-Save-Load/blob/master/rsc/gamehandler/gamehandler.gd) porque aqui se almacenan de una forma ilegible
* La ruta que se utiliza en Godot para almacenar archivos es *user://nombre_del_archivo*. En este caso es *user://data.json* y se encuentra en *C:\Users\usuario\AppData\Roaming\Godot\app_userdata\Line2D - JSON - Input Remapping - Joystick*
* Cuando abrimos el archivo JSON, nos encontramos con un diccionario almacenado en el. Toda la logica de guardado y cargado de datos se encuentra presente en [global.gd](https://github.com/MarcoPaoletta/Line2D-JSON-InputRemapping-Joystick/blob/master/rsc/global/global.gd)
<img src = https://github.com/MarcoPaoletta/Line2D-JSON-InputRemapping-Joystick/blob/master/JSON.png>

---

### Datos que se pueden modificar en el JSON y son aplicados dentro del juego
* **keys:** son [scancodes](https://docs.godotengine.org/es/stable/classes/class_%40globalscope.html#enum-globalscope-keylist) de cada tecla mediante los cuales el jugador se va a mover
* **background_color**: escala de colores en rgb, es decir, que se van a mezclar los colores rojo, verde y azul para el fondo
* **player_trail_color**: cada trail o rastro del jugador, siendo en total tres, tiene cada uno un color expresado en [hexadecimal](https://desafiohosting.com/que-es-codigo-colores-web/#Sistema_Hexadecimal)

---
# Sistema de input remapping
* Script [changer.gd](https://github.com/MarcoPaoletta/Line2D-JSON-InputRemapping-Joystick/blob/master/rsc/scripts/changer.gd)
```gdscript
func _input(event: InputEvent) -> void:
	if show_panel and event is InputEventKey: 
		if event.scancode == OS.find_scancode_from_string(button.text): # pressing the same key
			scancode = event.scancode
			
		elif event.scancode in g.game["keys"].values(): # the key is already registered
			button.text = not_assigned
			scancode = null
			
		elif not event.scancode in g.game["keys"].values(): # key remapped
			button.text = OS.get_scancode_string(event.scancode)
			scancode = event.scancode
			
		set_key("right")
		set_key("left")
		set_key("down")
		set_key("up")
		show_panel = false

func set_key(direction) -> void:
	if button == get_node("container/" + direction + "_button"):
		g.game["keys"][direction] = scancode
```
### Uso de algunas variables
* **show_panel**: maneja si se esta mostrando o no el panel para cambiar los inputs. Es *true* si el panel esta mostrado y *false* si esta oculto
* **scancode**: va a almacenar o bien el scancode del evento (*event.scancode*) o bien *null*
* **button**: identifica que boton del panel se esta tocando. Este puede ser el boton *up*, *down*, *left* o *right*
* **not_assigned**: *string* para los botones en cierta situacion

---

### Explicacion del codigo
#### **func _input(event: InputEvent) -> void:**
* Si el panel esta siendo mostrado y se presiona cualquier tecla pueden haber distintos resultados:
    * Si el scancode del evento es igual al texto del boton, significa que estamos presionando la misma tecla del boton. Por ende, el scancode va a ser el scancode del evento
    * Por otro lado, si el scancode del evento ya esta registrado en el diccionario de las keys, cambiamos el texto del boton y establecemos el scancode en null porque no queremos cambiar ningun input
    * Como ultimo caso, si el scancode del evento no esta registrado en el diccionario de las keys, cambiamos el texto del boton dependiendo del scancode del evento y establecemos que el scancode es el scancode del evento
* Al final de todo, llamammos a *set_key()* con cada direccion posible y ocultamos el panel

#### **func set_key(direction) -> void:**
* Cuando se llama a esta funcion con la direccion afectada, comprobara si se toco el boton de la direccion correcta y va a guardar el scancode en el diccionario keys y en la direccion correcta
* Recordemos que la variable scancode puede guardar solo dos valores: el scancode del evento si se presiona la misma tecla o null si el scancode ya existe en las keys

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