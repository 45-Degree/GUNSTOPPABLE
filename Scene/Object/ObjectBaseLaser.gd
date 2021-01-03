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
export(int, "Left", "Right", "Top", "Bottom") var BulletSpawn
export(int, "Left", "Right", "Top", "Bottom") var LaserSpawn
onready var animatedSprite = $AnimatedSprite
onready var particle = $Particles2D
onready var timer = $Timer
onready var LaserBeam = $LaserBeam
var sound_clip = preload("res://Sound/SFX/Object/Keycard_3.wav")
onready var shelf = preload("res://Scene/Object/Shelf/ShelfFrontFallen.tscn")
onready var Bullet = preload("res://Scene/Player/Bullet.tscn")
onready var shelfSide = preload("res://Scene/Object/Shelf/ShelfSideFallen.tscn")
onready var explodeDamage = preload("res://Scene/Effect/ExplosionDamage.tscn")

func _ready():
		LaserBeam.cast_to = Vector2.ZERO
		LaserBeam.visible = false

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
	if Laser == false:
		LaserBeam.enabled = false
		LaserBeam.visible = false
	if Input.is_action_pressed("Laser"):
		LaserBeam.enabled = true
		LaserBeam. visible = true
		
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
	if Reflectable == true:
		var BulletP_Instance = Bullet.instance()
		var world = get_tree().current_scene
		world.call_deferred("add_child", BulletP_Instance)
		if BulletSpawn == 0:
			BulletP_Instance.position = $BulletSpawnLeft.get_global_position()
			BulletP_Instance.direction = Vector2.LEFT.normalized()
		if BulletSpawn == 1:
			BulletP_Instance.position = $BulletSpawnRight.get_global_position()
			BulletP_Instance.direction = Vector2.RIGHT.normalized()
		if BulletSpawn == 2:
			BulletP_Instance.position = $BulletSpawnUp.get_global_position()
			BulletP_Instance.direction = Vector2.UP.normalized()
		if BulletSpawn == 3:
			BulletP_Instance.position = $BulletSpawnDown.get_global_position()
			BulletP_Instance.direction = Vector2.DOWN.normalized()
		BulletP_Instance.rotation = BulletP_Instance.direction.angle()
	if Laser == true:
		LaserBeam.enabled = true
		LaserBeam.visible = true
		if LaserSpawn == 0:
			LaserBeam.global_position = $BulletSpawnLeft.get_global_position()
			LaserBeam.cast_to = Vector2(-2000,0)
		if LaserSpawn == 1:
			LaserBeam.global_position = $BulletSpawnRight.get_global_position()
			LaserBeam.cast_to = Vector2(2000,0)
		if LaserSpawn == 2:
			LaserBeam.global_position = $BulletSpawnUp.get_global_position()
			LaserBeam.cast_to = Vector2(0,-2000)
		if LaserSpawn == 3:
			LaserBeam.global_position = $BulletSpawnDown.get_global_position()
			LaserBeam.cast_to = Vector2(0,2000)
#
func _on_Hurtbox_area_exited(area):
	if Laser == true:
		LaserBeam.visible = false
		LaserBeam.cast_to = Vector2.ZERO

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





