extends Node2D

const SIZE = 64
const BORDER = 10
var piece_space = SIZE + BORDER
signal piece_clicked
var piece_id: String

func _ready():
	var colour = get_random_piece()
	var image = load("res://assets/" + colour + ".png")
	get_node("TextureRect").texture = image
	
func set_id(id):
	piece_id = id
	
	
func get_random_piece():
	var pieces = ['yellow','blue', 'green', 'red']
	randomize()
	var s = (randi() % 4) -1
	return pieces[s]

func _input(event):
	if event.is_action_released("ui_select"):
		var mousePos = get_global_mouse_position()
		var origin = transform.get_origin()
		var r = Rect2(origin.x, origin.y, SIZE, SIZE).has_point(event.position)
		if r:
			emit_signal("piece_clicked")
			print (piece_id, event.position)
		
		

