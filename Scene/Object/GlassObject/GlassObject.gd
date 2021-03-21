extends StaticBody2D
onready var animationPlayer = $AnimationPlayer
export var health = 10
var invincible = false
var state = UNSHOT
export var Laser = false
export var Emit = false
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
			animatedSprite.hide()
			animationPlayer.play("Idle")
			particle.emitting = false
		SHOTTED:
			health =- 4
			animatedSprite.show()
			animationPlayer.play("Blink")
			particle.emitting = true
			yield(get_tree().create_timer(1.5),"timeout")
	if Laser == false:
		LaserBeam.enabled = false
		LaserBeam.visible = false
		
func _on_Hurtbox_area_entered(area):
	if Laser == true:
		LaserBeam.enabled = true
		LaserBeam.visible = true
		if LaserSpawn == 0:
			LaserBeam.global_position = $BulletSpawnLeft.get_global_position()
			LaserBeam.cast_to = Vector2(-2000,0)
		if LaserSpawn == 1:
			LaserBeam.global_position = $BulletSpawnRight.get_global_position()
			LaserBeam.cast_to = Vector2(2000,0)
		if LaserSpawn == 2:
			LaserBeam.global_position = $BulletSpawnUp.get_global_position()
			LaserBeam.cast_to = Vector2(0,-2000)
		if LaserSpawn == 3:
			LaserBeam.global_position = $BulletSpawnDown.get_global_position()
			LaserBeam.cast_to = Vector2(0,2000)
#
func _on_Hurtbox_area_exited(area):
	if Laser == true:
		LaserBeam.visible = false
		LaserBeam.cast_to = Vector2.ZERO

func _on_Timer_timeout():
	animatedSprite.hide()
	animationPlayer.play("Idle")
	particle.emitting = false






