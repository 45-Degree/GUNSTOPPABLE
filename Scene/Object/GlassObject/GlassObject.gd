extends StaticBody2D
onready var animationPlayer = $AnimationPlayer
export var health = 10
var invincible = false
var state = UNSHOT
export(int, "Left", "Right", "Top", "Bottom") var LaserSpawn
onready var animatedSprite = $AnimatedSprite
onready var particle = $Particles2D
onready var timer = $Timer
onready var LaserBeam = $LaserBeam

enum{
	SHOTTED,
	UNSHOT
}

func _ready():
	LaserBeam.cast_to = Vector2.ZERO
	LaserBeam.visible = false

func _process(delta):
	match state:
		UNSHOT:
			$LaserBeam/Area2D/CollisionShape2D.disabled = true
			LaserBeam.visible = false
			LaserBeam.cast_to = Vector2.ZERO
		SHOTTED:
			$LaserBeam/Area2D/CollisionShape2D.disabled = false
			LaserBeam.enabled = true
			LaserBeam.visible = true
			if LaserSpawn == 0:
				LaserBeam.global_position = $BulletSpawnLeft.get_global_position()
				LaserBeam.cast_to = Vector2(-500,0)
			if LaserSpawn == 1:
				LaserBeam.global_position = $BulletSpawnRight.get_global_position()
				LaserBeam.cast_to = Vector2(500,0)
			if LaserSpawn == 2:
				LaserBeam.global_position = $BulletSpawnUp.get_global_position()
				LaserBeam.cast_to = Vector2(0,-500)
			if LaserSpawn == 3:
				LaserBeam.global_position = $BulletSpawnDown.get_global_position()
				LaserBeam.cast_to = Vector2(0,500)
			
func _on_Hurtbox_area_entered(area):
	state = SHOTTED
	
func _on_Hurtbox_area_exited(area):
	state = UNSHOT






