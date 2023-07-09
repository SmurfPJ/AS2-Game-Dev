extends KinematicBody2D

const playerhurt = preload("res://Player/playerhurt.tscn")

export var acc = 500
export var ms = 80
export var fr = 500
export var rs = 125

var velo = Vector2.ZERO
var state = MOVE
var rollv = Vector2.DOWN
var stats = PLayerStats

onready var hurtbox = $Hurtbox
onready var ap = $AnimationPlayer
onready var bap = $Blinkanim
onready var at = $AnimationTree
onready var ans = at.get("parameters/playback")
onready var sh = $hitbox/Hitbox
onready var hu = $Healthup

enum {
	MOVE,
	ROLL,
	ATTACK
}

func _ready():
	randomize()
	stats.connect("nhp", self, "queue_free")
	at.active = true
	sh.kbv = rollv

func _process(delta):
	if stats.hp == stats.maxhp:
		hu.collision_layer = 0
	else:
		hu.collision_layer = 7
	
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)

func move_state(delta):
	var ip = Vector2.ZERO
	ip.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	ip.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	ip = ip.normalized()
	
	if ip != Vector2.ZERO:
		rollv = ip
		sh.kbv = ip
		at.set("parameters/idle/blend_position", ip)
		at.set("parameters/Run/blend_position", ip)
		at.set("parameters/Attack/blend_position", ip)
		at.set("parameters/Roll/blend_position", ip)
		ans.travel("Run")
		velo = velo.move_toward(ip * ms, acc * delta)
	else: 
		ans.travel("Idle")
		velo = velo.move_toward(Vector2.ZERO, fr * delta)
	move()
	
	if Input.is_action_just_pressed("Roll"):
		state = ROLL
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

# warning-ignore:unused_argument
func attack_state(delta):
	velo = Vector2.ZERO
	ans.travel("Attack")

# warning-ignore:unused_argument
func roll_state(delta):
		velo = rollv * rs
		ans.travel("Roll")
		move()

func move():
	velo = move_and_slide(velo)

func raf():
	velo = velo / 2
	state = MOVE

func aaf():
	state = MOVE

# warning-ignore:unused_argument
func _on_Hurtbox_area_entered(area):
	stats.hp -= area.damage
	hurtbox.startinvincibility(0.8)
	hurtbox.createhiteffect()
	var Playerhurt = playerhurt.instance()
	get_tree().current_scene.add_child(Playerhurt)

func _on_Hurtbox_invincibilitystart():
	bap.play("start")

func _on_Hurtbox_invincibilityend():
	bap.play("stop")
	
