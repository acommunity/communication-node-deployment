extends Control


func _enter_tree():
	get_node("Scroll/Buttons/FullScreen").set_pressed(OS.window_fullscreen)


func _on_FullScreen_toggled(button_pressed):
	OS.set_window_fullscreen(button_pressed)
