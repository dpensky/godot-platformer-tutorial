extends KinematicBody2D

var coins = 0
var velocity = Vector2(0,0)

const SPEED = 180
const GRAVITY = 35
const JUMPFORCE = -1100

func _physics_process(_delta):
	# $AnimatedSprite.animation = "idle"
	
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
	
	if not is_on_floor():
		$AnimatedSprite.play("air")
		
	velocity.y += GRAVITY

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE

	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.2)


func _on_Fall_Zone_body_entered(body):
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer, 'finished')
	get_tree().change_scene("res://Level1.tscn")

