extends Node2D

var shoot_mode = true
var pause = false

func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		$Player.multiply_ball()
		$Player/Board.set_shoot_mode(shoot_mode)
		shoot_mode = !shoot_mode
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
