extends Node2D

export(int) var maxhp = 1 setget setmaxhp
var hp = maxhp setget sethp

signal nhp
signal hpchanged(value)
signal maxhpchange(value)

func setmaxhp(value):
	maxhp = value
	self.hp = min(hp, maxhp)
	emit_signal("maxhpchange")
	
func sethp(value):
	hp = value
	emit_signal("hpchanged", hp)
	if hp <= 0:
		emit_signal("nhp")

func _ready():
	self.hp = maxhp	
