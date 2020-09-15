extends Node

onready var control = $Control
onready var message = $Control/Message
onready var level = (int(get_tree().current_scene.name) + 1)
onready var Complete = false

func _ready():
	Singleton.connect("Hostage_Die", self, "_on_Hostage_Die")
	Singleton.connect("Terrorist_Die", self, "_on_Terrorist_Die")

func _process(delta):
	var terrorist = get_tree().get_nodes_in_group("Terrorist").size()
	if terrorist == 0:
		Complete = true
	
func _on_Button_pressed():
	Singleton.Playable = true
	get_tree().reload_current_scene()

func _on_Button2_pressed():
	get_tree().quit()

func _on_Hostage_Die():
	Singleton.Playable = false
	message.set_text("You kill a hostage!")
	control.show()

func _on_Detector_body_entered(body):
	if Complete == true:
		message.set_text("You kill all the terrorist!")
		Singleton.Playable = false
		control.show()
		get_tree().call_group("Hostage", "invincible")
	else:
		message.set_text("The terrorist kill the hostage")
		Singleton.Playable = false
		control.show()
		get_tree().call_group("Hostage", "explode")
#	get_tree().change_scene("res://Scene/Levels/Level_" + str(level +1) +".tscn")
	
