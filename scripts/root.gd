extends Node2D

func _ready():
	pass
	
func _input(event):
	if event.is_action_released("ui_select"):
#		if event is InputEventMouseButton:
#		print(event.position)
		pass
		
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
