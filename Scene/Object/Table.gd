extends StaticBody2D
onready var animationPlayer = $AnimationPlayer
export var health = 15
var invincible = false

func _process(delta):
	if health == 0:
		queue_free()



func _on_Hurtbox_area_entered(area):
	if invincible == false:
		health -= 1
		invincible = true
		yield(get_tree().create_timer(0.1), "timeout")
		invincible = false
	animationPlayer.play("Blink")


