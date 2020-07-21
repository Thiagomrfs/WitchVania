extends KinematicBody2D

export(bool) var boss = false

const GRAVITY = 100
const JUMP_POWER = -150
const FLOOR = Vector2(0, -1)

var velocity = 5
var targeting = false
var attacking = false
var dead = false
var jump_motion = Vector2()
var jump_height = 5
var jump_width
var target_position
var direction

onready var start_position = position
onready var target = get_parent().get_parent().get_node("player")
onready var attack_delay = get_node("attack_delay")


func death():
	dead = true
	$CollisionShape2D.set_deferred("disabled", true)
	$range/CollisionShape2D.set_deferred("disabled", true)
	$claws/claws_collision.set_deferred("disabled", true)
	$AnimatedSprite.play("death")
	yield($AnimatedSprite, "animation_finished")
	queue_free()

func _ready():
	if boss:
		scale = Vector2(3,3)
	attack_delay.set_wait_time(2)
	$AnimatedSprite.play("default")

func _process(delta):
	if not dead:
		for slide in range(get_slide_count()):
			if "player" in get_slide_collision(slide).collider.name:
				get_slide_collision(slide).collider.death()

		if targeting:
			if target.position.x > position.x:
				$AnimatedSprite.flip_h = true
			else:
				$AnimatedSprite.flip_h = false
		if attacking:
			if direction == 1:
				if position.x < start_position.x + (jump_width/2):
					jump_motion.y = JUMP_POWER
					move_and_slide(Vector2(0, jump_motion.y), FLOOR)
				else:
					jump_motion.y = 0
	
				if position.x < target_position.x-1:
					jump_motion.x = (target_position.x - position.x) * 3
				else:
					$AnimatedSprite.play("default")
					targeting = true
					attacking = false
					start_position = position
					for body in $range.get_overlapping_bodies():
						if "player" in body.name:
							if not attacking:
								targeting = true
								$AnimatedSprite.play("prepare")
								attack_delay.start()
				move_and_slide(jump_motion, FLOOR)
			else:
				if position.x > start_position.x + (jump_width/2):
					jump_motion.y = JUMP_POWER
					move_and_slide(Vector2(0, jump_motion.y), FLOOR)
				else:
					jump_motion.y = 0

				if position.x > target_position.x+1:
					jump_motion.x = (position.x - target_position.x) * -3
					move_and_slide(jump_motion, FLOOR)
				else:
					$AnimatedSprite.play("default")
					targeting = true
					attacking = false
					start_position = position
					for body in $range.get_overlapping_bodies():
						if "player" in body.name:
							if not attacking:
								targeting = true
								$AnimatedSprite.play("prepare")
								attack_delay.start()

		move_and_slide(Vector2(0, GRAVITY), FLOOR)

func _on_range_body_entered(body):
	if "player" in body.name:
		if not attacking:
			targeting = true
			$AnimatedSprite.play("prepare")
			attack_delay.start()

func _on_range_body_exited(body):
	if targeting:
		targeting = false
		$AnimatedSprite.play("default")

func _on_attack_delay_timeout():
	if not dead:
		if targeting and not attacking:
			$AnimatedSprite.play("attack")
			target_position = target.position
			if target.position.x > position.x:
				jump_width = target_position.x - position.x
				$claws/claws_collision.position.x = 9.119
				direction = 1
			else:
				jump_width = target_position.x - position.x
				$claws/claws_collision.position.x = -9.119
				direction = -1
			attack_delay.stop()
			attacking = true
			targeting = false

func _on_claws_body_entered(body):
	if "player" in body.name:
		body.death()
