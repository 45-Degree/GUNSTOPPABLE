extends Node

func _ready():
	Transition.wipeIn()
	
func  _physics_process(delta):
		if !SoundManager.is_playing("res://Sound/Music/OfficeTheme.ogg"):
			SoundManager.play_bgm("res://Sound/Music/OfficeTheme.ogg")

func _on_Button_button_up():
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/UI/MainMenu/MainMenu.tscn")

