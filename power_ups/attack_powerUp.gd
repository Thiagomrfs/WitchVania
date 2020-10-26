extends Area2D

signal attack_powered()

func _ready():
	if get_parent().get_parent().get_node("player").dark_phase:
		$".".modulate = Color(0.50, 0.50, 0.50)

func _on_attack_powerUp_body_entered(body):
	if "player" in body.name:
		body.is_attack_boosted = true
		body.spawn_power_up_screen("attack")
		body.get_node("GUI/player_GUI/icons_holder/items/power_ups_container/power_ups/attack_power_up/attack").modulate = Color(1,1,1,1)
		$".".queue_free()
