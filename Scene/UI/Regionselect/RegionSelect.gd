extends Control

func _ready():
	Transition.wipeIn()
	if Save.data.has("Region2") and Save.data["Region2"]:
		$MarginContainer/VBoxContainer/LabRegion.disabled = false
		

func _on_Button_pressed():
	get_tree().change_scene("res://Scene/UI/LevelSelect/Level_select.tscn")

func _on_Button2_pressed():
	get_tree().change_scene("res://Scene/UI/LabLevelSelect/LabLevel_select.tscn")

func _on_Button3_pressed():
	get_tree().change_scene("res://Scene/UI/MainMenu/MainMenu.tscn")

func _on_ForestRegion_pressed():
	pass # Replace with function body.
