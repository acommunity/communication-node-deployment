extends Spatial


func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE:
			get_tree().change_scene("res://scenes/menu/Main.tscn")


func _on_Player_eyes_enter(object):
	var text = ""

	if object.has_node("Hint"):
		text = object.get_node("Hint").text

	get_node("Interface/Hint").text = text


func _on_Player_eyes_leave(object):
	get_node("Interface/Hint").text = ""


func _on_Player_eyes_action(object):
	if object.has_method("_player_eyes_action"):
		object._player_eyes_action()
