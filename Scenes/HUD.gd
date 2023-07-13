extends Node2D

func reset():
	set_lives(3)
	set_stage(1)
	set_score(0)


func set_lives(var lives = 1):
	$Lives.text = "x " + str(lives)
	

func set_stage(var stage):
	$Stage.text = "Stage: " + str(stage)
	
	
func set_score(var scores = 0):
	$Score.text = "Score: " + str(scores)
