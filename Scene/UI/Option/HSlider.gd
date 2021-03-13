extends HSlider

export var audio_bus_name := "BGM"


onready var _bus := AudioServer.get_bus_index(audio_bus_name)

func _ready() -> void:
	AudioServer.set_bus_volume_db(_bus, -6)
	value = db2linear(AudioServer.get_bus_volume_db(_bus))

func _on_HSlider_mouse_exited():
	release_focus()

func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(_bus, linear2db(value))

func _on_HSlider2_value_changed(value):
	AudioServer.set_bus_volume_db(_bus, linear2db(value))
	SoundManager.play_se("res://Scene/Character/Player/Gun/GunSound/GunsoundNew.wav")
