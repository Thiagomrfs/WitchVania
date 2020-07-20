extends CanvasLayer

signal scene_changed()

func change_scene_with_transition(path, delay=0):
	yield(get_tree().create_timer(delay), "timeout")
	$Control/AnimationPlayer.play("fade in")
	yield($Control/AnimationPlayer, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	$Control/AnimationPlayer.play("fade out")
	emit_signal("scene_changed")
