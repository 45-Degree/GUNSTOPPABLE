extends CanvasLayer
onready var control = $Control
onready var pause = $Control2
onready var option = $Control3
onready var message = $Control/MarginContainer/CenterContainer/VBoxContainer/Message
onready var pauseStatus = false

func _physics_process(delta):
	if Input.is_action_just_pressed("Pause") and Singleton.Playable == true:
		pauseStatus = !pauseStatus
		get_tree().paused = pauseStatus
		pause.visible = pauseStatus


