extends Node2D

const Ball = preload("res://Scenes/Ball.tscn")

export var lives = 3
var ball_count = 0
var score = 0
var pause = false


func _ready():
	set_lives()
	increase_score()


func launch_ball(var position):
	position.y-=16
	ball_count+=1
	var ball = Ball.instance()
	ball.translate(position)
	add_child(ball)
	
	
func set_lives(var val=0):
	lives += val
	get_node("HUD/Lives").text = "x " + str(lives)
	

func increase_score(var val=0):
	score += val
	get_node("HUD/Score").text = str(score)


func set_stage(var stage = 0):
	get_node("HUD/Stage").text = "Stage: %d" % stage
	set_lives()
	resume()


func decrease_ball():
	ball_count-=1
	if ball_count == 0:
		get_node("Board").setup()
		set_lives(-1)
		if lives == 0:
			get_node("Board").set_game_over()


func increase_ball():
	lives+=1
	set_lives()


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


func clear_balls():
	ball_count = 0
	var children = get_children()
	for child in children:
		if child.has_method("delete_ball"):
			child.delete_ball(false)
	get_node("Board").setup()
