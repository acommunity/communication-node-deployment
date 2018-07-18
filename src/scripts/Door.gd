extends RigidBody


enum State { CLOSED, OPENED }


export(NodePath) var tree_player

export(String) var transition_node

export(State) var state = CLOSED


func _player_eyes_action():
	if !get_node("AnimationPlayer").is_playing():
		if state == OPENED:
			get_node("AnimationPlayer").play("close")
			state = CLOSED
		else:
			get_node("AnimationPlayer").play("open")
			state = OPENED
