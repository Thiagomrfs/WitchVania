extends StaticBody2D

func _on_Area2D_body_entered(body):
	if "player" in body.name:
		body.jump_power += 50

func _on_Area2D_body_exited(body):
	if "player" in body.name:
		body.jump_power -= 50
