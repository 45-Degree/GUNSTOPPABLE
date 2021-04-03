extends StaticBody2D

export(NodePath) var node_path
onready var animationPlayer = $AnimationPlayer
export var health = 10
var invincible = false
export var destroyable = false
export var explodable = false
export var Reflectable = false
export var pickable = false
export var unlockable = false
onready var damagable = false
export(int, "Left", "Right", "Top", "Bottom") var BulletSpawn
onready var animatedSprite = $AnimatedSprite
onready var particle = $Particles2D
onready var timer = $Timer
var sound_clip = preload("res://Sound/SFX/Object/Keycard_3.wav")
export(PackedScene) var explodeDamage 
signal Star_Pick

func _ready():
	$AnimationPlayer.play("Idle")
	
func _process(delta):
	if damagable == false:
				animatedSprite.hide()
				animationPlayer.play("Idle")
				particle.emitting = false
	if damagable == true:
				animatedSprite.show()
				animationPlayer.play("Blink")
				particle.emitting = true
	if unlockable == true and Singleton.unlock == true:
		queue_free()
	if explodable == true and health <= 0:
		var explodeInstance = explodeDamage.instance()
		explodeInstance.position = self.get_global_position()
		get_tree().current_scene.add_child(explodeInstance)
		queue_free()
	elif health <= 0:
		SoundManager.play_se("res://Sound/SFX/Object/66780__kevinkace__crate-break-4 (1).wav")
		queue_free()

func _on_Hurtbox_area_entered(area):
	if invincible == false and destroyable == true:
		health -= 5
		damagable = true
		$Timer.start()
	if pickable == true:
		var door = get_node(node_path)
		door.queue_free()
		SoundManager.play_se("res://Sound/SFX/Object/Keycard_3.wav")
		queue_free()

func _on_Hurtbox_area_exited(area):
	damagable = false
	$Timer.stop()

func _on_Timer_timeout():
	health -= 3