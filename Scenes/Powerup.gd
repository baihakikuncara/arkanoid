extends Area2D

var color = Color.aqua
var speed = 100
var type = 0

func _draw():
	var width = $CollisionShape2D.shape.height
	var radius = $CollisionShape2D.shape.radius
	var rect_size = Vector2(width, radius * 2)
	draw_rect(Rect2(-rect_size/2, rect_size), color)
	
	draw_circle(Vector2(-width, 0)/2, radius, color)
	draw_circle(Vector2(width, 0)/2, radius, color)


func _process(delta):
	position.y += speed * delta


func delete():
	queue_free()


func _on_Powerup_body_entered(body):
	if body.has_method("powerup"):
		body.powerup(type)
		delete()
