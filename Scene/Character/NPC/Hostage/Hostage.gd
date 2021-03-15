extends StaticBody2D

signal Hostage_Die
signal Terrorist_Die

func _ready():
	connect("Hostage_Die", owner, "_on_Hostage_Die")
	$AnimatedSprite.play("HostageIdle_" + str(randi() % 4 + 1 ))

func _on_Hurtbox_area_entered(area):
	Singleton.emit_signal("Hostage_Die")
	Singleton.hostagePosition = self.global_position
	var Blood_instance = load("res://Scene/Character/NPC/Hostage/Blood.tscn")
	var blood_instace = Blood_instance.instance()
	var world = get_tree().current_scene
	world.add_child(blood_instace)
	blood_instace.global_position = global_position
	emit_signal("Hostage_Die")
	SoundManager.play_se("res://Scene/Character/NPC/NPC death.wav")
	queue_free()

func invincible():
	$Hurtbox/CollisionShape2D.disabled = true
