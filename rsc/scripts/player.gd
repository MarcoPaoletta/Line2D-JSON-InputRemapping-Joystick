extends KinematicBody2D

onready var joystick = $joystick/joystick/joystick_button
onready var window: Vector2 = get_viewport().size

var movement: Vector2 

var velocity: int = 700

func move(X):
	if g.move:
		movement = Vector2.ZERO
		if Input.is_key_pressed(g.game["keys"]["right"]):
			movement.x += 1
		if Input.is_key_pressed(g.game["keys"]["left"]):
			movement.x -= 1	
		if Input.is_key_pressed(g.game["keys"]["down"]):
			movement.y += 1
		if Input.is_key_pressed(g.game["keys"]["up"]):
			movement.y -= 1
			
		if movement.length() > 0:
			movement = movement.normalized() * velocity
			
		position += movement * X
		move_and_slide(joystick.get_value() * velocity)
		movement.x = lerp(movement.x,0,0.2)

func _process(delta: float) -> void:
	move(delta)

func center_position() -> void:
	position = window / 2

func _ready() -> void:
	center_position()

func get_group_and_change_visibility(boolean):
	for nodes in get_tree().get_nodes_in_group("to_hide"):
		nodes.visible = boolean

func _on_nodes_hide() -> void:
	get_group_and_change_visibility(false)

func _on_nodes_show() -> void:
	get_group_and_change_visibility(true)
