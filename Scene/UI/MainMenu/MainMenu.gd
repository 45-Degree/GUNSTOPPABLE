extends Node

func _ready():
	Transition.wipeIn()
	randomize()

func _on_Button_button_up():
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/UI/Regionselect/RegionSelect.tscn")

func _on_Button4_button_up():
	get_tree().quit()

func _on_Button3_button_up():
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/UI/Option/Option.tscn")

func _on_Button2_pressed():
	get_tree().quit()


func _on_Button_pressed():
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/UI/Credit/Credit.tscn")
