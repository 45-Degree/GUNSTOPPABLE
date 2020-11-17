extends Node2D

export(String, "Left", "Right", "Top", "Bottom") var spawnFrom
export(int, "Left", "Right", "Top", "Bottom") var spawnHere

onready var finalPosition = $Position2D
onready var player = $Player

func _ready():
	pass


