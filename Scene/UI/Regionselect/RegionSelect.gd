extends Control

func _ready():
	SoundManager.stop("res://Sound/Music/JungleTheme.ogg") 
	SoundManager.stop("res://Sound/Music/LabTheme.ogg") 
	Transition.wipeIn()
	if Save.data.has("Region2"):
		$LabRegion.disabled = false
	if Save.data.has("Region3"):
		$ForestRegion.disabled = false

func _physics_process(delta):
	if !SoundManager.is_playing("res://Sound/Music/OfficeTheme.ogg"):
		SoundManager.play_bgm("res://Sound/Music/OfficeTheme.ogg") 
	if Input.is_action_just_pressed("k"):
		$LabRegion.disabled = false
		$ForestRegion.disabled = false

func _on_Button_pressed():
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/UI/LevelSelect/Level_select.tscn")

func _on_Button2_pressed():
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/UI/LabLevelSelect/LabLevel_select.tscn")

func _on_Button3_pressed():
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/UI/MainMenu/MainMenu.tscn")

func _on_ForestRegion_pressed():
	Transition.wipeOut()
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().change_scene("res://Scene/UI/ForestLevelSelect/ForestLevel_select.tscn")


func _on_ForestRegion_mouse_entered():
	if !$ForestRegion.disabled:
		$TextureRect.texture = load("res://Scene/UI/Regionselect/RegionBackground/Forest_Preview.png")
	
func _on_LabRegion_mouse_entered():
	if !$LabRegion.disabled:
		$TextureRect.texture = load("res://Scene/UI/Regionselect/RegionBackground/image.png")

func _on_OfficeRegion_mouse_entered():
	$TextureRect.texture = load("res://Scene/UI/Regionselect/RegionBackground/Office_Sample_Scene.png")
