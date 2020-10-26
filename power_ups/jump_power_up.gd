extends Area2D

func _ready():
	if get_parent().get_parent().get_node("player").dark_phase:
		$".".modulate = Color(0.50, 0.50, 0.50)

func _on_Area2D_body_entered(body):
	if "player" in body.name:
		body.jumps += 1
		body.spawn_power_up_screen("jump")
		body.get_node("GUI/player_GUI/icons_holder/items/power_ups_container/power_ups/jump_power_up/jump").modulate = Color(1,1,1,1)
		$".".queue_free()
