extends KinematicBody2D

var MAX_SPEED = 100
var ACCELERATION = 2000
var motion = Vector2.ZERO
var target = Vector2()
export var speed = 100

onready var sprite = get_node("AnimatedSprite")
var anim = "idle"

func _physics_process(delta):
	target = get_global_mouse_position()
	if motion.x == 0:
		anim = "idle"
	else:
		anim = "runf"
	if target.x > self.position.x :
		sprite.set_flip_h(false)
	if Input.is_action_pressed("ui_left") == true or Input.is_action_pressed("ui_down") == true:
		anim = "runb"
	elif Input.is_action_pressed("ui_right") == true or Input.is_action_pressed("ui_up") == true:
		anim = "runf" 
	elif target.x < self.position.x :
		sprite.set_flip_h(true)
	if Input.is_action_pressed("ui_left") == true or Input.is_action_pressed("ui_up") == true:
		anim = "runf" 
	elif Input.is_action_pressed("ui_right") == true or Input.is_action_pressed("ui_down") == true:
		anim = "runb"
	sprite.play(anim)
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)
		motion = move_and_slide(motion)


func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()


func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)
