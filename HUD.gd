extends CanvasLayer

var coins: int = 0

func _ready():
	$Coins.text = str(coins)


func _on_coin_collected():
	coins += 1
	_ready()
	if coins == 3:
		$Label.show()
		$AudioStreamPlayer.play()
		yield($AudioStreamPlayer, 'finished')
		get_tree().change_scene("res://Level1.tscn")
