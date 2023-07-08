extends Node2D

const Ball = preload("res://Scenes/Ball.tscn")

export var lives = 3
var ballCount = 0
var score = 0
var stage = 1


func _ready():
	setLives()
	incScore()
	setStage()

func launchBall(var position):
	position.y-=16
	ballCount+=1
	var ball = Ball.instance()
	ball.translate(position)
	add_child(ball)
	
	
func setLives():
	get_node("HUD/Lives").text = "x " + str(lives)
	

func incScore(var val=0):
	score += val
	get_node("HUD/Score").text = str(score)


func setStage():
	get_node("HUD/Stage").text = "Stage: " + str(stage)


func decreaseBall():
	ballCount-=1
	if ballCount == 0:
		get_node("Board").setup()
		lives-=1
		setLives()
		if lives == 0:
			get_node("Board").setGameOver()


func increaseBall():
	lives+=1
	setLives()
