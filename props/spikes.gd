extends Sprite

func _on_Area2D_body_entered(body):
	if "player" in body.name:
		body.death()
