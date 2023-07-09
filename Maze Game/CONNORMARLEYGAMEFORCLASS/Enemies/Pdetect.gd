extends Area2D

var player = null

func canseeplayer():
	return player != null

func _on_Pdetect_body_entered(body):
	player = body

# warning-ignore:unused_argument
func _on_Pdetect_body_exited(body):
	player = null
