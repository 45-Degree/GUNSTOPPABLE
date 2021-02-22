extends Node2D
onready var animatedSprite = $Sprite
signal passable

func _ready():
	connect("passable", owner,"_on_Passable")
	animatedSprite.play("notClear")

func detector_ON():
	animatedSprite.play("Clear")

func _on_Area2D_body_entered(body):
	emit_signal("passable")
