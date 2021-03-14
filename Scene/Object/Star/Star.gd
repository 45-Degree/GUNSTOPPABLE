extends StaticBody2D

signal Star_Pick

func _ready():
	connect("Star_Pick", owner,"_on_Star_Pick")

func _on_Hurtbox_body_entered(body):
	emit_signal("Star_Pick")
	SoundManager.play_se("res://Sound/SFX/Object/Keycard_3.wav")
	queue_free()

