extends KinematicBody2D

var MAX_SPEED = 250
var ACCELERATION = 10000
var FRICTION = 10000
var state = STOP

var velocity = Vector2.ZERO
var target = Vector2.ZERO
var target_sight = Vector2.ZERO
var input_vector = Vector2.ZERO
var bullet = preload("res://Scene/Bullet.tscn")

onready var gunSprite = $Gun/Sprite
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
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	target_sight = target_sight.normalized()
	
	if input_vector == Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", target_sight)
		animationTree.set("parameters/Run/blend_position", target_sight)
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	else:
		animationTree.set("parameters/Idle/blend_position", target_sight)
		animationTree.set("parameters/Run/blend_position", target_sight)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("shoot") and Singleton.Playable == true:
		state = SHOOT
	if Input.is_action_just_pressed("stop"):
		state = STOP
		


