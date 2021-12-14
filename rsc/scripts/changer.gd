extends Control

# make or not visible some nodes depending on self visibility
signal nodes_hide()
signal nodes_show()

var show: bool = false # self
var show_panel: bool = false # show or not panel deppending on buttons 

var button: Node # control which button is pressed and change its text

var scancode: int # store the scancode of the event

func _process(_delta: float) -> void:
	self_visibility()
	panel_visibility()
	check_buttons_pressed()
	g.save_data()

func _ready() -> void:
	update_buttons_text()

func self_visibility() -> void:
	if Input.is_action_just_pressed("tab"):
		show = !show 
	if show: 
		show()
		g.move = false 
		emit_signal("nodes_hide") 
	if not show: 
		hide()
		g.move = true
		emit_signal("nodes_show") 

func panel_visibility() -> void:
	if show_panel: 
		$panel.show()
	else:
		$panel.hide()

# input remapping
func check_buttons_pressed() -> void:
	for i in range($container.get_child_count()):
		var buttons = $container.get_child(i)
		if buttons.pressed == true:
			show_panel = true
			
func input_keys(direction) -> void:
	if button == get_node("container/" + direction + "_button"):
		g.game["keys"][direction] = scancode
		
func _input(event: InputEvent) -> void:
	if show_panel and event is InputEventKey:
		button.text = OS.get_scancode_string(event.scancode)
		scancode = event.scancode
		show_panel = false
		input_keys("right")
		input_keys("left")
		input_keys("down")
		input_keys("up")

# buttons pressed: signals and funcs
func reset_keys() -> void:
	g.game["keys"]["right"] = 68
	g.game["keys"]["left"] = 65
	g.game["keys"]["down"] = 83
	g.game["keys"]["up"] = 87
	
func update_buttons_text() -> void:
	$container/right_button.text = OS.get_scancode_string(g.game["keys"]["right"])
	$container/left_button.text = OS.get_scancode_string(g.game["keys"]["left"])
	$container/down_button.text = OS.get_scancode_string(g.game["keys"]["down"])
	$container/up_button.text = OS.get_scancode_string(g.game["keys"]["up"])

func _on_right_button_pressed() -> void:
	button = $container/right_button

func _on_left_button_pressed() -> void:
	button = $container/left_button

func _on_down_button_pressed() -> void:
	button = $container/down_button

func _on_up_button_pressed() -> void:
	button = $container/up_button

func _on_reset_button_pressed() -> void:
	reset_keys()
	update_buttons_text()
