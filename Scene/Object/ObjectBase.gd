extends StaticBody2D
onready var animationPlayer = $AnimationPlayer
export var health = 10
var invincible = false
export var destroyable = false
export var explodable = false
export var Reflectable = false
export var pickable = false
export var unlockable = false
export var fallable = false
export var fallableSide = false
export var Laser = false
export var Emit = false
export var button = false
export var Star = false
export(int, "Left", "Right", "Top", "Bottom") var BulletSpawn
onready var animatedSprite = $AnimatedSprite
onready var particle = $Particles2D
onready var timer = $Timer
var sound_clip = preload("res://Sound/SFX/Object/Keycard_3.wav")
onready var shelf = preload("res://Scene/Object/Shelf/ShelfFrontFallen.tscn")
onready var shelfSide = preload("res://Scene/Object/Shelf/ShelfSideFallen.tscn")
onready var explodeDamage = preload("res://Scene/Object/Heater/ExplosionDamage.tscn")
signal Star_Pick

func _ready():
	$AnimationPlayer.play("Idle")
	
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
	if Star == true:
		connect("Star_Pick", owner,"_on_Star_Pick")
		emit_signal("Star_Pick")
		SoundManager.play_se("res://Sound/SFX/Object/Keycard_3.wav")
		queue_free()
#	if Reflectable == true:
#		var BulletP_Instance = Bullet.instance()
#		var world = get_tree().current_scene
#		world.call_deferred("add_child", BulletP_Instance)
#		if BulletSpawn == 0:
#			BulletP_Instance.position = $BulletSpawnLeft.get_global_position()
#			BulletP_Instance.direction = Vector2.LEFT.normalized()
#		if BulletSpawn == 1:
#			BulletP_Instance.position = $BulletSpawnRight.get_global_position()
#			BulletP_Instance.direction = Vector2.RIGHT.normalized()
#		if BulletSpawn == 2:
#			BulletP_Instance.position = $BulletSpawnUp.get_global_position()
#			BulletP_Instance.direction = Vector2.UP.normalized()
#		if BulletSpawn == 3:
#			BulletP_Instance.position = $BulletSpawnDown.get_global_position()
#			BulletP_Instance.direction = Vector2.DOWN.normalized()
#		BulletP_Instance.rotation = BulletP_Instance.direction.angle()
func _on_Hurtbox_area_exited(area):
	if Laser == true:
		Emit = false
	if button == true:
		animatedSprite.play("Red")

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



