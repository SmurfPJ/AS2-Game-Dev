extends Control

var hearts = 4 setget set_hearts
var maxhearts = 4 setget setmaxhearts

onready var HuiE = $HeartUI_Empty
onready var HuiF = $HeartUI_FULL


func set_hearts(value):
	hearts = clamp(value, 0, maxhearts)
	if HuiF != null:
		HuiF.rect_size.x = hearts * 15

func setmaxhearts(value):
	maxhearts = max(value, 1)
	self.hearts = min(hearts, maxhearts)
	if HuiE != null:
		HuiE.rect_size.x = maxhearts * 15

func _ready():
	self.maxhearts = PLayerStats.maxhp
	self.hearts = PLayerStats.hp
# warning-ignore:return_value_discarded
	PLayerStats.connect("hpchanged", self, "set_hearts")
# warning-ignore:return_value_discarded
	PLayerStats.connect("maxhpchange", self, "setmaxhearts")
