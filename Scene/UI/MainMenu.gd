extends Node

func _ready():
	$AnimationPlayer.play("Wipe_Out")
	randomize()

func _on_Button_button_up():
	$AnimationPlayer.play("Wipe_In")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/UI/Level_select.tscn")

func _on_Button4_button_up():
	get_tree().quit()


func _on_Button3_button_up():
	get_tree().change_scene("res://Scene/UI/Option.tscn")
