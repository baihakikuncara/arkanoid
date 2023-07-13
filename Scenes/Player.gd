extends Node2D

const Ball = preload("res://Scenes/Ball.tscn")

var current_level = 1
var ball_count = 0
var pause = true
var level: Node2D
var brick_count = 0
var lives = 3
var scores = 0


func _ready():
	load_stage()
	$HUD.set_lives(lives)
	$HUD.set_score(scores)
	$HUD.set_stage(current_level)


func launch_ball(var position):
	position.y-=16
	ball_count+=1
	var ball = Ball.instance()
	ball.translate(position)
	add_child(ball)
	

func load_stage():
	var path = "res://Scenes/Stages/Stage%0*d.tscn"%[3, current_level]
	var scene = load(path)
	if level != null : level.queue_free()
	level = scene.instance()
	add_child(level)
	
	brick_count = 0
	var children = level.get_children()
	for child in children:
		if child.has_method("hit"):
			brick_count+=1
	
	get_node("HUD/Stage").text = "Stage: %d" % current_level
	
	$StageTimer.start()
	$Splash.show_splash("Stage: %d" % current_level)


func brick_destroyed(var score):
	scores += score
	$HUD.set_score(score)
	brick_count -= 1
	if brick_count <= 0:
		level.queue_free()
		pause()
		clear_balls()
		current_level += 1
		load_stage()


func decrease_ball():
	ball_count-=1
	if ball_count == 0:
		$Board.setup()
		lives-=1
		$HUD.set_lives(lives)
		if lives == 0:
			game_over()


func clear_balls():
	ball_count = 0
	var children = get_children()
	for child in children:
		if child.has_method("delete_ball"):
			child.delete_ball(false)
	$Board.setup()


func game_over():
	var text = "Game Over\nStage: %d\nScore: %d" %[current_level, $HUD.scores]
	$Splash.show_splash(text)
	$GameOverTimer.start()
	var children = get_children()
	for child in children:
		if child.has_method("game_over"): child.game_over()


func pause():
	pause = true
	var children = get_children()
	for child in children:
		if child.has_method("pause"):
			child.pause()


func resume():
	$Splash.hide_splash()
	pause = false
	var children = get_children()
	for child in children:
		if child.has_method("resume"):
			child.resume()


func _on_GameOverTimer_timeout():
	get_tree().change_scene("res://Scenes/Home.tscn")


func _on_StageTimer_timeout():
	resume()
