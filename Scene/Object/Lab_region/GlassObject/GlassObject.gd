extends KinematicBody2D
onready var animationPlayer = $AnimationPlayer
export(int, "Left", "Right", "Top", "Bottom") var LaserSpawn
onready var state = UNSHOT
onready var particle = $Particles2D
onready var timer = $Timer
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
		$Sprite2.texture = load("res://Scene/Object/Lab_region/GlassObject/tile00"+ str(LaserSpawn) + ".png")
		
func _process(delta):
	if ForceMovement.size() != 0:
		velocity = velocity.move_toward(ForceMovement[0] ,5000* delta)
	elif ForceMovement.size() == 0:
		velocity = Vector2.ZERO
	
	match state:
		UNSHOT:
			LaserBeam.enabled = false
			LaserBeam.visible = false
			LaserBeam.cast_to = Vector2(0,0)
			$LaserBeam/Area2D/CollisionShape2D.disabled = true
		SHOTTED:
			if LaserSpawn == 0:
				LaserBeam.global_position = $BulletSpawnLeft.get_global_position()
				LaserBeam.cast_to = Vector2(-2000,0)
				$Sprite2.texture = load("res://Scene/Object/Lab_region/GlassObject/tile000.png")
			if LaserSpawn == 1:
				LaserBeam.global_position = $BulletSpawnRight.get_global_position()
				LaserBeam.cast_to = Vector2(2000,0)
				$Sprite2.texture = load("res://Scene/Object/Lab_region/GlassObject/tile001.png")
			if LaserSpawn == 2:
				LaserBeam.global_position = $BulletSpawnUp.get_global_position()
				LaserBeam.cast_to = Vector2(0,-2000)
				$Sprite2.texture = load("res://Scene/Object/Lab_region/GlassObject/tile002.png")
			if LaserSpawn == 3:
				LaserBeam.global_position = $BulletSpawnDown.get_global_position()
				LaserBeam.cast_to = Vector2(0,2000)
				$Sprite2.texture = load("res://Scene/Object/Lab_region/GlassObject/tile003.png")
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

