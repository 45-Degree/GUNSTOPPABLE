tool
extends Node2D

export var radius = Vector2.ONE * 256 # Distance on the x and y axis to orbit around the controller
export var rotation_duration := 4.0 # How many seconds it takes for one platform to complete one rotation

var platforms = [] # References to the platforms that will orbit controller
var orbit_angle_offset = 0 # Angle that first platform will orbit around controller
var prev_child_count = 0 # How many children this controller had, used to check if new children added or removed

func _physics_process(delta):
	if prev_child_count != get_child_count():
		prev_child_count = get_child_count()
		_find_platforms()
#
	orbit_angle_offset += 2 * PI * delta / float(rotation_duration)
	orbit_angle_offset = wrapf(orbit_angle_offset, -PI, PI)
	_update_platforms()

func _update_platforms():
	if platforms.size() != 0:
		var spacing = 2 * PI / float(platforms.size())
		for i in platforms.size():
			var new_position = Vector2()
			new_position.x = (cos(spacing * i + orbit_angle_offset) * radius.x) + radius.x
			new_position.y = sin(spacing * i + orbit_angle_offset) * radius.y
			platforms[i].position = new_position

func _find_platforms():
	platforms = []
	for child in get_children():
		if child.is_in_group("bossBullet"):
			platforms.append(child)
