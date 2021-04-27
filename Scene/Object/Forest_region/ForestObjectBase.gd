extends StaticBody2D

export(NodePath) var node_path
onready var animationPlayer = $AnimationPlayer
export var health = 10
var invincible = false
export var destroyable = false
export var explodable = false
export var pickable = false
export var bridge = false
export var Bush = false
export var platform = false
export var barrel = false
export(int, "Left", "Right", "Top", "Bottom") var BulletSpawn
onready var animatedSprite = $AnimatedSprite
var sound_clip = preload("res://Sound/SFX/Object/Keycard_3.wav")
export(PackedScene) var explodeDamage 

func _ready():
	animationPlayer.play("Idle")

func _on_Hurtbox_area_entered(area):
	if bridge and area.get_parent().flaming :
		modulate.a = 0.5
		$MiddleCollsion.set_deferred("disabled", false)
	if Bush and area.get_parent().flaming:
		$Burn.show()
		$Burn.play("Burn")
		$CollisionShape2D.set_deferred("disabled", true)
		$Hurtbox/CollisionShape2D2.set_deferred("disabled", true)
		yield(get_tree().create_timer(0.7),"timeout")
		$AnimatedSprite.hide()

	if explodable and area.get_parent().flaming:
		var explodeInstance = explodeDamage.instance()
		explodeInstance.position = self.get_global_position()
		get_tree().current_scene.add_child(explodeInstance)
		queue_free()

func _on_Hurtbox_area_exited(area):
	if platform:
		modulate.a = 0.5
		$CollisionShape2D.set_deferred("disabled", false)

func _on_Burn_animation_finished():
	queue_free()
