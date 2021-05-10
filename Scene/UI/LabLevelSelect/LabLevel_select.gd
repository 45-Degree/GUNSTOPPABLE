extends Node

onready var levelpic = $Control/TextureRect

func _ready():
	SoundManager.stop("res://Sound/Music/OfficeTheme.ogg")

	Transition.wipeIn()
	for b in get_node("Control/MarginContainer/VBoxContainer/HBoxContainer/GridContainer").get_children():
		b.connect("pressed", self, "_button_pressed",[b])
		b.connect("mouse_entered",self,"_button_entered", [b])
		if Save.data.has("LabStar" + str(int(b.name))):
			b.texture_normal = load("res://Scene/UI/button/LevelSelectLab/still"+ str(Save.data.get("LabStar" + str(int(b.name))))  + ".png")
			b.texture_pressed = load("res://Scene/UI/button/LevelSelectLab/push" + str(Save.data.get("LabStar" + str(int(b.name)))) + ".png")
			b.texture_hover = load("res://Scene/UI/button/LevelSelectLab/hover" + str(Save.data.get("LabStar" + str(int(b.name)))) + ".png")
		else:
			pass
		if Save.data.get("LabLevel"+ str(int(b.name))):
			b.disabled = false
		for w in b.get_children():
			w.text = str(int(b.name))

func _physics_process(delta):
	if Input.is_action_just_pressed("k"):
		for b in get_node("Control/MarginContainer/VBoxContainer/HBoxContainer/GridContainer").get_children():
			b.disabled = false
	if !SoundManager.is_playing("res://Sound/Music/LabTheme.ogg"):
		SoundManager.play_bgm("res://Sound/Music/LabTheme.ogg") 
func _button_pressed(which):
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/Levels/LabLevel/LabLevel_" +str(int(which.name))+ ".tscn")
	
func _on_buttonQuite_button_up():
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/UI/Regionselect/RegionSelect.tscn")

func _button_entered(which):
	if which.disabled == false:
		levelpic.texture = load("res://Scene/UI/LabLevelSelect/LevelPic/2-"+ str(int(which.name)) +".png")
