extends Node2D

func _on_enemy5_boss_dead():
	get_node("map").get_node("barrier").queue_free()
