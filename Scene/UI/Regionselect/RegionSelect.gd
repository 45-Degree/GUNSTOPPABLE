extends Control

func _ready():
	Transition.wipeIn()

func _on_Button_pressed():
	get_tree().change_scene("res://Scene/UI/LevelSelect/Level_select.tscn")

func _on_Button2_pressed():
	get_tree().change_scene("res://Scene/UI/LabLevelSelect/LabLevel_select.tscn")

func _on_Button3_pressed():
	get_tree().change_scene("res://Scene/UI/MainMenu/MainMenu.tscn")
