extends KinematicBody2D

const GRAVITY = 10
const FLOOR = Vector2(0, -1)
const MANABALL = preload("res://mechanics/manaball/manaball.tscn")

var motion = Vector2()
var velocity = 100
var jump_power = 250
var is_attacking = false
var can_attack = true
var is_dead = false
var is_attack_boosted = false

export(bool) var dark_phase = false 
export(bool) var boss_fight = false
export(String, FILE, "*.tscn") var on_death_path

onready var timer = get_node("timers/Timer")
onready var death_timer = get_node("timers/Timer2")
onready var attack_delay = get_node("timers/attack_wait")


func death():
	is_dead = true
	motion = Vector2(0,0)
	$sound_fx/death_fx.play()
	$AnimatedSprite.play("die")
	$CollisionShape2D.set_deferred("disabled", true)
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
		$sound_fx/manaball_fx.playing = true
		get_parent().add_child(manaball)
		manaball.check_dark_phase()
		manaball.position = $Position2D.global_position
		is_attacking = false

func _ready():
	if dark_phase:
		get_parent().get_node("map").modulate = Color(0.09, 0.09, 0.09)
		get_parent().get_node("enemies").modulate = Color(0.09, 0.09, 0.09)
		$".".modulate = Color(0.64, 0.64, 0.64)
		$light_phases_aura.visible = true
		$light_phases_aura.energy = 5
	timer.set_wait_time(0.6)
	attack_delay.set_wait_time(2)
	death_timer.set_wait_time(3)
	if boss_fight:
		if Globals.theme.playing: 
			Globals.theme.stop()
		if not Globals.boss_theme.playing:
			Globals.boss_theme.play()
		get_parent().get_node("map").get_node("tilesets").modulate = Color(0.91, 0.33, 0.33)
	else:
		if Globals.boss_theme.playing:
			Globals.boss_theme.stop()
		if not Globals.theme.playing:
			Globals.theme.play()

func _physics_process(delta):
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
				motion.y = -jump_power
				$sound_fx/jump_fx.playing = true
		
		if Input.is_key_pressed(32) and can_attack:
			if is_on_floor():
				motion.x = 0
			can_attack = false
			is_attacking = true
			$AnimatedSprite.play("manaball")
			$GUI/player_GUI.modulate = Color(1, 1, 1, 0.08)
			attack_delay.start()
			timer.start()

		motion.y += GRAVITY
		motion = move_and_slide(motion, FLOOR)

		if get_slide_count() > 0:
			for slide in range(get_slide_count()):
				if "enemy" in get_slide_collision(slide).collider.name:
					death()
				elif "ghost" in get_slide_collision(slide).collider.name:
					death()
				elif "cat" in get_slide_collision(slide).collider.name:
					death()

func _process(delta):
	if attack_delay.time_left < 2:
		$GUI/player_GUI.modulate = Color(1, 1, 1, 1 - attack_delay.time_left)

func _on_Timer_timeout():
	shoot_manaball()
	timer.stop()

func _on_Timer2_timeout():
	SceneTansition.change_scene_with_transition(on_death_path)
	death_timer.stop()

func _on_AnimatedSprite_animation_finished():
	is_attacking = false

func _on_attack_wait_timeout():
	can_attack = true
	attack_delay.stop()
