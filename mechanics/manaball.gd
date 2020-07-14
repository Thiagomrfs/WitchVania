extends Area2D

var speed = 160
var motion = Vector2()
var direction = 1
var damage = 1

func _ready():
	pass 

func set_manaball_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false


func _process(delta):
	motion.x = speed * delta * direction
	$AnimatedSprite.play("idle")
	translate(motion)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_manaball_body_entered(body):
	if "enemy" in body.name:
		body.hp -= damage
		body.death()
	elif "player" in body.name:
		body.death()
	elif "ghost" in body.name:
		body.death()
	queue_free()
