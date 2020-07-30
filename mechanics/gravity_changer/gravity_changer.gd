extends StaticBody2D

export(int) var uses = 1
signal gravity_changed()

func _on_Area2D_body_entered(body):
	if "player" in body.name:
		if uses > 0:
			emit_signal("gravity_changed")
			body.GRAVITY *= -1
			body.scale.y *= -1
			body.get_node("health_bar").visible = true
			body.jump_power *= -1
			uses -= 1
