extends KinematicBody2D

const MAX_SPEED = 1000
const SPEED_INCREASE = 10

export var speed: int = 200
export var direction: Vector2	= Vector2(0,-1)


func _physics_process(delta):
	var collision = move_and_collide(direction *speed*delta)
	if (collision):
		var modifier = 0
		if collision.collider.has_method("hit"):
			collision.collider.hit()
		if collision.collider.has_method("collide"):
			modifier = collision.collider.collide(collision.position)
		var angle = collision.normal
		direction = direction.bounce(angle).rotated(modifier).normalized()
		speed = min(speed+SPEED_INCREASE, MAX_SPEED)


func delete_node():
	print("queue_free")
	var parent = get_parent()
	if parent.has_method("decreaseBall"):
		parent.decreaseBall()
	queue_free()
	
