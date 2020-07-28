extends Node2D

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_ESCAPE:
			get_tree().quit()
		elif event.scancode == KEY_F10:
			OS.window_fullscreen = !OS.window_fullscreen


func _on_TouchScreenButton_pressed():
	Input.action_press("jump")
