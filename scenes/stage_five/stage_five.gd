extends Node2D

func _on_cat_boss_dead():
	SceneTansition.change_scene_with_transition("res://scenes/stage_six/stage_six.tscn")
