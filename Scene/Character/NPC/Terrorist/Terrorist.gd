extends KinematicBody2D

onready var alive = true
export var moving = false
export var speed = 150
onready var move_direction = 0
onready var pathFollow

func _ready():
	$Sprite2.play("Idle")
	if moving == true:
		pathFollow = get_parent()

func _physics_process(delta):
	if moving == true:
		MovementLoop(delta)
		AnimationLoop()

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
		$Sprite2.play("Walk" + str(animation_direction))
		print(move_direction)

func _on_Hurtbox_area_entered(area):
	alive = false
	Singleton.emit_signal("Terrorist_Die")
	$Sprite2.play("Die")
	$CollisionShape2D.set_deferred("disabled", true)
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	SoundManager.play_se("res://Scene/Character/NPC/NPC death.wav")
	yield($Sprite2,"animation_finished")
	queue_free()
