extends KinematicBody2D
onready var animationPlayer = $AnimationPlayer
export(int, "Bottom", "Right", "Top", "Left") var LaserSpawn
onready var state = UNSHOT
onready var LaserBeam = $LaserBeam
onready var ForceMovement =  []
var velocity = Vector2.ZERO

enum{
	UNSHOT,
	SHOTTED
}

func _ready():
		LaserBeam.cast_to = Vector2.ZERO
		LaserBeam.visible = false
		if LaserSpawn == 0:
			$Sprite.frame = 0
		if LaserSpawn == 1:
			$Sprite.frame = 2
		if LaserSpawn == 2:
			$Sprite.frame = 4
		if LaserSpawn == 3:
			$Sprite.frame = 6
		
func _process(delta):
	if ForceMovement.size() != 0:
		velocity = velocity.move_toward(ForceMovement[0] ,5000* delta)
	elif ForceMovement.size() == 0:
		velocity = Vector2.ZERO
	
	if LaserSpawn == 4:
		LaserSpawn = 0
		
	match state:
		UNSHOT:
			LaserBeam.enabled = false
#			LaserBeam.visible = false
			LaserBeam.cast_to = Vector2(0,0)
			$LaserBeam/Area2D/CollisionShape2D.disabled = true
		SHOTTED:
			if LaserSpawn == 0:
				LaserBeam.global_position = $BulletSpawnDown.get_global_position()
				LaserBeam.cast_to = Vector2(0,2000)
			if LaserSpawn == 1:
				LaserBeam.global_position = $BulletSpawnRight.get_global_position()
				LaserBeam.cast_to = Vector2(2000,0)
			if LaserSpawn == 2:
				LaserBeam.global_position = $BulletSpawnUp.get_global_position()
				LaserBeam.cast_to = Vector2(0,-2000)
			if LaserSpawn == 3:
				LaserBeam.global_position = $BulletSpawnLeft.get_global_position()
				LaserBeam.cast_to = Vector2(-2000,0)
			LaserBeam.enabled = true
			LaserBeam.visible = true
			$LaserBeam/Area2D/CollisionShape2D.disabled = false
	velocity = move_and_slide(velocity)
		
func _on_Hurtbox_area_entered(area):
	if area.get_parent().is_in_group("Laser"):
		state = SHOTTED

func _on_Hurtbox_area_exited(area):
	if area.get_parent().is_in_group("Laser"):
		state = UNSHOT

func Rotating():
	if LaserSpawn == 0:
		animationPlayer.play("Rotate_0")
	if LaserSpawn == 1:
		animationPlayer.play("Rotate_1")
	if LaserSpawn == 2:
		animationPlayer.play("Rotate_2")
	if LaserSpawn == 3:
		animationPlayer.play("Rotate_3")
	LaserSpawn += 1
