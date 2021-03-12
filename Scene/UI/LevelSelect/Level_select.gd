extends Node

func _button_pressed(which):
	$Transition/AnimationPlayer.play("Wipe_In")
	yield($Transition/AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/Levels/Level_" +str(int(which.name))+ ".tscn")

func _ready():
	$Transition/AnimationPlayer.play("Wipe_Out")
	for b in get_node("Control/MarginContainer/VBoxContainer/HBoxContainer/GridContainer").get_children():
		b.connect("pressed", self, "_button_pressed",[b])
		if Save.data.get("Level"+ str(int(b.name) +1)):
			b.disabled = false
		for w in b.get_children():
			w.text = str(int(b.name))

func _on_buttonQuite_button_up():
	$Transition/AnimationPlayer.play("Wipe_In")
	yield($Transition/AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/UI/MainMenu/MainMenu.tscn")

