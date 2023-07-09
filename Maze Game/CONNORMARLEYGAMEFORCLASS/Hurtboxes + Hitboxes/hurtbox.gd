extends Area2D

const he = preload ("res://Effects/hiteffect.tscn")

var invincible = false setget set_invincible
onready var timer = $Timer
onready var cs = $CollisionShape2D
signal invincibilitystart
signal invincibilityend

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal ("invincibilitystart")
	else:
		emit_signal ("invincibilityend")

func startinvincibility(duration):
	self.invincible = true
	timer.start(duration)

func createhiteffect():
	var effect = he.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position

func _on_Timer_timeout():
	self.invincible = false
 
func _on_Hurtbox_invincibilitystart():
	cs.set_deferred("disabled", true)
 
func _on_Hurtbox_invincibilityend():
	cs.disabled = false
