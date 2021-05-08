extends Node

onready var control = $CanvasLayer/Control
onready var pause =$CanvasLayer/Control2
onready var option = $CanvasLayer/Control3
onready var message = $CanvasLayer/Control/MarginContainer/CenterContainer/VBoxContainer/Message
onready var button = $CanvasLayer/Control/MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/NextLevelButton
onready var star1 = $CanvasLayer/Control/MarginContainer/CenterContainer/VBoxContainer/HBoxContainer2/TextureRect
onready var star2 = $CanvasLayer/Control/MarginContainer/CenterContainer/VBoxContainer/HBoxContainer2/TextureRect2
onready var star3 = $CanvasLayer/Control/MarginContainer/CenterContainer/VBoxContainer/HBoxContainer2/TextureRect3
onready var starAll = $CanvasLayer/Control/MarginContainer/CenterContainer/VBoxContainer/HBoxContainer2
onready var starCrack = $CanvasLayer/Control/MarginContainer/CenterContainer/VBoxContainer/HBoxContainer3
onready var camera =$Camera2D
onready var player = $YSort/Player
onready var animationPlayer = $AnimationPlayer
onready var finalPosition = $SpawnPosition
var soundplay = false
export(int, "Left", "Right", "Top", "Bottom") var spawnHere
onready var Complete = false
export var Hostage_dead = false
onready var lerpAmount = 0.001
signal level_Completed
signal cheat
signal mouse_click
var smooth_zoom = 1
var target_zoom = 0.5
const ZOOM_SPEED = 3
export var Star_Count = 0
var terrorist = 1

func _input(event):
		if(event is InputEventMouseButton and event.is_pressed() and !event.is_echo()):
			emit_signal("mouse_click")

func _ready():
	terrorist = get_tree().get_nodes_in_group("Terrorist").size()
	Transition.wipeIn()
	Singleton.Playable = false
	$CanvasLayer/Control4.show()
	connect("level_Completed", self, "_on_level_Completed")
	connect("cheat", self, "_on_level_Completed")
	$CanvasLayer/LevelLabel.text = "Level-" + str(int(get_tree().current_scene.name))
	animationPlayer.play("Wipe_Out")
	yield(animationPlayer,"animation_finished")
	_spawn()
	yield(self,"mouse_click")
	Singleton.Playable = true
	$CanvasLayer/Control4.hide()

func _process(delta):
	$CanvasLayer/TextureRect/Label.text = "X " + str(terrorist)
	if terrorist == 0 and Hostage_dead == false:
		get_tree().call_group("Detector", "detector_ON")
		emit_signal("level_Completed")
		Complete = true
	if Input.is_action_just_pressed("Pause") and Singleton.Playable == true:
		get_tree().paused = true
		pause.show()
	if Input.is_action_just_pressed("R") and Singleton.Playable == true:
		Transition.wipeOut()
		yield(get_tree().create_timer(0.5),"timeout")
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("k") and Singleton.Playable == true:
		emit_signal("cheat")
		Complete = true
	if  Hostage_dead == true:
		camera.limit = false
		camera.limit_bottom = 1000000000
		camera.limit_left = -100000000000
		camera.limit_right = 100000000000
		camera.limit_top = -10000000000
		$YSort/Player/RemoteTransform2D.remote_path = "Player"
		smooth_zoom = lerp(smooth_zoom, target_zoom, ZOOM_SPEED * delta)
		if smooth_zoom != target_zoom:
			camera.set_zoom(Vector2(smooth_zoom, smooth_zoom))
			camera.position = lerp(player.global_position, Singleton.hostagePosition, 1)
		
func _on_Hostage_Die():
	starCrack.show()
	starAll.hide()
	SoundManager.play_bgm("res://Sound/Music/Mission_Fail.wav")
	Singleton.Playable = false
	Complete = false
	Hostage_dead = true
	$CanvasLayer/Control/MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/NextLevelButton.hide()
	message.set_text("You kill a hostage!")
	control.show()
	
func _on_Terrorist_Die():
	terrorist -= 1
	
func  _on_Star_Pick():
	Star_Count += 1

func _on_Passable():
	if Complete == true:
		Save.data["ForestLevel"+ str(int(get_tree().current_scene.name)+1)] = true
		if !Save.data.has("ForestStar" + str(int(get_tree().current_scene.name))):
			Save.data["ForestStar"+ str(int(get_tree().current_scene.name))] = Star_Count
		elif Save.data["ForestStar" + str(int(get_tree().current_scene.name))] <= Star_Count:
			Save.data["ForestStar" + str(int(get_tree().current_scene.name))] = Star_Count
		else:
			pass
		Save._on_Save()
		SoundManager.play_bgm("res://Sound/Music/Mission_Success.wav")
		if Star_Count == 0:
			pass
		if Star_Count == 1:
			star1.texture = load("res://Scene/UI/Star/tile005.png")
		if Star_Count == 2:
			star1.texture = load("res://Scene/UI/Star/tile005.png")
			star2.texture = load("res://Scene/UI/Star/tile005.png")
		if Star_Count == 3:
			star1.texture = load("res://Scene/UI/Star/tile005.png")
			star2.texture = load("res://Scene/UI/Star/tile005.png")
			star3.texture = load("res://Scene/UI/Star/tile005.png")
		message.set_text("MISSION COMPLETED!")
		Singleton.Playable = false
		control.show()
		get_tree().call_group("Hostage", "invincible")
		
func _spawn():
	if spawnHere == 0:
		player.position = finalPosition.get_global_position() - Vector2(100,0)
	if spawnHere == 1:
		player.position = finalPosition.get_global_position() - Vector2(-100,0)
	if spawnHere == 2:
		player.position = finalPosition.get_global_position() - Vector2(0,100)
	if spawnHere == 3:
		player.position = finalPosition.get_global_position() - Vector2(0,-100)
	$Tween.interpolate_property(player, "position", player.position, finalPosition.position ,0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")

func _on_level_Completed():
	if soundplay == false:
		$CanvasLayer/Control/MarginContainer/CenterContainer/VBoxContainer/HBoxContainer3.hide()
		SoundManager.play_se("res://Sound/SFX/Object/ExitUnlock.wav")
		soundplay = true

func _on_NextLevelButton_pressed():
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	if get_tree().current_scene.name == "ForestLevel_20":
		get_tree().change_scene("res://Scene/UI/ForestLevelSelect/ForestLevel_select.tscn")
	else:
		get_tree().change_scene("res://Scene/Levels/ForestLevel/ForestLevel_" +str(int(get_tree().current_scene.name) +1)+ ".tscn")

func _on_RetryButton_pressed():
	Transition.wipeOut()
	control.hide()
	yield(get_tree().create_timer(0.5),"timeout")
	Singleton.Playable = true
	get_tree().reload_current_scene()

func _on_LevelButton_pressed():
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/UI/ForestLevelSelect/ForestLevel_select.tscn")

func _on_ResumeButton_pressed():
	get_tree().paused = false
	pause.hide()

func _on_OptionButton_pressed():
	pause.hide()
	option.show()

func _on_ExitButton_pressed():
	get_tree().paused = false
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/UI/ForestLevelSelect/ForestLevel_select.tscn")

func _on_BackButton_pressed():
	option.hide()
	pause.show()
