extends KinematicBody2D

const Edf = preload("res://Effects/EnemyDeath.tscn")

export var acc = 300
export var ms = 40
export var fr = 200

enum {
	IDLE,
	WANDER,
	CHASE
}

var state = IDLE
var velo = Vector2.ZERO
var kb = Vector2.ZERO
onready var ans = $Bat
onready var stats = $stats
onready var pdz = $Pdetect
onready var hurtbox = $Hurtbox
onready var softc = $Soft
onready var wc = $Wandercontrol
onready var ap = $AnimationPlayer
onready var col = $ColorRect2

func _ready():
	state = pickrandstate([IDLE,WANDER])

func _physics_process(delta):
	kb = kb.move_toward(Vector2.ZERO, 200 * delta)
	kb = move_and_slide(kb)
	
	match state:
		IDLE:
			velo = velo.move_toward(Vector2.ZERO, fr * delta)
			seek()
			stateseek()
			
		WANDER:
			seek()
			stateseek()
			var direction = global_position.direction_to(wc.targetp)
			velo = velo.move_toward(direction * ms, acc * delta)
			ans.flip_h = velo.x < 0
			
			if global_position.distance_to(wc.targetp) <= 4:
				state = pickrandstate([IDLE,WANDER])
				wc.starttimer(rand_range(1,3))
			
		CHASE:
			var player = pdz.player
			if player != null:
				var direction = global_position.direction_to(player.global_position)
				velo = velo.move_toward(direction * ms, acc * delta)
			else:
				state = IDLE
				ans.flip_h = velo.x < 0
		
	if softc.is_colliding():
		velo += softc.get_push_vector() * delta * 400
	velo = move_and_slide(velo)

func seek():
	if pdz.canseeplayer():
		state = CHASE

func stateseek():
	if wc.timleft() == 0:
				state = pickrandstate([IDLE,WANDER])
				wc.starttimer(rand_range(1,3))

func pickrandstate(statelist):
	statelist.shuffle()
	return statelist.pop_front()

func _on_Hurtbox_area_entered(area):
	stats.hp -= area.damage
	kb = area.kbv * 150
	hurtbox.createhiteffect()
	hurtbox.startinvincibility(0.4)
	col.rect_size.x = stats.hp * 8
 
func _on_stats_nhp():
	queue_free()
	var edf = Edf.instance()
	get_parent().add_child(edf)
	edf.global_position = global_position


func _on_Hurtbox_invincibilityend():
	ap.play("stop")


func _on_Hurtbox_invincibilitystart():
	ap.play("start")
