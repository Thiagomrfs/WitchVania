extends Area2D

func _ready():
	if get_parent().get_parent().get_node("player").dark_phase:
		$".".modulate = Color(0.50, 0.50, 0.50)

func _on_speed_powerUp_body_entered(body):
	if "player" in body.name:
		body.velocity += 50
		body.spawn_power_up_screen("speed")
		$".".queue_free()
