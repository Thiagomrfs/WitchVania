extends Area2D

export(String, FILE, "*.tscn") var target_stage

func _ready():
	pass

func _on_Area2D_body_entered(body):
	if "player" in body.name:
		SceneTansition.change_scene_with_transition(target_stage)
