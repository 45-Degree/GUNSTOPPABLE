extends Node

func _ready():
	if !SoundManager.is_playing("res://Sound/Music/OfficeTheme.ogg"):
		SoundManager.play_bgm("res://Sound/Music/OfficeTheme.ogg")
	Save._on_Load()
	$AnimationPlayer.play("Wipe_Godot")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("Wipe_CopyRight")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("Wipe_Logo")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("Wipe_Color")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://Scene/UI/MainMenu/MainMenu.tscn")
