extends Node2D

const GrassEffect = preload("res://Effects/grasseffect.tscn")

func cge():
	var ge = GrassEffect.instance()
	get_parent().add_child(ge)
	ge.global_position = global_position

# warning-ignore:unused_argument
func _on_Hurtbox_area_entered(area):
	cge()
	queue_free()
