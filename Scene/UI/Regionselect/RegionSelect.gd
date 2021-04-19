extends Control

func _ready():
	Transition.wipeIn()
	if Save.data.has("Region2") and Save.data["Region2"]:
		$MarginContainer/VBoxContainer/LabRegion.disabled = false
	if Save.data.has("Region3") and Save.data["Region3"]:
		$MarginContainer/VBoxContainer/LabRegion.disabled = false

func _physics_process(delta):
	if Input.is_action_just_pressed("k"):
		$LabRegion.disabled = false
		$ForestRegion.disabled = false

func _on_Button_pressed():
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/UI/LevelSelect/Level_select.tscn")

func _on_Button2_pressed():
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/UI/LabLevelSelect/LabLevel_select.tscn")

func _on_Button3_pressed():
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/UI/MainMenu/MainMenu.tscn")

func _on_ForestRegion_pressed():
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/UI/ForestLevelSelect/ForestLevel_select.tscn")
