extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AudioStreamPlayer").playing = true


func _process(delta):
	if $enemy.is_boss_dead:
		$block/CollisionShape2D.set_deferred("disabled", true)
		$block/Sprite.set_deferred("visible", false)
		$block/Sprite2.set_deferred("visible", false)
		$block/Sprite3.set_deferred("visible", false)
		$block/Sprite4.set_deferred("visible", false)
		$block/Sprite5.set_deferred("visible", false)
		$block/Sprite6.set_deferred("visible", false)
		$block/Sprite7.set_deferred("visible", false)
		$block/Sprite8.set_deferred("visible", false)
