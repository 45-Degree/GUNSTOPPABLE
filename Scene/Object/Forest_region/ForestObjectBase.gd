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
export var button = false
export(int, "Left", "Right", "Top", "Bottom") var BulletSpawn
onready var animatedSprite = $AnimatedSprite
onready var timer = $Timer
var sound_clip = preload("res://Sound/SFX/Object/Keycard_3.wav")
export(PackedScene) var explodeDamage 

func _ready():
	animationPlayer.play("Idle")
	
func _process(delta):
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
	if area.get_parent().flaming:
		visible = false
		$MiddleCollsion.set_deferred("disabled", false)


