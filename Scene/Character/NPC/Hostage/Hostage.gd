extends StaticBody2D

signal Hostage_Die
signal Terrorist_Die
var HostageAnim = 0

func _ready():
	HostageAnim = int(rand_range(1,4))
	connect("Hostage_Die", owner, "_on_Hostage_Die")
	$AnimatedSprite.play("HostageIdle_" + str(HostageAnim))

func _on_Hurtbox_area_entered(area):
	$AnimatedSprite.play("HostageDie_" + str(HostageAnim))
	Singleton.emit_signal("Hostage_Die")
	Singleton.hostagePosition = self.global_position
	$Hurtbox/CollisionShape2D.set_deferred("disabled",true)
	emit_signal("Hostage_Die")
	SoundManager.play_se("res://Scene/Character/NPC/NPC death.wav")

func invincible():
	$Hurtbox/CollisionShape2D.disabled = true
