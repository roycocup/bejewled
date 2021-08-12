extends Node2D

const SIZE = 64
const BORDER = 10
var piece_space = SIZE + BORDER

func _ready():
	var colour = get_random_piece()
	var image = load("res://assets/" + colour + ".png")
	get_node("TextureRect").texture = image
	
	
func get_random_piece():
	var pieces = ['yellow','blue', 'green', 'red']
	randomize()
	var s = (randi() % 4) -1
	return pieces[s]