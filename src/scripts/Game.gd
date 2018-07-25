extends Spatial


export(int) var min_stage = 0

export(int) var max_stage = 9


var _stage = 0


const PLAYERS = [
	"Objects/CentralCommunication/AnimationPlayer",
#	"Objects/PowerSupplier/AnimationPlayer",
#	"Objects/Moss/AnimationPlayer",
#	"Objects/R409/AnimationPlayer",
#	"Interface/AnimationPlayer"
]


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

	if Input.is_action_pressed("normal_mode"):
		get_node("Player").mode = 0

	if Input.is_action_pressed("flight_mode"):
		get_node("Player").mode = 1


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
	if _stage_is_playing():
		return

	while _stage < value:
		_set_next_stage()

	while _stage > value:
		_set_prev_stage()

	get_node("Interface/StageTitle/Stage").text = String(value + 1)


func _stage_is_playing():
	for player_path in PLAYERS:
		var player = get_node(player_path)

		if player.is_playing():
			return true

	return false


func _set_next_stage():
	_stage += 1

	var str_stage = String(_stage)

	for player_path in PLAYERS:
		var player = get_node(player_path)

		if player.has_animation(str_stage):
			player.play(str_stage)


func _set_prev_stage():
	var str_stage = String(_stage)

	for player_path in PLAYERS:
		var player = get_node(player_path)

		if player.has_animation(str_stage):
			player.play_backwards(str_stage)

	_stage -= 1
