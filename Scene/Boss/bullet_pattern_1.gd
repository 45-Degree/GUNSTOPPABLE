extends Node2D
onready var bulletEnd = $Position2D
onready var boss_bullet = $Bullet
onready var speed = 3
onready var spawnable = true
export var spawnTime = 0.1
var Bullet = preload("res://Scene/Boss01_Bulllet.tscn")
