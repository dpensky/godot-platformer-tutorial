extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_coin_body_entered(body):
	$CollisionShape2D.disabled = true  # dont colide twice
	$AnimationPlayer.play("bounce")
	body.add_coin()


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
