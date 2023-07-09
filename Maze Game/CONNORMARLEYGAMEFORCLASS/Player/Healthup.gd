extends Area2D

export var health = 1

func _on_Area2D_area_entered(area):
	area.health = 1
	queue_free()
