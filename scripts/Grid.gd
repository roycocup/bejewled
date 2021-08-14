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
	var pieces = get_pieces()
	swap(pieces[0], pieces[1])
	# logic
	# if success then reassign pieces to grid
	wait(3)
	swap(pieces[0], pieces[1])
	reset_touches()

func wait(secs):
	var t = Timer.new()
	t.set_wait_time(secs)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
func get_pieces():
	var fc = str(first_touch).split('-')
	var fcol = int(fc[0])
	var frow = int(fc[1])
	var first_piece = grid[fcol][frow].piece
	
	var sc = str(second_touch).split('-')
	var scol = int(sc[0])
	var srow = int(sc[1])
	var second_piece = grid[scol][srow].piece
	return [first_piece, second_piece]

func swap(first_piece, second_piece):
	var ftween = first_piece.get_node("Tween")
	var stween = second_piece.get_node("Tween")
	ftween.interpolate_property(
		first_piece, "position", first_piece.position, second_piece.position, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	stween.interpolate_property(
		second_piece, "position", second_piece.position, first_piece.position, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	ftween.start()
	stween.start()
	
	

	
	

