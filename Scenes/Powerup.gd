extends Area2D

enum POWERUP {
	NONE,
	INC_SIZE,
	DEC_SIZE,
	SHOOT,
	MULTIPLY
}

var pause = false
var color = Color.aqua
var speed = 100
var type = POWERUP.NONE

func _draw():
	var width = $CollisionShape2D.shape.height
	var radius = $CollisionShape2D.shape.radius
	var rect_size = Vector2(width, radius * 2)
	draw_rect(Rect2(-rect_size/2, rect_size), color)
	
	draw_circle(Vector2(-width, 0)/2, radius, color)
	draw_circle(Vector2(width, 0)/2, radius, color)


func _process(delta):
	if pause: return
	position.y += speed * delta


func delete():
	queue_free()


func _on_Powerup_body_entered(body):
	match type:
		POWERUP.INC_SIZE:
			if body.has_method("resize"):
				body.resize(1)
				delete()
		POWERUP.DEC_SIZE:
			if body.has_method("resize"):
				body.resize(-1)
				delete()
		POWERUP.SHOOT:
			if body.has_method("set_shoot_mode"):
				body.set_shoot_mode(true)
				delete()
		POWERUP.MULTIPLY:
			if body.has_method("multiply"):
				body.multiply()
				delete()


func pause():
	pause = true
	for child in get_children():
		if child.has_method("pause"): child.pause()
		

func resume():
	pause = false
	for child in get_children():
		if child.has_method("resume"): child.resume()
