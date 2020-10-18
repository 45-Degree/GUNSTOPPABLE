extends KinematicBody2D

var MAX_SPEED = 250
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
var bullet = preload("res://Scene/Bullet.tscn")
var hiteffect = preload("res://Scene/Effect/Explosion.tscn")

onready var gunSprite = $Gun/Sprite
onready var animationTree = $AnimationTree
onready var bulletPoint = $Gun/Bulletpoint
onready var animationState = animationTree.get("parameters/playback")

enum{
	SHOOT,
	STOP
}

func _physics_process(delta):
	if health <= 0:
		print("death")
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

func _on_Hurtbox_area_entered(area):
	if invul == false:
		invul = true
		health -= 1
		var hiteffect_instance = hiteffect.instance()
		get_parent().add_child(hiteffect_instance)
		hiteffect_instance.global_position = global_position
		yield(get_tree().create_timer(invulTime), "timeout")
		invul = false
