extends StaticBody2D
onready var animationPlayer = $AnimationPlayer
export var health = 15
var invincible = false
export var destroyable = false
export var explodable = false
export var pickable = false
onready var explodeDamage = preload("res://Scene/Effect/ExplosionDamage.tscn")

func _process(delta):
	if explodable == true and health == 0:
		var explodeInstance = explodeDamage.instance()
		explodeInstance.position = self.get_global_position()
		get_tree().current_scene.add_child(explodeInstance)
		queue_free()
	elif health == 0:
		queue_free()



func _on_Hurtbox_area_entered(area):
	if invincible == false and destroyable == true:
		health -= 1
		invincible = true
		yield(get_tree().create_timer(0.1), "timeout")
		invincible = false
		animationPlayer.play("Blink")
	
	if pickable == true:
		Singleton.unlock = true
		queue_free()
	



