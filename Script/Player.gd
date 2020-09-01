extends KinematicBody2D

var MAX_SPEED = 100
var ACCELERATION = 500
var FRICTION = 500
export var bullet_speed  = 500

var velocity = Vector2.ZERO
var target = Vector2()

var bullet = preload("res://Scene/Bullet.tscn")

onready var animatedSprite = $Knight
onready var gunSprite = $Gun


func _process(delta):
	
	if Input.is_action_just_pressed("shoot"):
		var bullet_instance = bullet.instance()
		bullet_instance.position = get_global_position() 
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)

func _physics_process(delta):
	target = get_global_mouse_position()
	gunSprite.look_at(target)
	if target.x > self.global_position.x :
		gunSprite.set_flip_v(false)
	elif target.x < self.global_position.x :
		gunSprite.set_flip_v(true)
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	target = get_global_mouse_position()
	print(target, self.global_position)
	if target.x > self.global_position.x:
			animatedSprite.set_flip_h(false)
	elif  target.x < self.global_position.x:
			animatedSprite.set_flip_h(true)
	if input_vector != Vector2.ZERO:
		animatedSprite.play("Run")
		
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	
		
	else:
#		animationState.travel("Idle")
		animatedSprite.play("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)
	
	
	

#func _physics_process(delta):
#	
#	
#	else:
#		anim = "runf"
#	if target.x > self.position.x :
#		sprite.set_flip_h(false)
#	if Input.is_action_pressed("ui_left") == true or Input.is_action_pressed("ui_down") == true:
#		anim = "runb"
#	elif Input.is_action_pressed("ui_right") == true or Input.is_action_pressed("ui_up") == true:
#		anim = "runf" 
#	elif target.x < self.position.x :
#		sprite.set_flip_h(true)
#	if Input.is_action_pressed("ui_left") == true or Input.is_action_pressed("ui_up") == true:
#		anim = "runf" 
#	elif Input.is_action_pressed("ui_right") == true or Input.is_action_pressed("ui_down") == true:
#		anim = "runb"
#	sprite.play(anim)
#	var axis = get_input_axis()
#	if axis == Vector2.ZERO:
#		apply_friction(ACCELERATION * delta)
#	else:
#		apply_movement(axis * ACCELERATION * delta)
#		motion = move_and_slide(motion)
#
#

#
#
#func apply_friction(amount):
#	if motion.length() > amount:
#		motion -= motion.normalized() * amount
#	else:
#		motion = Vector2.ZERO
#
#func apply_movement(acceleration):
#	motion += acceleration
#	motion = motion.clamped(MAX_SPEED)
