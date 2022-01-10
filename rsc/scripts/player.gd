extends KinematicBody2D

onready var joystick = $joystick/joystick/joystick_button
onready var window: Vector2 = get_viewport().size

var movement: Vector2 

var velocity: int = 700

func move(X):
	if g.move:
		movement = Vector2.ZERO
		if g.game["keys"]["right"] != null and Input.is_key_pressed(g.game["keys"]["right"]):
			movement.x += 1
		if g.game["keys"]["left"] != null and Input.is_key_pressed(g.game["keys"]["left"]):
			movement.x -= 1	
		if g.game["keys"]["down"] != null and Input.is_key_pressed(g.game["keys"]["down"]):
			movement.y += 1
		if g.game["keys"]["up"] != null and Input.is_key_pressed(g.game["keys"]["up"]):
			movement.y -= 1
			
		if movement.length() > 0:
			movement = movement.normalized() * velocity
			
		if OS.get_name() == "Android":
			move_and_slide(joystick.get_value() * velocity)
			
		position += movement * X
		movement.x = lerp(movement.x,0,0.2)

func borders():
	if position.x >= get_viewport().size.x or position.x <= 0:
		center_position()
	if position.y >= get_viewport().size.y or position.y <= 0:
		center_position()

func _process(delta: float) :
	move(delta)
	borders()

func center_position() :
	position = window / 2

func _ready() :
	center_position()

func get_group_and_change_visibility(boolean):
	for nodes in get_tree().get_nodes_in_group("to_hide"):
		nodes.visible = boolean

func _on_nodes_hide() :
	get_group_and_change_visibility(false)

func _on_nodes_show() :
	get_group_and_change_visibility(true)
