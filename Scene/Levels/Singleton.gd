extends Node

var Playable = true
var current_stage = 1
var hostagePosition = Vector2.ZERO
var unlock = false

signal Hostage_Die
signal Terrorist_Die


func _physics_process(delta):
	print(SoundManager.get_playing_sounds())
