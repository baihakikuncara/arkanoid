extends StaticBody2D

export var durability = 1
export var score = 10


func hit():
	durability -= 1
	if durability == 0:
		queue_free()
		var player = get_parent().get_parent().get_node("Player")
		if player.has_method("incScore"):
			player.incScore(score)
