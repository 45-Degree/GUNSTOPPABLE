extends KinematicBody2D

export var BULLET = false
export var LASER = false
export var MAX_SPEED = 175
var ACCELERATION = 10000
var FRICTION = 10000
var state = STOP
export var health = 4
var invul = false
var invulTime = 1
var velocity = Vector2.ZERO
var target = Vector2.ZERO
var target_sight = Vector2.ZERO
var input_vector = Vector2.ZERO
var bullet = preload("res://Scene/Character/Player/Gun/Bullet/Bullet.tscn")
var hiteffect = preload("res://Scene/Character/Player/Gun/ExplosionEffect/Explosion.tscn")
onready var LaserBeam = $LaserBeam
onready var animationTree = $AnimationTree
onready var bulletPoint = $Gun/Bulletpoint
onready var animationState = animationTree.get("parameters/playback")

enum{
	SHOOT,
	STOP
}

func _ready():
	state = STOP

func _physics_process(delta):
	if BULLET == true:
		state = SHOOT
		LaserBeam.enabled = false
		LaserBeam.visible = false
		$LaserBeam/Area2D/CollisionShape2D.disabled = true
	elif LASER == true:
		state = STOP
		LaserBeam.enabled = true
		LaserBeam.visible = true
	else:
		state = STOP
		LaserBeam.enabled = false
		LaserBeam.visible = false
	match state:
			SHOOT:
					$Gun.shoot()
					if Singleton.Playable == false:
						state = STOP
			STOP:
				pass
	target_sight = get_local_mouse_position()
	
	if Input.is_action_just_pressed("shoot") and Singleton.Playable == true:
		BULLET = true
	if Input.is_action_just_pressed("StopFire"):
		BULLET = false
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
	if LaserBeam.is_colliding():
		var reflect = LaserBeam.get_collider()
		var reflectParent = LaserBeam.get_collider().get_parent()
		if reflect.is_in_group("Bounce"):
			var LaserEnd = LaserBeam.get_collision_point()
			var LaserNormal = LaserBeam.get_collision_normal()
			var forward = LaserEnd - LaserBeam.global_position
			var reflection = -forward.reflect(LaserNormal)
			reflect.get_node("LaserBeam").global_rotation = reflection.angle()
			reflect.get_node("LaserBeam").global_position = LaserEnd
			reflect.get_node("LaserBeam").visible = true
