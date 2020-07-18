extends Area2D

export(String, FILE, "*.tscn") var target_stage
onready var fade_in = get_node("timers/fade_in_timer")
onready var fade_out = get_node("timers/fade_out_timer")


func _ready():
	pass

func _on_Area2D_body_entered(body):
	if "player" in body.name:
		$Scene_tansition.change_scene(target_stage)
		#get_tree().change_scene(target_stage)

