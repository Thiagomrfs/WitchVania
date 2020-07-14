extends AnimatedSprite

func _on_Area2D_body_entered(body):
	if "player" in body.name:
		$".".playing = true


func _on_Area2D_body_exited(body):
	if "player" in body.name:
		$".".playing = false
