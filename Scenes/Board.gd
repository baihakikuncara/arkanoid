tool

extends KinematicBody2D

const MAX_DEGREE_MODIFIER = 0.5
const MIN_BOARD_SIZE = 1
const MAX_BOARD_SIZE = 4
const SHOOT_TIMEOUT = 0.7
const DEFAULT_LENGTH = 2
const SPEED = 100

var speed_adj = 0
var launched = false
var direction: Vector2 = Vector2(0,0)
var game_over = false
var pause = true
var length = DEFAULT_LENGTH
var shoot_mode = false
var shoot_timer = 0


func _process(delta):
	if pause or game_over : return
	if shoot_mode:
		shoot_timer+= delta
		if shoot_timer > SHOOT_TIMEOUT:
			shoot_timer = 0
			shoot()
	direction = Vector2(0,0)
	if !launched and Input.is_action_pressed("ui_up"):
		launch_ball()
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		
	if direction.x == 0: speed_adj = 0
	else: speed_adj+=delta
	move_and_collide(direction * SPEED * clamp(speed_adj, 0, 0.8))


func _draw():
	var color = Color.red if shoot_mode else Color.azure
	var rect = Vector2($CollisionShape2D.shape.extents.x * 2, $CollisionShape2D.shape.extents.y * 2)
	draw_rect(Rect2(-rect/2, rect), color)


func resize(var val):
	set_shoot_mode(false)
	length = clamp(length + val, MIN_BOARD_SIZE, MAX_BOARD_SIZE)
	$CollisionShape2D.shape.extents.x = 16 * length	
	update()


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
		player.launch_ball(position+$BallSprite.position, Vector2(1,-1))
	
	
func shoot():
	var parent = get_parent()
	if parent.has_method("shoot"):
		parent.shoot($bullet0.global_position)
		parent.shoot($bullet1.global_position)
		

func setup():
	launched = false
	shoot_mode = false
	shoot_timer = 0
	get_node("BallSprite").visible = true
	resize(DEFAULT_LENGTH- length)
	update()
	
	
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


func set_shoot_mode(var state):
	if state: resize(DEFAULT_LENGTH - length)
	shoot_mode = state
	if shoot_mode: 
		shoot_timer = SHOOT_TIMEOUT
	update()


func multiply():
	get_parent().multiply_ball()
	

