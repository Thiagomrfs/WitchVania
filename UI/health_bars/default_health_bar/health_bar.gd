extends Control

onready var bar = $health_bar

func update_health(health):
	bar.value = health

func update_max_health(amount):
	bar.max_value = amount
