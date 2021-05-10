extends StaticBody2D

export(String, "UP", "DOWN", "LEFT", "RIGHT") var DIRECTION
export (PackedScene) var Arrow
var arrowDirection = Vector2.ZERO
var arrowCount = 0
var trigger = false

func _ready():
	$AnimatedSprite.animation = "Idle"
	if DIRECTION == "UP":
		arrowDirection = Vector2.UP
		$AnimatedSprite.frame = 3
	if DIRECTION == "DOWN":
		arrowDirection = Vector2.DOWN
		$AnimatedSprite.frame = 0
	if DIRECTION == "LEFT":
		arrowDirection = Vector2.LEFT
		$AnimatedSprite.frame = 1
	if DIRECTION == "RIGHT":
		arrowDirection = Vector2.RIGHT
		$AnimatedSprite.frame = 2

func Trigger():
	if DIRECTION == "DOWN":
		$AnimatedSprite.play("Firing")
	if !trigger:
		var Arrow_Instace = Arrow.instance()
		Arrow_Instace.position = self.global_position
		Arrow_Instace.direction = arrowDirection
		Arrow_Instace.rotation = Arrow_Instace.direction.angle()
		get_tree().current_scene.add_child(Arrow_Instace)
		$AnimatedSprite.stop()
		trigger = true
	if DIRECTION == "DOWN":
		$AnimatedSprite.animation = "Idle"
		$AnimatedSprite.frame = 0
