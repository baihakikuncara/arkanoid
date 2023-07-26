extends Node2D

const POWERUP = preload("res://Scenes/Powerup.tscn")

var pause = false
var power = 1

func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		var powerup = POWERUP.instance()
		powerup.position = Vector2(300, 200)
		powerup.type = power
		power = (power + 1) % len(powerup.POWERUP)
		add_child(powerup)
	if Input.is_action_just_released("ui_page_up"):
		print("resize+")
		$Player/Board.resize(1)
	if Input.is_action_just_released("ui_page_down"):
		print("resize-")
		$Player/Board.resize(-1)
	if Input.is_action_just_released("ui_home"):
		pause = !pause
		if pause : $Player.pause()
		else: $Player.resume()
