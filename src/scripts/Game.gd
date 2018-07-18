extends Spatial


export(int) var min_stage = 0

export(int) var max_stage = 9


var _stage


func _ready():
	set_stage(0)


func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE:
			get_tree().change_scene("res://scenes/menu/Main.tscn")

	if Input.is_action_pressed("stage_backward"):
		if _stage > min_stage:
			set_stage(_stage - 1)

	if Input.is_action_pressed("stage_forward"):
		if _stage < max_stage:
			set_stage(_stage + 1)


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


func set_stage(value):
	get_node("Interface/StageRect/Stage").text = String(value + 1)

	_stage = value
