extends KinematicBody2D

const GRAVITY = 100
const JUMP_POWER = -150
const FLOOR = Vector2(0, -1)

var velocity = 100
var targeting = false
var attacking = false
var jump_width = Vector2()
var target_position
var direction

onready var start_position = position
onready var target = get_parent().get_parent().get_node("player")
onready var attack_delay = get_node("attack_delay")


func _ready():
	attack_delay.set_wait_time(4)
	$AnimatedSprite.play("default")

func _process(delta):
	if targeting:
		if target.position.x > position.x:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
	if attacking:
		jump(delta)
		if direction == 1:
			if position.x < target_position.x:
				jump_width.x += target_position.x * direction
				move_and_slide(jump_width, FLOOR)
		else:
			if position.x > target_position.x:
				jump_width.x += target_position.x * direction
				move_and_slide(jump_width, FLOOR)
	move_and_slide(Vector2(0, GRAVITY))

func jump(delta):
	if direction == 1:
		if position.x < target_position.x:
			if position.y < start_position.y - JUMP_POWER:
				move_and_slide(Vector2(0, JUMP_POWER))
			else:
				attacking = false
	else:
		if position.x > target_position.x:
			if position.y < start_position.y - JUMP_POWER:
				move_and_slide(Vector2(0, JUMP_POWER))
			else:
				attacking = false


func _on_range_body_entered(body):
	if "player" in body.name:
		targeting = true
		$AnimatedSprite.play("prepare")
		attack_delay.start()

func _on_range_body_exited(body):
	targeting = false
	$AnimatedSprite.play("prepare")
	$AnimatedSprite.play("default")

func _on_attack_delay_timeout():
	if targeting:
		target_position = target.position
		if target.position.x > position.x:
			direction = 1
		else:
			direction = -1
		targeting = false
		attacking = true
		$AnimatedSprite.play("attack")
		attack_delay.stop()
