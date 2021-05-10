extends Node


func _ready():
	Transition.wipeIn()

func _on_Button_pressed():
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/UI/MainMenu/MainMenu.tscn")

func _physics_process(delta):
	if !SoundManager.is_playing("res://Sound/Music/OfficeTheme.ogg"):
		SoundManager.play_bgm("res://Sound/Music/OfficeTheme.ogg")
