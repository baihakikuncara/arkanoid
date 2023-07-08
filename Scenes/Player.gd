extends Node2D

const Ball = preload("res://Scenes/Ball.tscn")

var ballCount = 0

func launchBall(var position):
	position.y-=16
	ballCount+=1
	var ball = Ball.instance()
	ball.translate(position)
	add_child(ball)
	

func decreaseBall():
	ballCount-=1
	if ballCount == 0:
		get_node("Board").setup()
