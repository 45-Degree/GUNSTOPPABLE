extends Node

onready var control = $Control
onready var message = $Control/Message
onready var button = $Control/Button
onready var level = (int(get_tree().current_scene.name) + 1)
onready var Complete = false
export var Hostage_dead = false

func _ready():
	Singleton.connect("Hostage_Die", self, "_on_Hostage_Die")
	Singleton.connect("Terrorist_Die", self, "_on_Terrorist_Die")

func _process(delta):
	var terrorist = get_tree().get_nodes_in_group("Terrorist").size()
	if terrorist == 0 and Hostage_dead == false:
		get_tree().call_group("Detector", "detector_ON")
		Complete = true
	if Input.is_action_just_pressed("Pause"):
		pass
	
func _on_Button_pressed():
	Singleton.Playable = true
	if Complete == true and Hostage_dead == false:
		get_tree().change_scene("res://Scene/Levels/Level_" + str(level + 1)+ ".tscn")
	else:
		get_tree().reload_current_scene()

func _on_Button2_pressed():
	Singleton.Playable = true
	get_tree().change_scene("res://Scene/UI/MainMenu.tscn")

func _on_Hostage_Die():
	Singleton.Playable = false
	Complete = false
	Hostage_dead = true
	button.set_text("Restart")
	message.set_text("You kill a hostage!")
	control.show()

func _on_Detector_body_entered(body):
	if Complete == true:
		message.set_text("MISSION COMPLETED!")
		button.set_text("Next Level")
		Singleton.Playable = false
		control.show()
		get_tree().call_group("Hostage", "invincible")
