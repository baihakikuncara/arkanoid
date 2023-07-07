extends KinematicBody2D

export var speed: float = 800

var direction: Vector2 = Vector2(0,0)

func _process(delta):
	direction = Vector2(0,0)
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1

	move_and_collide(direction * speed * delta)
