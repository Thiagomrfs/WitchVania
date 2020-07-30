extends Node2D


var to_defeat = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if to_defeat == 0:
		SceneTansition.change_scene_with_transition("res://scenes/you_won.tscn")


func _on_boss1_boss_dead():
	to_defeat -= 1


func _on_boss2_boss_dead():
	to_defeat -= 1
