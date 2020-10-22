extends KinematicBody2D

var speed = 40
var is_dead = false
var targeting = false
onready var target = get_parent().get_parent().get_parent().get_node("player")

func _ready():
	$".".modulate = Color(1, 1, 1, 0.6)

func _process(delta):
	move_enemy(delta)

func move_enemy(delta):
	if targeting:
		if not is_dead:
			if target != null:
				if target.is_dead:
					$AnimatedSprite.flip_h = true
					position.x += speed * delta
				else:
					var target_position = target.position
					var direction = (target_position - position).normalized()
					var motion = direction * speed * delta
					position += motion
					if target.position.x > position.x:
						$AnimatedSprite.flip_h = true
					else:
						$AnimatedSprite.flip_h = false

func death():
	$hitbox.queue_free()
	$shape.queue_free()
	$AnimationPlayer.play("death")
	yield($AnimationPlayer, "animation_finished")
	$".".queue_free()
	is_dead = true

func _on_hitbox_body_entered(body):
	if "player" in body.name:
		body.death()

func _on_range_body_entered(body):
	if "player" in body.name:
		targeting = true
