extends KinematicBody2D

onready var alive = true
export var moving = false
export var speed = 150
onready var move_direction = 0
onready var pathFollow
var velocity = Vector2.ZERO
var ForceMovement = []
export var testing = false
signal Terrorist_Die

func _ready():
	connect("Terrorist_Die", owner, "_on_Terrorist_Die")
	$Sprite2.play("Idle")
	if moving == true:
		pathFollow = get_parent()

func _physics_process(delta):
	if ForceMovement.size() != 0:
		velocity = velocity.move_toward(-ForceMovement[0] ,5000* delta)
	elif ForceMovement.size() == 0:
		velocity = Vector2.ZERO
	if moving == true:
		MovementLoop(delta)
		AnimationLoop()
	velocity = move_and_slide(velocity)

func MovementLoop(delta):
	var prepos = pathFollow.get_global_position()
	pathFollow.set_offset(pathFollow.get_offset() + speed + delta)
	var pos = pathFollow.get_global_position()
	move_direction = (pos.angle_to_point(prepos)/ 3.14)*180

func AnimationLoop():
	var animation_direction
	if alive == true:
		if move_direction <=  -89 and move_direction >= -91:
			animation_direction = "Up"
		if move_direction >=  -1 and move_direction <= 1:
			animation_direction = "Right"
		if move_direction >= 89 and move_direction <= 191:
			animation_direction = "Down"
		if move_direction >= 120 and move_direction <= 181 :
			animation_direction = "Left"
		if animation_direction != null:
			$Sprite2.play("Walk" + str(animation_direction))
		else:
			pass

func _on_Hurtbox_area_entered(area):
	if area.get_parent().is_in_group("Laser") or area.get_parent().is_in_group("Explosion"):
		alive = false
		emit_signal("Terrorist_Die")
		$Sprite2.play("Die")
		$CollisionShape2D.set_deferred("disabled", true)
		$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
		SoundManager.play_se("res://Scene/Character/NPC/NPC death.wav")
		yield($Sprite2,"animation_finished")
		queue_free()
	else:
		pass
