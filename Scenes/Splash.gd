extends Polygon2D

func show_splash(var text:String):
	$Label.text = text
	visible = true


func hide_splash():
	visible = false
