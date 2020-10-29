extends Camera2D

onready var topLeft = $Limits/topLeft
onready var bottomRight = $Limits/bottomRight
onready var lerpAmount = 0.1
export var limit = true

func _ready():
	if limit == true:
		limit_top = topLeft.position.y
		limit_left = topLeft.position.x
		limit_bottom = bottomRight.position.y
		limit_right = bottomRight.position.x
