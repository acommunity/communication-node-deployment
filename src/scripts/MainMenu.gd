extends Control


func _process(delta):
	var player = get_node("Video")

	if !player.is_playing():
		player.play()


func _on_Start_pressed():
	get_tree().change_scene("res://scenes/game/Game.tscn")


func _on_Settings_pressed():
	get_tree().change_scene("res://scenes/menu/Settings.tscn")


func _on_About_pressed():
	get_tree().change_scene("res://scenes/menu/About.tscn")


func _on_Exit_pressed():
	get_tree().quit()
