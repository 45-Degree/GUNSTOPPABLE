extends Node

func _ready():
	$AnimationPlayer.play("Wipe_Godot")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("Wipe_CopyRight")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("Wipe_Logo")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("Wipe_Color")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://Scene/UI/MainMenu/MainMenu.tscn")
