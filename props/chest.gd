extends StaticBody2D

export(bool) var choosed_atk = false
export(bool) var choosed_jump = false
export(bool) var choosed_speed = false
const JUMP = preload("res://power_ups/jump_power_up.tscn")
const ATTACK = preload("res://power_ups/attack_powerUp.tscn")
const SPEED = preload("res://power_ups/speed_powerUp.tscn")

onready var root = get_parent().get_parent().get_parent().get_parent()

func break_chest():
	$AnimatedSprite.play("break")
	$breaking.play()
	var node = Node2D.new()
	node.name = "power_ups"
	yield($AnimatedSprite, "animation_finished")
	if choosed_jump:
		var jump = JUMP.instance()
		jump.position = global_position - Vector2(0, -8) 
		root.add_child(node)
		root.get_node("power_ups").add_child(jump)

	elif choosed_atk:
		var attack = ATTACK.instance()
		attack.position = global_position - Vector2(0, -8) 
		root.add_child(node)
		root.get_node("power_ups").add_child(attack)

	elif choosed_speed:
		var speed = SPEED.instance()
		speed.position = global_position - Vector2(0, -5) 
		root.add_child(node)
		root.get_node("power_ups").add_child(speed)
	queue_free()

