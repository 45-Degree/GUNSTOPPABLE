extends Node

var Playable = true
var current_stage = 1
var hostagePosition = Vector2.ZERO
var unlock = false

signal Hostage_Die
signal Terrorist_Die



func _physics_process(delta):
	if !SoundManager.is_playing("res://Sound/Music/OfficeTheme.ogg"):
		SoundManager.play_bgm("res://Sound/Music/OfficeTheme.ogg")
