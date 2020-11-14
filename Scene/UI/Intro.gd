extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Wipe_Godot")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("Wipe_CopyRight")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("Wipe_Logo")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("Wipe_Color")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://Scene/UI/MainMenu.tscn")
