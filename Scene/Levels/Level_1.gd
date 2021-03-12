extends Node

onready var control = $CanvasLayer/Control
onready var pause =$CanvasLayer/Control2
onready var option = $CanvasLayer/Control3
onready var message = $CanvasLayer/Control/MarginContainer/CenterContainer/VBoxContainer/VBoxContainer2/Message
onready var button = $CanvasLayer/Control/MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/NextLevelButton
onready var camera =$Camera2D
onready var player = $YSort/Player
onready var animationPlayer = $AnimationPlayer
onready var finalPosition = $SpawnPosition
onready var starMessage =$CanvasLayer/Control/MarginContainer/CenterContainer/VBoxContainer/VBoxContainer2/StarMessage
var soundplay = false
export(int, "Left", "Right", "Top", "Bottom") var spawnHere
onready var Complete = false
export var Hostage_dead = false
onready var lerpAmount = 0.001
signal level_Completed
signal mouse_click
var smooth_zoom = 1
var target_zoom = 0.5
const ZOOM_SPEED = 3
var Star_Count = 0

func _input(event):
		if(event is InputEventMouseButton and event.is_pressed() and !event.is_echo()):
			emit_signal("mouse_click")

func _ready():
	Singleton.Playable = false
	$CanvasLayer/Control4.show()
	connect("level_Completed", self, "_on_level_Completed")
	$CanvasLayer/LevelLabel.text = "Level-" + str(int(get_tree().current_scene.name))
	animationPlayer.play("Wipe_Out")
	yield(animationPlayer,"animation_finished")
	_spawn()
	yield(self,"mouse_click")
	Singleton.Playable = true
	$CanvasLayer/Control4.hide()
	player.BULLET = true


func _process(delta):
	var terrorist = get_tree().get_nodes_in_group("Terrorist").size()
	if terrorist == 0 and Hostage_dead == false:
		get_tree().call_group("Detector", "detector_ON")
		emit_signal("level_Completed")
		Complete = true
	if Input.is_action_just_pressed("Pause") and Singleton.Playable == true:
		get_tree().paused = true
		pause.show()
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

func _on_Button_pressed():
		animationPlayer.play("Wipe_In")
		yield(animationPlayer, "animation_finished")
		get_tree().change_scene("res://Scene/Levels/Level_" +str(int(get_tree().current_scene.name) +1)+ ".tscn")

func _on_Button2_pressed():
	Singleton.Playable = true
	animationPlayer.play("Wipe_In")
	control.hide()
	yield(animationPlayer, "animation_finished")
	get_tree().reload_current_scene()

func _on_Hostage_Die():
	Singleton.Playable = false
	Complete = false
	Hostage_dead = true
	starMessage.text = "You collect " + str(Star_Count) + " star"
	$CanvasLayer/Control/MarginContainer/CenterContainer/VBoxContainer/HBoxContainer/NextLevelButton.hide()
	message.set_text("You kill a hostage!")
	control.show()

func  _on_Star_Pick():
	Star_Count += 1

func _on_Passable():
	if Complete == true:
		Save.data["Level"+ str(int(get_tree().current_scene.name))] = true
		if !Save.data.has("Star" + str(int(get_tree().current_scene.name))):
			Save.data["Star"+ str(int(get_tree().current_scene.name))] = Star_Count
		elif Save.data["Star" + str(int(get_tree().current_scene.name))] <= Star_Count:
			Save.data["Star" + str(int(get_tree().current_scene.name))] = Star_Count
		else:
			pass
		Save._on_Save()
		message.set_text("MISSION COMPLETED!")
		starMessage.text = "You collect " + str(Star_Count) + " star"
		Singleton.Playable = false
		control.show()
		get_tree().call_group("Hostage", "invincible")

func _on_Button_button_up():
	get_tree().paused = false
	pause.hide()

func _on_Button3_button_up():
	get_tree().change_scene("res://Scene/UI/MainMenu/MainMenu.tscn")
	get_tree().paused = false

func _on_Button4_pressed():
	option.hide()
	pause.show()

func _on_Button2_button_up():
	pause.hide()
	option.show()

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
		SoundManager.play_se("res://Sound/SFX/Object/ExitUnlock.wav")
		soundplay = true


func _on_Button3_pressed():
		animationPlayer.play("Wipe_In")
		yield(animationPlayer, "animation_finished")
		get_tree().change_scene("res://Scene/UI/LevelSelect/Level_select.tscn")
