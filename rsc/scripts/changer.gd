extends Control

# make or not visible some nodes depending on self visibility
signal nodes_hide()
signal nodes_show()

var show: bool = false # self
var show_panel: bool = false # show or not panel deppending on buttons 

var button: Node # control which button is pressed

var scancode # store the scancode of the event

var not_assigned: String = "NOT ASSIGNED" # text for the buttons when they do not have a key assigned

var default_keys: Dictionary = { # default keys scancodes to set when they are reseted
	"up": 87,
	"down": 83,
	"left": 65,
	"right": 68
}

func _process(_delta: float) :
	self_visibility()
	panel_visibility()
	
	check_buttons_pressed()
	set_button_pressed()
	reset_buttons_pressed()
	delete_buttons_pressed()
	
	update_buttons_text("up")
	update_buttons_text("down")
	update_buttons_text("left")
	update_buttons_text("right")
	
	g.save_data()
	
# visibility
func self_visibility():
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

func panel_visibility():
	if show_panel: 
		$panel.show()
	else:
		$panel.hide()
			
# input remapping system
func _input(event):
	if show_panel and event is InputEventKey: 
		show_panel = false
		
		if event.scancode == OS.find_scancode_from_string(button.text): # pressing the same key
			scancode = event.scancode

		elif event.scancode in g.game["keys"].values(): # the key is already registered
			scancode = event.scancode
			for i in $container.get_child_count():
				var buttons: Node = $container.get_child(i)
				if buttons.text == OS.get_scancode_string(event.scancode):
					buttons.text = not_assigned
					g.game["keys"][buttons.name] = null
					
		elif not event.scancode in g.game["keys"].values(): # key remapped
			scancode = event.scancode

		set_key("right")
		set_key("left")
		set_key("down")
		set_key("up")
		
func set_key(direction):
	if button == get_node("container/" + direction):
		g.game["keys"][direction] = scancode

# buttons pressed
func check_buttons_pressed():
	for node in $container.get_children():
		if node.pressed == true:
			show_panel = true

func update_buttons_text(direction):
	if g.game["keys"][direction] != null:
		get_node("container/" + direction).text = OS.get_scancode_string(g.game["keys"][direction])
	else:
		get_node("container/" + direction).text = not_assigned

func set_button_pressed():
	for node in get_tree().get_nodes_in_group("key_remap"):
		if node.pressed == true:
			button = node

func _on_reset_all_button_pressed():
	reset_key("up")
	reset_key("down")
	reset_key("left")
	reset_key("right")

func reset_key(direction):
	g.game["keys"][direction] = default_keys[direction]

func reset_buttons_pressed():
	for node in get_tree().get_nodes_in_group("reset"):
		if node.pressed == true:
			g.game["keys"][node.name.replace("reset_", "")] = default_keys[node.name.replace("reset_", "")]
			
func delete_buttons_pressed():
	for node in get_tree().get_nodes_in_group("delete"):
		if node.pressed == true:
			g.game["keys"][node.name.replace("delete_", "")] = null
