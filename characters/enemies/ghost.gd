extends KinematicBody2D

var speed = 40
onready var target = get_parent().get_node("player")

func _ready():
	pass 

func _process(delta):
	move_enemy(delta)

func move_enemy(delta):
	if target != null:
		var target_position = target.position
		var direction = (target_position - position).normalized()
		var motion = direction * speed * delta
		position += motion
		if target.position.x > position.x:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
