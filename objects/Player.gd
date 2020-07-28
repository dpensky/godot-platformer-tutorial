extends KinematicBody2D

var lifes = 3
var coins = 0
var velocity = Vector2(0,0)

const SPEED = 180
const GRAVITY = 35
const JUMPFORCE = -1100

export (NodePath) var joystickLeftPath
onready var joystickLeft : Joystick = get_node(joystickLeftPath)

func _physics_process(_delta):
	# $AnimatedSprite.animation = "idle"
	
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
	elif joystickLeft and joystickLeft.is_working:
		velocity.x = joystickLeft.output.x * SPEED
	else:
		$AnimatedSprite.play("idle")
	
	if velocity.x > 0:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
	elif velocity.x < 0:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
	
	if not is_on_floor():
		$AnimatedSprite.play("air")

	velocity.y += GRAVITY

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE

	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.2)


func _on_Fall_Zone_body_entered(body):
	# print_debug(body.name)
	if body.name == 'Player':
		die()
	else:
		body.queue_free()


func die():
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer, 'finished')
	get_tree().change_scene("res://Level1.tscn")


func take_damage(var enemy_x_position):
	var PUSHFORCE = 800
	lifes -= 1
	set_modulate(Color(1,0.3,0.3,0.3))
	velocity.y = JUMPFORCE * 0.5
	if enemy_x_position > position.x:
		velocity.x = -PUSHFORCE
	elif enemy_x_position < position.x:
		velocity.x = PUSHFORCE
	else:
		print("how?")
	Input.action_release("left")
	Input.action_release("right")
	$Timer.start()


func bounce():
	velocity.y = JUMPFORCE * 0.7


func _on_Timer_timeout():
	# print(lifes)
	if lifes == 0:
		die()
	else:
		set_modulate(Color(1,1,1,1))
