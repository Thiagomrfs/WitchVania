extends Area2D



func _on_Area2D_body_entered(body):
	if "player" in body.name:
		body.jump_power = -300
		$".".queue_free()
