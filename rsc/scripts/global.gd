extends Node

var move: bool = true # control if player can or not move

# dictionary to store the keys with which the player will move
var game: Dictionary = {

	"keys": {
		"right": 68,
		"left": 65,
		"down": 83,
		"up": 87
	},
	
	"background_color": {
		"red": 76,
		"green": 76,
		"blue": 76
	},
	
	"player_trail_color": {
		"trail_0": "8c3c65",
		"trail_1": "ffffff",
		"trail_2": "000000"
	}
	
}

# save system
var path = "user://data.json"

func load_data():
	var file = File.new()
	if not file.file_exists(path):
		return
	file.open(path, file.READ)
	var text = file.get_as_text()
	game = parse_json(text)
	file.close()

func save_data():
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_line(JSON.print(game, "\t"))
	file.close()
	
func _ready() -> void:
	load_data()
