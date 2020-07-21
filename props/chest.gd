extends StaticBody2D

var choosed
const JUMP = preload("res://power_ups/jump_power_up.tscn")
var ATTACK = preload("res://power_ups/attack_powerUp.tscn")
var SPEED = preload("res://power_ups/speed_powerUp.tscn")

onready var root = get_parent().get_parent().get_parent()

func break_chest():
	choosed = randi() % 3 + 1
	$AnimatedSprite.play("break")
	$breaking.play()
	var node = Node2D.new()
	node.name = "power_ups"
	yield($AnimatedSprite, "animation_finished")
	if choosed == 1:
		var jump = JUMP.instance()
		jump.position = global_position - Vector2(0, -8) 
		root.add_child(node)
		root.get_node("power_ups").add_child(jump)

	elif choosed == 2:
		var attack = ATTACK.instance()
		attack.position = global_position - Vector2(0, -8) 
		root.add_child(node)
		root.get_node("power_ups").add_child(attack)

	elif choosed == 3:
		var speed = SPEED.instance()
		speed.position = global_position - Vector2(0, -5) 
		root.add_child(node)
		root.get_node("power_ups").add_child(speed)
	queue_free()

