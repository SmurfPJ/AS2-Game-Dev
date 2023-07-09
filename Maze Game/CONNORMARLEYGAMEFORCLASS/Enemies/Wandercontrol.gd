extends Node2D

export(int) var wanderrange = 32
onready var startp = global_position
onready var targetp = global_position
onready var timer = $Timer

func _ready():
	updatetp()

func updatetp():
	var tagetv = Vector2(rand_range(-wanderrange,wanderrange), rand_range(-wanderrange,wanderrange))
	targetp = startp + tagetv

func timleft():
	return timer.time_left

func starttimer(duration):
	timer.start(duration)

func _on_Timer_timeout():
	updatetp()
