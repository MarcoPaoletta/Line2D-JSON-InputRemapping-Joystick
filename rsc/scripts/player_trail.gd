extends Line2D

var point
var lenght: int = 20

func _ready() :
	OS.center_window()
	gradient.colors[0] = Color(g.game["player_trail_color"]["trail_0"])
	gradient.colors[1] = Color(g.game["player_trail_color"]["trail_1"])

func _process(_delta: float) :
	global_position = Vector2.ZERO
	global_rotation = 0
	point = get_parent().global_position
	add_point(point)
	if get_point_count() > lenght:
		remove_point(0)
