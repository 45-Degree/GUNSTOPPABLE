extends Node

func _ready():
	$AnimationPlayer.play("Wipe_Out")

func _on_Button_button_up():
	get_tree().change_scene("res://Scene/Levels/Level_1.tscn")

func _on_Button4_button_up():
	get_tree().quit()

func _on_Button2_button_up():
	get_tree().change_scene("res://Scene/UI/Level_select.tscn")

func _on_Button3_button_up():
	get_tree().change_scene("res://Scene/UI/Option.tscn")
