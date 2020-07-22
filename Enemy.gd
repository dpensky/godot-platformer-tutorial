extends KinematicBody2D

var velocity = Vector2(0,0)

var speed = 50
const gravity = 20
export var direction = -1
export var detects_cliffs = true

func _ready():
	update_direction()
	$FloorChecker.enabled = detects_cliffs
	if detects_cliffs:
		set_modulate(Color(1.2,0.5,1,1))


func _physics_process(_delta):
	if is_on_wall() or not $FloorChecker.is_colliding() and detects_cliffs and is_on_floor():
		direction = direction * -1  # change direction if hit wall
		update_direction()
	velocity.y += gravity
	velocity.x = direction * speed
	velocity = move_and_slide(velocity, Vector2.UP)


func update_direction():
	$AnimatedSprite.flip_h = direction == 1
	# put ray cast in front of enemy to detect cliffs
	$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction


func _on_TopChecker_body_entered(body):
	# print(body.name)
	$AnimatedSprite.play("squashed")
	speed = 0
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$TopChecker.set_collision_layer_bit(4, false)
	$TopChecker.set_collision_mask_bit(0, false)
	$SidesChecker.set_collision_layer_bit(4, false)
	$SidesChecker.set_collision_mask_bit(0, false)
	$Timer.start()
	body.bounce()


func _on_SidesChecker_body_entered(body):
	# print(body.name)
	if body.name == 'Player':
		body.take_damage(position.x)
	else:
		print(body.name)


func _on_Timer_timeout():
	queue_free()
