extends Area2D

signal coin_collected

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_coin_body_entered(_body):
	$AnimationPlayer.play("bounce")
	$AudioStreamPlayer.play()
	set_collision_mask_bit(0, false)
	emit_signal('coin_collected')   # dont colide twice


func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
