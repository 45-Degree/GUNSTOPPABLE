extends KinematicBody2D

export var MAX_SPEED = 175
var ACCELERATION = 10000
var FRICTION = 10000
var state = STOP
export var health = 4
#export(int, "Left", "Right", "Top", "Bottom") var spawnHere
var invul = false
var invulTime = 1
var velocity = Vector2.ZERO
var target = Vector2.ZERO
var target_sight = Vector2.ZERO
var input_vector = Vector2.ZERO
var bullet = preload("res://Scene/Player/Bullet.tscn")
var hiteffect = preload("res://Scene/Effect/Explosion.tscn")

onready var animationTree = $AnimationTree
onready var bulletPoint = $Gun/Bulletpoint
onready var animationState = animationTree.get("parameters/playback")

enum{
	SHOOT,
	STOP
}

func _physics_process(delta):
	match state:
			SHOOT:
					$Gun.shoot()
					if Singleton.Playable == false:
						state = STOP
			STOP:
				pass
	target_sight = get_local_mouse_position()
	
	if Singleton.Playable == true:
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		input_vector = input_vector.normalized()
	else:
		input_vector.x = 0
		input_vector.y = 0
	
	target_sight = target_sight.normalized()
	if input_vector == Vector2.ZERO and Singleton.Playable == true:
		animationTree.set("parameters/Idle/blend_position", target_sight)
		animationTree.set("parameters/Run/blend_position", target_sight)
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	elif input_vector != Vector2.ZERO and Singleton.Playable == true:
		animationTree.set("parameters/Idle/blend_position", target_sight)
		animationTree.set("parameters/Run/blend_position", target_sight)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	
	elif Singleton.Playable == false:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
#
#	if Singleton.Playable == true:
#		state = SHOOT

	if Input.is_action_pressed("shoot"):
		state = SHOOT
	if Input.is_action_pressed("stop"):
		state = STOP


#func _spawn():
#	if spawnHere == 0:
#		position = position.move_toward(Vector2(x, y), delta * moveSpeed)
#	if spawnHere == 1:
#		player.position = finalPosition.get_global_position() - Vector2(100,0)
#	if spawnHere == 2:
#		player.position = finalPosition.get_global_position() - Vector2(100,0)
#	if spawnHere == 3:
#		player.position = finalPosition.get_global_position() - Vector2(100,0)


