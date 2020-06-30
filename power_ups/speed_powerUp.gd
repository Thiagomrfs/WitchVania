extends Area2D



func _on_speed_powerUp_body_entered(body):
	if "player" in body.name:
		body.velocity += 50
		$".".queue_free()
