extends ColorRect

func update_colors() -> void:
	color.r8 = g.game["background_color"]["red"]
	color.g8 = g.game["background_color"]["green"]
	color.b8 = g.game["background_color"]["blue"]

func _ready() -> void:
	update_colors()
