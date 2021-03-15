extends Node

onready var animationPlayer = $AnimationPlayer

func wipeIn():
	animationPlayer.play("Wipe_Out")
	
func wipeOut():
	animationPlayer.play("Wipe_In")
