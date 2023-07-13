extends Node2D

var lives = 3
var stage = 1
var scores = 0


func reset():
	lives = 3
	stage = 1
	scores = 0


func add_lives(var val = 1):
	lives += val
	$Lives.text = "x " + str(lives)
	

func update_stage(var val):
	stage = val
	$Stage.text = "Stage: " + str(stage)
	
	
func add_score(var val = 0):
	scores += val
	$Score.text = "Score: " + str(scores)
