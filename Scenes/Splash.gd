extends Polygon2D

func show_splash(var text:String):
	$Label.text = text
	visible = true


func hide_splash():
	visible = false


func show_stage_splash(var level):
	visible = true
	$Label.text = "Stage " + str(level)
	
	
func show_game_over_splash(var level, var score):
	visible = true
	$Label.text = "Game Over\nStage: %d\nScore: %d" %[level, score]
