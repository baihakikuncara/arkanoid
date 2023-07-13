extends KinematicBody2D

const MAX_DEGREE_MODIFIER = 0.5

export var speed: float = 800
var launched = false
var direction: Vector2 = Vector2(0,0)
var game_over = false
var pause = true

func _process(delta):
	if pause or game_over : return
	direction = Vector2(0,0)
	if !launched and Input.is_action_pressed("ui_up"):
		launch_ball()
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	move_and_collide(direction * speed * delta)


func collide(var p:Vector2):
	if p.y+6 > position.y:
		return 0
	var shape:CollisionShape2D = get_node("CollisionShape2D")
	var size = shape.shape.extents.x
	return (p.x - position.x)/size * MAX_DEGREE_MODIFIER
	

func launch_ball():
	launched = true
	get_node("BallSprite").visible = false
	var player = get_parent()
	if player.has_method("launch_ball"):
		player.launch_ball(position)
	

func setup():
	launched = false
	get_node("BallSprite").visible = true
	
	
func game_over(var val = true):
	game_over = val
	var children = get_children()
	for child in children:
		if child.has_method("game_over"): child.game_over()


func pause():
	pause = true
	var children = get_children()
	for child in children:
		if child.has_method("pause"): child.pause()
	
	
func resume():
	pause = false
	var children = get_children()
	for child in children:
		if child.has_method("resume"): child.resume()
	
