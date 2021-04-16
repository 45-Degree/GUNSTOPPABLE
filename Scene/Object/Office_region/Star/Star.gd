extends KinematicBody2D

signal Star_Pick
onready var ForceMovement =  []
var velocity = Vector2.ZERO

func _ready():
	connect("Star_Pick", owner,"_on_Star_Pick")

func _physics_process(delta):
	if ForceMovement.size() != 0:
		velocity = velocity.move_toward(ForceMovement[0] ,50* delta)
	elif ForceMovement.size() == 0:
		velocity = Vector2.ZERO
	velocity = move_and_slide(velocity)
	
func _on_Hurtbox_body_entered(body):
	emit_signal("Star_Pick")
	SoundManager.play_se("res://Sound/SFX/Object/Keycard_3.wav")
	queue_free()

