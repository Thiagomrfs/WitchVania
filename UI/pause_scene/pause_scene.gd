extends Control

func _input(event):
	if event.is_action_pressed("ui_pause"):
		var is_paused = not get_tree().paused
		get_tree().paused = is_paused
		visible = is_paused
