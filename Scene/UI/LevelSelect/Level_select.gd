extends Node

onready var levelpic = $Control/MarginContainer/VBoxContainer/HBoxContainer/TextureRect

func _ready():
	$Transition/AnimationPlayer.play("Wipe_Out")
	for b in get_node("Control/MarginContainer/VBoxContainer/HBoxContainer/GridContainer").get_children():
		b.connect("pressed", self, "_button_pressed",[b])
		b.connect("mouse_entered",self,"_button_entered", [b])
		if Save.data.has("Star" + str(int(b.name))):
			b.texture_normal = load("res://Scene/UI/button/LevelSelectSprite/LevelNormal"+ str(Save.data.get("Star" + str(int(b.name))))  + ".png")
			b.texture_pressed = load("res://Scene/UI/button/LevelSelectSprite/LevelPressed" + str(Save.data.get("Star" + str(int(b.name)))) + ".png")
			b.texture_hover = load("res://Scene/UI/button/LevelSelectSprite/LevelHover" + str(Save.data.get("Star" + str(int(b.name)))) + ".png")
		else:
			pass
		if Save.data.get("Level"+ str(int(b.name))):
			b.disabled = false
		for w in b.get_children():
			w.text = str(int(b.name))

func _physics_process(delta):
	if Input.is_action_just_pressed("k"):
		for b in get_node("Control/MarginContainer/VBoxContainer/HBoxContainer/GridContainer").get_children():
			b.disabled = false

func _button_pressed(which):
	$Transition/AnimationPlayer.play("Wipe_In")
	yield($Transition/AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/Levels/Level_" +str(int(which.name))+ ".tscn")

func _on_buttonQuite_button_up():
	$Transition/AnimationPlayer.play("Wipe_In")
	yield($Transition/AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://Scene/UI/MainMenu/MainMenu.tscn")

func _button_entered(which):
	if which.disabled == false:
		levelpic.texture = load("res://Scene/UI/LevelSelect/LevelPic/LevelPic_"+ str(int(which.name)) +".png")
