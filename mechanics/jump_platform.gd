extends Area2D


func _on_jump_platform_body_entered(body):
	if "player" in body.name:
		body.jump_power += 50


func _on_jump_platform_body_exited(body):
	if "player" in body.name:
		body.jump_power -= 50
