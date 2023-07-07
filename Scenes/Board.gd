extends KinematicBody2D

const MAX_DEGREE_MODIFIER = 0.5

export var speed: float = 800

var direction: Vector2 = Vector2(0,0)

func _process(delta):
	direction = Vector2(0,0)
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	move_and_collide(direction * speed * delta)


func collide(var p:Vector2):
	var shape:CollisionShape2D = get_node("CollisionShape2D")
	var size = shape.shape.extents.x
	return (p.x - position.x)/size * MAX_DEGREE_MODIFIER
	
