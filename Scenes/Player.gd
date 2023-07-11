extends Node2D

const Ball = preload("res://Scenes/Ball.tscn")

export var lives = 3
var ballCount = 0
var score = 0
var pause = false


func _ready():
	setLives()
	incScore()


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


func setStage(var stage = 0):
	get_node("HUD/Stage").text = "Stage: %d" % stage
	setLives()
	resume()


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


func pause():
	pause = true
	var children = get_children()
	for child in children:
		if child.has_method("pause"):
			child.pause()


func resume():
	pause = false
	var children = get_children()
	for child in children:
		if child.has_method("resume"):
			child.resume()


func clearBalls():
	var children = get_children()
	for child in children:
		if child.has_method("delete_node"):
			child.delete_node(false)
	get_node("Board").setup()
