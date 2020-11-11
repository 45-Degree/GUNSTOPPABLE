extends Node


func _button_pressed(which):
	print("Button was pressed: ", which.get_name())
	get_tree().change_scene("res://Scene/Levels/Level_" +str(int(which.name))+ ".tscn")

func _ready():
	for b in get_node("Control/MarginContainer/VBoxContainer/HBoxContainer").get_children():
		b.connect("pressed", self, "_button_pressed",[b])

func _on_buttonQuite_button_up():
	get_tree().change_scene("res://Scene/UI/MainMenu.tscn")
