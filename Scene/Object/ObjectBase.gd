extends StaticBody2D
onready var animationPlayer = $AnimationPlayer
export var health = 10
var invincible = false
export var destroyable = false
export var explodable = false
export var pickable = false
export var unlockable = false
onready var animatedSprite = $AnimatedSprite
onready var particle = $Particles2D
onready var timer = $Timer
onready var explodeDamage = preload("res://Scene/Effect/ExplosionDamage.tscn")

func _process(delta):
	if unlockable == true and Singleton.unlock == true:
		queue_free()
	if explodable == true and health == 0:
		var explodeInstance = explodeDamage.instance()
		explodeInstance.position = self.get_global_position()
		get_tree().current_scene.add_child(explodeInstance)
		queue_free()
	elif health == 0:
		queue_free()
	

func _on_Hurtbox_area_entered(area):
	if invincible == false and destroyable == true:
		animatedSprite.show()
		animationPlayer.play("Blink")
		particle.emitting = true
		health -= 1
		timer.start()
	
	if pickable == true:
		Singleton.unlock = true
		queue_free()
	
func _on_Timer_timeout():
	animatedSprite.hide()
	animationPlayer.play("Idle")
	particle.emitting = false
	
