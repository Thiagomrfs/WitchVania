extends CanvasLayer


func change_scene(path, delay=0.5):
	yield(get_tree().create_timer(delay), "timeout")
	$Control/AnimationPlayer.play("fade in")
	yield($Control/AnimationPlayer, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	$Control/AnimationPlayer.play("fade out")
