extends Node2D

var piece_scene = load("res://scenes/Piece.tscn")

export(int) var rows = 10
export(int) var cols = 10
export(int) var border = 10

var grid = []
var grid_map = {}

func _ready():
	make_grid()
	populate_grid()


func make_grid():
	for i in rows:
		grid.append([])
		for j in cols:
			grid[i].append({"row":i, "col":j})

func populate_grid():
	for i in grid:
		for j in i:
			var piece = piece_scene.instance()
			var pos = Vector2(j.row*piece.piece_space,j.col*piece.piece_space)
			piece.set_position(pos)
			add_child(piece)
		

