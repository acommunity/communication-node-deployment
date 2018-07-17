extends RigidBody


enum State { CLOSED, OPENED }


export(NodePath) var tree_player

export(String) var transition_node

export(State) var state = CLOSED


func _ready():
	print("Ready")
	#get_node(tree_player).transition_node_set_current(transition_node, state)


func _player_eyes_action():
	if state == OPENED:
		print("Close!")
		state = CLOSED
		get_node(tree_player).transition_node_set_current(transition_node, state)
	else:
		print("Open!")
		state = OPENED
		get_node(tree_player).transition_node_set_current(transition_node, state)

	print(get_node(tree_player).transition_node_get_current(transition_node))