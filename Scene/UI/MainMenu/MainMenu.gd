extends Node

func _ready():
	$Transition/AnimationPlayer.play("Wipe_Out")
	randomize()

func _on_Button_button_up():
	$Transition/AnimationPlayer.play("Wipe_In")
	yield($Transition/AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/UI/LevelSelect/Level_select.tscn")

func _on_Button4_button_up():
	get_tree().quit()

func _on_Button3_button_up():
	get_tree().change_scene("res://Scene/UI/Option/Option.tscn")

func _on_Button2_pressed():
	get_tree().quit()


func _on_Button_pressed():
	get_tree().change_scene("res://Scene/UI/Credit/Credit.tscn")
