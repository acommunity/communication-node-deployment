extends Spatial


func _ready():
	pass


func _process(delta):
	pass


func _unhandled_key_input(event):
	if event is InputEvent:
		if event.scancode == KEY_ESCAPE:
			get_tree().change_scene("res://scenes/MainMenu.tscn")
