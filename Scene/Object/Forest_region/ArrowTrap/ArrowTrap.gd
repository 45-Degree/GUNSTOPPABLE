extends StaticBody2D

export (PackedScene) var Arrow
var arrowCount = 0

func _ready():
	pass

func Trigger():
	while arrowCount < 3:
		var Arrow_Instace = Arrow.instance()
		Arrow_Instace.position = self.global_position
		Arrow_Instace.direction = Vector2.DOWN
		Arrow_Instace.rotation = Arrow_Instace.direction.angle()
		get_tree().current_scene.add_child(Arrow_Instace)
		yield(get_tree().create_timer(0.5),"timeout")
		arrowCount += 1
	
