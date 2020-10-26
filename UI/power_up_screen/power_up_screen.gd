extends Control

var waiting

onready var nodes_root = $TextureRect/MarginContainer/root

func _ready():
	pass

func _process(delta):
	if waiting:
		if Input.is_key_pressed(32):
			fade_out()

func fade_in(power_up):
	if power_up == "jump":
		nodes_root.get_node("power_up_container/power_up/jump").visible = true
		nodes_root.get_node("details/details/description/jump").visible = true
	elif power_up == "attack":
		nodes_root.get_node("power_up_container/power_up/attack").visible = true
		nodes_root.get_node("details/details/description/attack").visible = true
	elif power_up == "speed":
		nodes_root.get_node("power_up_container/power_up/speed").visible = true
		nodes_root.get_node("details/details/description/speed").visible = true
	$AnimationPlayer.play("fade in")
	waiting = true
	var is_paused = not get_tree().paused
	get_tree().paused = is_paused

func fade_out():
	$AnimationPlayer.play("fade out")
	waiting = false

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade out":
		var is_paused = not get_tree().paused
		get_tree().paused = is_paused
		$".".queue_free()
