extends Spatial


func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE:
			get_tree().change_scene("res://scenes/MainMenu.tscn")
