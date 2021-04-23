extends Node

onready var levelpic = $Control/MarginContainer/VBoxContainer/HBoxContainer/TextureRect

func _ready():
	Transition.wipeIn()
	for b in get_node("Control/MarginContainer/VBoxContainer/HBoxContainer/GridContainer").get_children():
		b.connect("pressed", self, "_button_pressed",[b])
		b.connect("mouse_entered",self,"_button_entered", [b])
		if Save.data.has("Star" + str(int(b.name))):
			b.texture_normal = load("res://Scene/UI/button/LevelSelectForest/still_"+ str(Save.data.get("Star" + str(int(b.name))))  + ".png")
			b.texture_pressed = load("res://Scene/UI/button/LevelSelectForest/push_" + str(Save.data.get("Star" + str(int(b.name)))) + ".png")
			b.texture_hover = load("res://Scene/UI/button/LevelSelectForest/hover_" + str(Save.data.get("Star" + str(int(b.name)))) + ".png")
		else:
			pass
		if Save.data.get("ForestLevel"+ str(int(b.name))):
			b.disabled = false
		for w in b.get_children():
			w.text = str(int(b.name))

func _physics_process(delta):
	if Input.is_action_just_pressed("k"):
		for b in get_node("Control/MarginContainer/VBoxContainer/HBoxContainer/GridContainer").get_children():
			b.disabled = false

func _button_pressed(which):
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/Levels/ForestLevel/ForestLevel_" +str(int(which.name))+ ".tscn")
	
func _on_buttonQuite_button_up():
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/UI/Regionselect/RegionSelect.tscn")

func _button_entered(which):
	pass
#	if which.disabled == false:
#		levelpic.texture = load("res://Scene/UI/LevelSelect/LevelPic/LevelPic_"+ str(int(which.name)) +".png")
