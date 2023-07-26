extends Node2D

const BALL_SCENE = preload("res://Scenes/Ball.tscn")
const BULLET_SCENE = preload("res://Scenes/Bullet.tscn")
const POWERUP = preload("res://Scenes/Powerup.tscn")
const SCORE_BONUS = 2

var current_level = 1
var ball_count = 0
var pause = true
var level: Node2D
var brick_count = 0
var lives = 3
var scores = 0


func _ready():
	load_stage()
	set_hud()


func set_hud():
	$HUD.set_lives(lives)
	$HUD.set_score(scores)
	$HUD.set_stage(current_level)


func launch_ball(var position, var direction):
	ball_count+=1
	var ball = BALL_SCENE.instance()
	ball.translate(position)
	ball.direction = direction
	add_child(ball)


func multiply_ball():
	var children = get_children();
	for child in children:
		if child.has_method("delete_ball"):
			var direction = child.direction
			launch_ball(child.position, child.direction.rotated(0.5))
			launch_ball(child.position, child.direction.rotated(-0.5))


func spawn_powerup(var location, var type = 0):
	var powerup = POWERUP.instance()
	powerup.position = location
	powerup.type = type
	add_child(powerup)
	

func load_stage():
	var path = "res://Scenes/Stages/Stage%0*d.tscn"%[3, current_level]
	var scene = load(path)
	if level != null : level.queue_free()
	level = scene.instance()
	add_child(level)
	
	brick_count = 0
	var children = level.get_children()
	for child in children:
		if "breakable" in child and child.breakable:
			brick_count+=1
	set_hud()
	$Splash.show_stage_splash(current_level)
	$StageTimer.start()


func brick_destroyed(var score):
	scores += score * SCORE_BONUS / min($Board.length, 2)
	brick_count -= 1
	if brick_count <= 0:
		pause()
		level.queue_free()
		clear_balls()
		clear_powerups()
		$Board.setup()
		current_level += 1
		load_stage()
	set_hud()


func decrease_ball():
	ball_count-=1
	if ball_count == 0:
		$Board.setup()
		lives-=1
		if lives == 0:
			game_over()
	set_hud()


func clear_balls():
	ball_count = 0
	var children = get_children()
	for child in children:
		if child.has_method("delete_ball"):
			child.delete_ball(false)


#delete powerups and bullets
func clear_powerups():
	for child in get_children():
		if child.has_method("delete"):
			child.delete()


func shoot(var pos):
	var bullet = BULLET_SCENE.instance()
	bullet.translate(pos)
	add_child(bullet)


func game_over():
	$Splash.show_game_over_splash(current_level, scores)
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
