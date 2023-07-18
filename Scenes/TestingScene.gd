extends Node2D


func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		$Board.resume()
	if Input.is_action_pressed("ui_page_up"):
		print("resize+")
		$Board.resize(1)
	if Input.is_action_pressed("ui_page_down"):
		print("resize-")
		$Board.resize(-1)
