extends AnimatedSprite

func _ready():
# warning-ignore:return_value_discarded
	connect("animation_finished", self, "oaf")
	play("Animate")

func oaf():
	queue_free()
