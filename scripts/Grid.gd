extends Node2D

var piece_scene = load("res://scenes/Piece.tscn")

export(int) var rows = 11
export(int) var cols = 10
export(int) var border = 10
var hOffset = 17
var vOffset = 100

var first_touch
var second_touch


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
			var x = (j.row * piece.piece_space) + hOffset
			var y = (j.col * piece.piece_space) + vOffset
			var pos = Vector2(x, y)
			piece.set_id(str(j.row)+"-"+str(j.col))
			piece.set_position(pos)
			piece.connect("piece_clicked", self, "_on_piece_clicked")
			j['piece'] = piece
			add_child(piece)

func reset_touches():
	first_touch = null
	second_touch = null

func _on_piece_clicked(id):
	if first_touch == null:
		first_touch = id
	elif second_touch == null:
		if first_touch != id:
			second_touch = id
			handle_two_touches()

func handle_two_touches():
	reset_touches()
	swap()
func swap():
	print(grid)
	# var tween = get_node("Tween")
	# tween.interpolate_property($Node2D, "position",
	# 		Vector2(), Vector2(100, 100), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	# tween.start()
	pass

	
	

