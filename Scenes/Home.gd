extends Node2D

const Ball = preload("res://Scenes/Ball.tscn")

func _ready():
	var rng = RandomNumberGenerator.new()
	for i in 64:
		var ball = Ball.instance()
		ball.position.x = rng.randi_range(30,570)
		ball.position.y = rng.randi_range(30,770)
		ball.direction.x = rng.randf_range(-1, 1)
		ball.direction.y = rng.randf_range(-1, 1)
		add_child(ball)
		


