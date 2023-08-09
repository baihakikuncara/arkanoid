extends Polygon2D

var pause = false

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed and pause:
			if get_parent().has_method("resume"):
				get_parent().resume()


func show_splash(var text:String):
	$Label.text = text
	visible = true


func hide_splash():
	visible = false


func show_stage_splash(var level):
	visible = true
	$Label.text = "Stage " + str(level)
	
	
func show_game_over_splash(var level, var score, var endgame = false):
	var text = ""
	if endgame:
		text = "Thanks for playing\n"
	text += "Game Over\nStage: %d\nScore: %d" %[level, score]
	$Label.text = text
	visible = true


func pause():
	pause = true
	visible = true
	$Label.text = "PAUSED\ntap to continue\npress back to return to home"
	var children = get_children()
	for child in children:
		if child.has_method("pause"): child.pause()


func resume():
	pause = false
	visible = false
	var children = get_children()
	for child in children:
		if child.has_method("resume"): child.resume()

