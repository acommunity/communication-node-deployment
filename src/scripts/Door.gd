extends RigidBody


enum State { CLOSED, OPENED }


export(State) var state = CLOSED setget set_state


func _physics_process(delta):
	if $AnimationPlayer.is_playing():
		set_sleeping(false)


func _player_eyes_action():
	if !$AnimationPlayer.is_playing():
		if state == OPENED:
			set_state(CLOSED)
		else:
			set_state(OPENED)


func set_state(value):
	if $AnimationPlayer == null || value == state:
		return

	if value == OPENED:
		$AnimationPlayer.play("open")
	else:
		$AnimationPlayer.play("close")

	state = value
