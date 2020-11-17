extends StaticBody2D
onready var animationPlayer = $AnimationPlayer
export var health = 10
var invincible = false
export var destroyable = false
export var explodable = false
export var pickable = false
export var unlockable = false
export var fallable = false
export var fallableSide = false
onready var animatedSprite = $AnimatedSprite
onready var particle = $Particles2D
onready var timer = $Timer
var sound_clip = preload("res://Sound/SFX/Object/Keycard_3.wav")
onready var shelf = preload("res://Scene/Object/Shelf/ShelfFrontFallen.tscn")
onready var shelfSide = preload("res://Scene/Object/Shelf/ShelfSideFallen.tscn")
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
		SoundManager.play_se("res://Sound/SFX/Object/66780__kevinkace__crate-break-4 (1).wav")
		queue_free()
	

func _on_Hurtbox_area_entered(area):
	if invincible == false and destroyable == true:
		animatedSprite.show()
		animationPlayer.play("Blink")
		particle.emitting = true
		health -= 1
		timer.start()
	if fallable == true:
		var shelfInstance = shelf.instance()
		var world = get_tree().current_scene
		world.add_child(shelfInstance)
		shelfInstance.position = self.get_global_position() + Vector2(0,30)
		SoundManager.play_se("res://Sound/SFX/Object/Shelf_3.wav")
		queue_free()
	if fallableSide == true:
		var shelfSideInstance = shelfSide.instance()
		var world = get_tree().current_scene
		world.add_child(shelfSideInstance)
		shelfSideInstance.position = self.get_global_position() + Vector2(30,15)
		SoundManager.play_se("res://Sound/SFX/Object/Shelf_3.wav")
		queue_free()
	if pickable == true:
		Singleton.unlock = true
		SoundManager.play_se("res://Sound/SFX/Object/Keycard_3.wav")
		queue_free()
	
func _on_Timer_timeout():
	animatedSprite.hide()
	animationPlayer.play("Idle")
	particle.emitting = false

func _on_Hurtbox2_area_entered(area):
	if fallable == true:
		var shelfInstance = shelf.instance()
		var world = get_tree().current_scene
		world.add_child(shelfInstance)
		shelfInstance.position = self.get_global_position() + Vector2(0,-30)
		SoundManager.play_se("res://Sound/SFX/Object/Shelf_3.wav")
		queue_free()
	if fallableSide == true:
		var shelfSideInstance = shelfSide.instance()
		var world = get_tree().current_scene
		world.add_child(shelfSideInstance)
		shelfSideInstance.position = self.get_global_position() + Vector2(-30,15)
		SoundManager.play_se("res://Sound/SFX/Object/Shelf_3.wav")
		queue_free()
