extends StaticBody2D

signal Hostage_Die
signal Terrorist_Die

func _ready():
	connect("Hostage_Die", owner, "_on_Hostage_Die")
	$AnimatedSprite.play("HostageIdle_" + str(randi() % 4 + 1 ))

func _on_Hurtbox_area_entered(area):
	Singleton.emit_signal("Hostage_Die")
	Singleton.hostagePosition = self.global_position
	emit_signal("Hostage_Die")
	SoundManager.play_se("res://Scene/Character/NPC/NPC death.wav")
	queue_free()

func invincible():
	$Hurtbox/CollisionShape2D.disabled = true
