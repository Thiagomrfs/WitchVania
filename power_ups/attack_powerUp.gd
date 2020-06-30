extends Area2D

func _on_attack_powerUp_body_entered(body):
	if "player" in body.name:
		body.is_attack_boosted = true
		$".".queue_free()
