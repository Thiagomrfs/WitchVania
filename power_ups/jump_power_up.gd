extends Area2D

func _ready():
	if get_parent().get_parent().get_node("player").dark_phase:
		$".".modulate = Color(0.50, 0.50, 0.50)

func _on_Area2D_body_entered(body):
	if "player" in body.name:
		body.jumps += 1
		$".".queue_free()
