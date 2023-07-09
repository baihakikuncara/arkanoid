extends Node2D

const Ball = preload("res://Scenes/Ball.tscn")

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for i in 24:
		var ball = Ball.instance()
		ball.position.x = rng.randi_range(30,570)
		ball.position.y = rng.randi_range(30,770)
		ball.direction.x = rng.randf_range(-1, 1)
		ball.direction.y = rng.randf_range(-1, 1)
		add_child(ball)


func _on_Quit_pressed():
	get_tree().quit()


func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Stage.tscn")
