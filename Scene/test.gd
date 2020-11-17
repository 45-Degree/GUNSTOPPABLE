extends Node2D

export(String, "Left", "Right", "Top", "Bottom") var spawnFrom
export(int, "Left", "Right", "Top", "Bottom") var spawnHere

onready var finalPosition = $Position2D
onready var player = $Player

func _ready():
	pass

func _process(delta):
	_spawn()

func _spawn():
	if spawnHere == 0:
		player.position = finalPosition.get_global_position() - Vector2(100,0)
	if spawnHere == 1:
		player.position = finalPosition.get_global_position() - Vector2(100,0)
	if spawnHere == 2:
		player.position = finalPosition.get_global_position() - Vector2(100,0)
	if spawnHere == 3:
		player.position = finalPosition.get_global_position() - Vector2(100,0)
