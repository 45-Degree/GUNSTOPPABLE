extends Node2D

onready var animatedSprite = $AnimatedSprite

func _ready():
	SoundManager.play_se("res://Sound/SFX/Object/Explosive_1.wav")
	animatedSprite.frame = 0
	animatedSprite.play("default")

func _on_AnimatedSprite_animation_finished():
	queue_free()
