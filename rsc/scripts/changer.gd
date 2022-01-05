extends Control

# make or not visible some nodes depending on self visibility
signal nodes_hide()
signal nodes_show()

var show: bool = false # self
var show_panel: bool = false # show or not panel deppending on buttons 

var button: Node # control which button is pressed

var scancode  # store the scancode of the event

var not_assigned: String = "NOT ASSIGNED"

func _process(_delta: float) -> void:
	self_visibility()
	panel_visibility()
	check_buttons_pressed()
	update_buttons_text("right")
	update_buttons_text("left")
	update_buttons_text("down")
	update_buttons_text("up")
	g.save_data()

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

# buttons pressed: signals and funcs
func update_buttons_text(direction):
	if g.game["keys"][direction] != null:
		get_node("container/" + direction + "_button").text = OS.get_scancode_string(g.game["keys"][direction])
	else:
		get_node("container/" + direction + "_button").text = not_assigned

func _on_right_button_pressed() -> void:
	button = $container/right_button

func _on_left_button_pressed() -> void:
	button = $container/left_button

func _on_down_button_pressed() -> void:
	button = $container/down_button

func _on_up_button_pressed() -> void:
	button = $container/up_button

func _on_reset_button_pressed() -> void:
	g.game["keys"]["right"] = 68
	g.game["keys"]["left"] = 65
	g.game["keys"]["down"] = 83
	g.game["keys"]["up"] = 87

func _on_reset_up_pressed():
	g.game["keys"]["up"] = 87

func _on_reset_down_pressed():
	g.game["keys"]["down"] = 83
	
func _on_reset_left_pressed():
	g.game["keys"]["left"] = 65

func _on_reset_right_pressed():
	g.game["keys"]["right"] = 68

func delete_key(direction):
	button = get_node("container/" + direction + "_button")
	button.text = not_assigned
	g.game["keys"][direction] = null

func _on_delete_up_pressed():
	delete_key("up")

func _on_delete_down_pressed():
	delete_key("down")

func _on_delete_left_pressed():
	delete_key("left")
	
func _on_delete_right_pressed():
	delete_key("right")
