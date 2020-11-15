extends RigidBody


enum State { CLOSED, OPENED }


export(State) var state = State.CLOSED setget set_state


func _physics_process(delta):
	if $AnimationPlayer.is_playing():
		set_sleeping(false)


func _player_eyes_action():
	if !$AnimationPlayer.is_playing():
		if state == State.OPENED:
			set_state(State.CLOSED)
		else:
			set_state(State.OPENED)


func set_state(value):
	if !has_node("AnimationPlayer") || value == state:
		return

	if value == State.OPENED:
		$AnimationPlayer.play("open")
	else:
		$AnimationPlayer.play("close")

	state = value
