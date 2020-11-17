extends Area2D
onready var animatedSprite = $Sprite

func _ready():
	pass

func detector_ON():
	animatedSprite.play("Clear")
	
