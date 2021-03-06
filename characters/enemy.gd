extends KinematicBody2D

signal boss_dead

const FLOOR = Vector2(0, -1)
const MANABALL = preload("res://mechanics/manaball/manaball.tscn")

var GRAVITY = 10
var motion = Vector2()
var is_dead = false
onready var attack = get_node("attack")
onready var attack_delay = get_node("manabal_delay")
var is_attacking = false
var jump_power = -250
var initial_hp

export(int) var direction = 1
export(int) var speed = 60
export(String) var type = "default"
export(bool) var boss = false
export(int) var hp = 1

func _ready():
	initial_hp = hp
	$health_bar.update_max_health(hp)
	if boss:
		$health_bar.visible = true
		scale = Vector2(2, 2)
	if type == "shooter":
		attack.set_wait_time(3.5)
		attack.start()
		
		if direction == -1:
				$AnimatedSprite.flip_h = true
				$Position2D.position *= -1 
		else:
			$AnimatedSprite.flip_h = false

func death():
	if hp <= 0:
		if boss:
			emit_signal("boss_dead")
		is_dead = true
		motion = Vector2(0, 0)
		$AnimatedSprite.play("death")
		$CollisionShape2D.set_deferred("disabled", true)
		$death_range.queue_free()
		$health_bar.queue_free()

func shoot_manaball():
	if is_dead == false:
		var manaball = MANABALL.instance()
		if sign($Position2D.position.x) == 1:
			manaball.set_manaball_direction(1)
		else:
			manaball.set_manaball_direction(-1)
		get_parent().add_child(manaball)
		manaball.position = $Position2D.global_position

func _process(_delta):
	if is_dead == false:
		$health_bar.update_health(hp)
		if hp < initial_hp:
			$health_bar.visible = true
		if type == "default":
				if direction == -1:
					$AnimatedSprite.flip_h = true
				else:
					$AnimatedSprite.flip_h = false
				
				$AnimatedSprite.play("walking")
				
				motion.y += GRAVITY
				
				if is_on_wall():
					direction *= -1
					$RayCast2D.position.x *= -1
				elif $RayCast2D.is_colliding() == false:
					direction *= -1
					$RayCast2D.position.x *= -1

				motion.x = speed * direction
				motion = move_and_slide(motion, FLOOR)

				if get_slide_count() > 0:
					for slide in range(get_slide_count()):
						if "player" in get_slide_collision(slide).collider.name:
							get_slide_collision(slide).collider.death()
		
		if type == "shooter":
			motion.y += GRAVITY
			motion = move_and_slide(motion, FLOOR)
			if is_attacking == false:
				$AnimatedSprite.play("idle")
			else:
				$AnimatedSprite.play("attacking")

func _on_attack_timeout():
	attack_delay.set_wait_time(0.6)
	attack_delay.start()
	is_attacking = true

func _on_manabal_delay_timeout():
	shoot_manaball()
	attack_delay.stop()
	is_attacking = false


func _on_gravity_changer_gravity_changed():
	scale.y *= -1
	GRAVITY *= -1


func _on_death_range_body_entered(body):
	if "player" in body.name:
		body.death()
