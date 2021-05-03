extends StaticBody2D

export(String, "UP", "DOWN", "LEFT", "RIGHT") var DIRECTION
export (PackedScene) var Arrow
var arrowDirection = Vector2.ZERO
var arrowCount = 0

func _ready():
	if DIRECTION == "UP":
		arrowDirection = Vector2.UP
		$AnimatedSprite.animation = "Idle"
		$AnimatedSprite.frame = 3
	if DIRECTION == "DOWN":
		arrowDirection = Vector2.DOWN
		$AnimatedSprite.animation = "Idle"
		$AnimatedSprite.frame = 0
	if DIRECTION == "LEFT":
		arrowDirection = Vector2.LEFT
		$AnimatedSprite.animation = "Idle"
		$AnimatedSprite.frame = 1
	if DIRECTION == "RIGHT":
		arrowDirection = Vector2.RIGHT
		$AnimatedSprite.animation = "Idle"
		$AnimatedSprite.frame = 2

func Trigger():
	if DIRECTION == "DOWN":
		$AnimatedSprite.play("Firing")
	while arrowCount < 3:
		var Arrow_Instace = Arrow.instance()
		Arrow_Instace.position = self.global_position
		Arrow_Instace.direction = arrowDirection
		Arrow_Instace.rotation = Arrow_Instace.direction.angle()
		get_tree().current_scene.add_child(Arrow_Instace)
		yield(get_tree().create_timer(0.5),"timeout")
		arrowCount += 1
	$AnimatedSprite.stop()
	if DIRECTION == "DOWN":
		$AnimatedSprite.animation = "Idle"
		$AnimatedSprite.frame = 0
