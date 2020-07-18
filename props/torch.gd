extends AnimatedSprite

func _on_VisibilityNotifier2D_screen_entered():
	$".".playing = true

func _on_VisibilityNotifier2D_screen_exited():
	$".".playing = false
