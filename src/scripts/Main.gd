extends Control


func _process(delta):
	var player = get_node("Video")

	if !player.is_playing():
		player.play()


func _on_Start_pressed():
	get_tree().change_scene("res://scenes/game/Game.tscn")


func _on_Settings_pressed():
	_set_menu_scene("res://scenes/menu/Settings.tscn")


func _on_About_pressed():
	_set_menu_scene("res://scenes/menu/About.tscn")


func _on_Exit_pressed():
	get_tree().quit()


func _set_menu_scene(resource):
	var scene_resource = ResourceLoader.load(resource)

	var scene = scene_resource.instance()

	scene.get_node("Close").connect("pressed", self, "_on_Close_pressed")

	_clear_menu_rect()

	get_node("MenuRect").add_child(scene)
	get_node("MenuRect").set_visible(true)


func _on_Close_pressed():
	get_node("MenuRect").set_visible(false)

	_clear_menu_rect()


func _clear_menu_rect():
	for child in get_node("MenuRect").get_children():
		child.queue_free()
