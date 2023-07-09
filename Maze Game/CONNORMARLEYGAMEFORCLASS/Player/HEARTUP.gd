extends Area2D

export var health = 1

func _on_Area2D_area_entered(area):
	queue_free()
