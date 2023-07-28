extends KinematicBody2D

const HIT_MARK = preload("res://Scenes/Hit.tscn")

const MAX_SPEED = 1000
const SPEED_INCREASE = 10

export var speed: int = 200
export var direction: Vector2	= Vector2(1,-1)

var pause = false


func _physics_process(delta):
	if pause: return
	var collision = move_and_collide(direction *speed*delta)
	if (collision):
		var hitmark = HIT_MARK.instance()
		hitmark.position = global_position
		get_parent().add_child(hitmark)
		
		var modifier = 0
		if collision.collider.has_method("hit"):
			collision.collider.hit()
		if collision.collider.has_method("collide"):
			modifier = collision.collider.collide(collision.position)
		var angle = collision.normal
		direction = direction.bounce(angle).rotated(modifier).normalized()
		speed = min(speed+SPEED_INCREASE, MAX_SPEED)


func delete_ball(var notify = true):
	var parent = get_parent()
	if notify and parent.has_method("decrease_ball"):
		parent.decrease_ball()
	queue_free()
	
	
func pause():
	pause = true
	var children = get_children()
	for child in children:
		if child.has_method("pause"): child.pause()
	

func resume():
	pause = false
	var children = get_children()
	for child in children:
		if child.has_method("resume"): child.resume()
