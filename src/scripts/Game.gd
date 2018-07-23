extends Spatial


export(int) var min_stage = 0

export(int) var max_stage = 9


var _stage = 0


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
	get_node("Interface/StageTitle/Stage").text = String(value + 1)

	if _stage_is_playing():
		return

	while _stage < value:
		_set_next_stage()

	while _stage > value:
		_set_prev_stage()


func _stage_is_playing():
	for child in get_node("Cars").get_children():
		if !child.has_node("AnimationPlayer"):
			continue

		var player = child.get_node("AnimationPlayer")

		if player.is_playing():
			return true

	return false


func _set_next_stage():
	_stage += 1

	for child in get_node("Cars").get_children():
		if !child.has_node("AnimationPlayer"):
			continue

		var player = child.get_node("AnimationPlayer")

		var str_stage = String(_stage)

		if player.has_animation(str_stage):
			player.play(str_stage)



func _set_prev_stage():
	for child in get_node("Cars").get_children():
		if !child.has_node("AnimationPlayer"):
			continue

		var player = child.get_node("AnimationPlayer")

		var str_stage = String(_stage)

		if player.has_animation(str_stage):
			player.play_backwards(str_stage)

	_stage -= 1
