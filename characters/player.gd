extends KinematicBody2D

const GRAVITY = 10
const FLOOR = Vector2(0, -1)
const MANABALL = preload("res://mechanics/manaball.tscn")

var motion = Vector2()
var velocity = 100
var jump_power = -250
var is_attacking = false
var is_dead = false
var is_attack_boosted = false

onready var timer = get_node("Timer")
onready var death_timer = get_node("Timer2")


func death():
	is_dead = true
	motion = Vector2(0,0)
	$AnimatedSprite.play("die")
	$CollisionShape2D.set_deferred("disabled", true)
	death_timer.set_wait_time(3)
	death_timer.start()

func shoot_manaball():
	if is_dead == false:
		var manaball = MANABALL.instance()
		if sign($Position2D.position.x) == 1:
			manaball.set_manaball_direction(1)
		else:
			manaball.set_manaball_direction(-1)
		if is_attack_boosted:
			manaball.damage = 2
			manaball.speed += 40
			manaball.modulate = Color(0.83, 0.09, 0.38)
		get_parent().add_child(manaball)
		manaball.position = $Position2D.global_position

func _ready():
	pass

func _process(delta):
	if is_dead == false:
		if Input.is_action_pressed("ui_right"):
			if is_attacking == false:
				motion.x = velocity
				$AnimatedSprite.flip_h = false
				$AnimatedSprite.play("walking")
				if sign($Position2D.position.x) == -1:
					$Position2D.position.x *= -1
		elif Input.is_action_pressed("ui_left"):
			if is_attacking == false:
				$AnimatedSprite.flip_h = true
				$AnimatedSprite.play("walking")
				motion.x = -velocity
				if sign($Position2D.position.x) == 1:
					$Position2D.position.x *= -1
		else:
			motion.x = 0 
			if is_on_floor() and is_attacking == false:
				$AnimatedSprite.play("idle")
		
		if Input.is_action_just_pressed("ui_up"):
			if is_on_floor():
				motion.y = jump_power
		
		if Input.is_key_pressed(32) and is_attacking == false:
			if is_on_floor():
				motion.x = 0
			is_attacking = true
			$AnimatedSprite.play("manaball")
			timer.set_wait_time(0.6)
			timer.start()
	
		motion.y += GRAVITY
		motion = move_and_slide(motion, FLOOR)
	
		if get_slide_count() > 0:
			for slide in range(get_slide_count()):
				if "enemy" in get_slide_collision(slide).collider.name:
					death()
				elif "ghost" in get_slide_collision(slide).collider.name:
					death()

func _on_AnimatedSprite_animation_finished():
	is_attacking = false

func _on_Timer_timeout():
	shoot_manaball()
	timer.stop()

func _on_Timer2_timeout():
	get_tree().change_scene("res://scenes/Main_menu.tscn")
	death_timer.stop()
