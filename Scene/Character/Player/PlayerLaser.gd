extends KinematicBody2D

export var MAX_SPEED = 175
var ACCELERATION = 10000
var FRICTION = 10000
var state = STOP
export var health = 4
var conveyorCount = 0
var velocity = Vector2.ZERO
var target = Vector2.ZERO
var target_sight = Vector2.ZERO
var input_vector = Vector2.ZERO
var bullet = preload("res://Scene/Character/Player/Gun/Bullet/Bullet.tscn")
var hiteffect = preload("res://Scene/Character/Player/Gun/ExplosionEffect/Explosion.tscn")
onready var ForceMovement =  []
onready var LaserBeam = $LaserBeam
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

enum{
	SHOOT,
	STOP
}

func _physics_process(delta):
	print(ForceMovement)
	if Input.is_action_just_pressed("shoot"):
		state = SHOOT
	if Input.is_action_just_pressed("StopFire"):
		state = STOP
	match state:
			SHOOT:
				LaserBeam.visible = true
				LaserBeam.enabled = true
				LaserBeam.cast_to = Vector2(2000,0)
			STOP:
				LaserBeam.visible = false
				LaserBeam.enabled = false
				LaserBeam.cast_to = Vector2(0,0)
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
		if ForceMovement.size() != 0:
			velocity = velocity.move_toward((Vector2.ZERO * MAX_SPEED) - ForceMovement[0], FRICTION * delta)
		elif ForceMovement.size() == 0:
				velocity = velocity.move_toward((Vector2.ZERO * MAX_SPEED), FRICTION * delta)
	
	elif input_vector != Vector2.ZERO and Singleton.Playable == true:
		animationTree.set("parameters/Idle/blend_position", target_sight)
		animationTree.set("parameters/Run/blend_position", target_sight)
		animationState.travel("Run")
		if ForceMovement.size() != 0:
			velocity = velocity.move_toward((input_vector * MAX_SPEED) - ForceMovement[0], ACCELERATION * delta)
		elif ForceMovement.size() == 0:
			velocity = velocity.move_toward((input_vector * MAX_SPEED), ACCELERATION * delta)
	
	elif Singleton.Playable == false:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
