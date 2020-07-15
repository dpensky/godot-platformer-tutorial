extends KinematicBody2D

var velocity = Vector2(0,0)

export var direction = -1
export var detects_cliffs = true

func _ready():
	update_direction()
	$FloorChecker.enabled = detects_cliffs


func _physics_process(_delta):
	if is_on_wall() or not $FloorChecker.is_colliding() and detects_cliffs and is_on_floor():
		direction = direction * -1  # change direction if hit wall
		update_direction()
	velocity.y += 20
	velocity.x = direction * 50
	velocity = move_and_slide(velocity, Vector2.UP)


func update_direction():
	$AnimatedSprite.flip_h = direction == 1
	# put ray cast in front of enemy to detect cliffs
	$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
