extends Node2D

export var bullet_speed  = 200
export var firerate = 0.1
var can_fire = true
onready var gunSprite = $Sprite
onready var animationTree = $AnimationTree
onready var bulletPoint = $Bulletpoint
var target = Vector2.ZERO
var bullet = preload("res://Scene/Bullet.tscn")

func _physics_process(delta):
	target = get_global_mouse_position()
	look_at(target)
	if target.x > self.global_position.x :
		gunSprite.set_flip_v(false)
	elif target.x < self.global_position.x :
		gunSprite.set_flip_v(true)
	var input_vector = Vector2.ZERO
	
func shoot():
	if can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = bulletPoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(firerate), "timeout")
		can_fire = true
		
			

	

