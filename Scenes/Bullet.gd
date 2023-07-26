
extends KinematicBody2D

var speed = 10
var pause = false


func _draw():
	draw_rect(Rect2(-$CollisionShape2D.shape.extents, $CollisionShape2D.shape.extents*2), Color.red)


func _process(delta):
	if pause:
		return
	var collision = move_and_collide(Vector2(0, -1) * speed)
	if collision:
		if collision.collider.has_method("hit"):
			collision.collider.hit()
		queue_free()


func delete():
	queue_free()


func pause():
	pause = true
	for children in get_children():
		if children.has_method("pause"):
			children.pause()
			
			
func resume():
	pause = false
	for children in get_children():
		if children.has_method("resume"):
			children.resume()
	
