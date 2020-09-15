extends Node

var Playable = true
var current_stage = 1

signal Hostage_Die
signal Terrorist_Die


func go_next_stage():
	current_stage += 1
	get_tree().change_scene("res://Scene/Levels/Level "+str(current_stage)+".xml")
