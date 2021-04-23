extends KinematicBody2D

signal Hostage_Die
signal Terrorist_Die
var ForceMovement = []
var velocity = Vector2.ZERO

func _ready():
	connect("Hostage_Die", owner, "_on_Hostage_Die")
	$AnimatedSprite.play("LabHostageIdle_" + str(randi() % 4 + 1 ))

func _physics_process(delta):
	if ForceMovement.size() != 0:
		velocity = velocity.move_toward(-ForceMovement[0] ,5000* delta)
	elif ForceMovement.size() == 0:
		velocity = Vector2.ZERO
	velocity = move_and_slide(velocity)

func _on_Hurtbox_area_entered(area):
	if area.get_parent().is_in_group("Laser") or area.get_parent().is_in_group("Explosion"):
		Singleton.emit_signal("Hostage_Die")
		Singleton.hostagePosition = self.global_position
		emit_signal("Hostage_Die")
		SoundManager.play_se("res://Scene/Character/NPC/NPC death.wav")
		queue_free()
	else:
		pass

func invincible():
	$Hurtbox/CollisionShape2D.disabled = true
