extends Control


func _process(delta):
	var player = get_node("VideoPlayer")

	if !player.is_playing():
		player.play()


func _on_Start_pressed():
	get_tree().change_scene("res://scenes/Station.tscn")


func _on_Exit_pressed():
	get_tree().quit()
