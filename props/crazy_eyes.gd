extends AnimatedSprite

func _on_VisibilityNotifier2D_screen_entered():
	$".".playing = true
	$Light2D.enabled = true
	$Light2D2.enabled = true
	$Light2D3.enabled = true
	$Light2D4.enabled = true


func _on_VisibilityNotifier2D_screen_exited():
	$".".playing = false
	$Light2D.enabled = false
	$Light2D2.enabled = false
	$Light2D3.enabled = false
	$Light2D4.enabled = false
