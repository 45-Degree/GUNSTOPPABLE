extends Node

onready var control = $Control
onready var message = $Control/Message

func _ready():
	Singleton.connect("Hostage_Die", self, "_on_Hostage_Die")
	Singleton.connect("Terrorist_Die", self, "_on_Terrorist_Die")

func _process(delta):
	var te = get_tree().has_group("Terrorist")
	if te == true:
		message.set_text("You kill all the terrorist!")
		Singleton.Playable = false
		control.show()
		get_tree().call_group("Hostage", "invincible")
	
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
	print("FS")
	get_tree().change_scene("res://Scene/Levels/Level_" + str(int(get_tree().current_scene.name) + 1)+ ".tscn")
