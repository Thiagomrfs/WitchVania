extends Node

func _ready():
	if Globals.boss_theme.playing:
		Globals.boss_theme.stop()
	if not Globals.theme.playing:
		Globals.theme.play()

func _on_restart_pressed():
	SceneTansition.change_scene_with_transition("res://scenes/Main_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
