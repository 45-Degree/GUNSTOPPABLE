extends StaticBody2D

export(NodePath) var node_path
onready var animationPlayer = $AnimationPlayer
export var health = 10
var invincible = false
export var destroyable = false
export var explodable = false
export var pickable = false
export var bridge = false
export var platform = false
export var barrel = false
export(int, "Left", "Right", "Top", "Bottom") var BulletSpawn
onready var animatedSprite = $AnimatedSprite
onready var timer = $Timer
var sound_clip = preload("res://Sound/SFX/Object/Keycard_3.wav")
export(PackedScene) var explodeDamage 

func _ready():
	animationPlayer.play("Idle")
	
func _process(delta):
	if health <= 0:
		SoundManager.play_se("res://Sound/SFX/Object/66780__kevinkace__crate-break-4 (1).wav")
		queue_free()

func _on_Hurtbox_area_entered(area):
	if bridge and area.get_parent().flaming :
		modulate.a = 0.5
		$MiddleCollsion.set_deferred("disabled", false)
	if explodable and area.get_parent().flaming:
		var explodeInstance = explodeDamage.instance()
		explodeInstance.position = self.get_global_position()
		get_tree().current_scene.add_child(explodeInstance)
		queue_free()

func _on_Hurtbox_area_exited(area):
	if platform:
		modulate.a = 0.5
		$CollisionShape2D.set_deferred("disabled", false)
