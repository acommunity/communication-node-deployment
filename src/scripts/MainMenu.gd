extends Control


func _enter_tree():
	get_node("Buttons/FullScreen").set_pressed(OS.window_fullscreen)


func _process(delta):
	var player = get_node("VideoPlayer")

	if !player.is_playing():
		player.play()


func _on_Start_pressed():
	get_tree().change_scene("res://scenes/Station.tscn")


func _on_Exit_pressed():
	get_tree().quit()


func _on_FullScreen_toggled(button_pressed):
	OS.set_window_fullscreen(button_pressed)
