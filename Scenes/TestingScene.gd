extends Node2D


func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		$Player.multiply_ball()
	if Input.is_action_just_released("ui_page_up"):
		print("resize+")
		$Player/Board.resize(1)
	if Input.is_action_just_released("ui_page_down"):
		print("resize-")
		$Player/Board.resize(-1)
