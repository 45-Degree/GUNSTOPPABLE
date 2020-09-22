extends Area2D
onready var animatedSprite = $Sprite

func _ready():
	pass # Replace with function body.

func detector_ON():
	animatedSprite.play("Clear")
	
