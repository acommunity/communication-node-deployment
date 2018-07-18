extends RigidBody


enum State { CLOSED, OPENED }


export(State) var state = CLOSED


func _physics_process(delta):
	if get_node("AnimationPlayer").is_playing():
		set_sleeping(false)


func _player_eyes_action():
	if !get_node("AnimationPlayer").is_playing():
		if state == OPENED:
			get_node("AnimationPlayer").play("close")
			state = CLOSED
		else:
			get_node("AnimationPlayer").play("open")
			state = OPENED
