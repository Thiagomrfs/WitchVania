extends Node


func _ready():
	get_node("AudioStreamPlayer2D").playing = true


func _process(delta):
	pass


func _on_TextureButton_pressed():
	get_tree().change_scene("res://fases/fase1.tscn")
