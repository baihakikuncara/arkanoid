extends Node2D

const Ball = preload("res://Scenes/Ball.tscn")

export var lives = 3
var current_level = 1
var ball_count = 0
var score = 0
var pause = true
var level: Node2D
var brick_count = 0


func _ready():
	load_stage()


func launch_ball(var position):
	position.y-=16
	ball_count+=1
	var ball = Ball.instance()
	ball.translate(position)
	add_child(ball)
	
	
func add_lives(var val=0):
	lives += val
	get_node("HUD/Lives").text = "x " + str(lives)
	if lives == 0:
		game_over()
	

func increase_score(var val=0):
	score += val
	get_node("HUD/Score").text = "Score: " + str(score)


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
	
	get_node("StageTimer").start()
	get_node("Splash").show_splash("Stage: %d" % current_level)
	add_lives()
	increase_score()


func brick_destroyed(var score):
	increase_score(score)
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
		get_node("Board").setup()
		add_lives(-1)


func clear_balls():
	ball_count = 0
	var children = get_children()
	for child in children:
		if child.has_method("delete_ball"):
			child.delete_ball(false)
	get_node("Board").setup()


func game_over():
	var text = "Game Over\nStage: %d\nScore: %d" %[current_level, score]
	get_node("Splash").show_splash(text)
	get_node("Board").game_over()
	get_node("GameOverTimer").start()


func pause():
	pause = true
	var children = get_children()
	for child in children:
		if child.has_method("pause"):
			child.pause()


func resume():
	get_node("Splash").hide_splash()
	pause = false
	var children = get_children()
	for child in children:
		if child.has_method("resume"):
			child.resume()


func _on_GameOverTimer_timeout():
	get_tree().change_scene("res://Scenes/Home.tscn")


func _on_StageTimer_timeout():
	resume()
