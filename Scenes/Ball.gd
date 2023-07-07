extends KinematicBody2D

const MAX_SPEED = 1000
const SPEED_INCREASE = 10

export var color: Color = Color.azure
export var size: float = 5.0
export var speed: int = 200
export var direction: Vector2	= Vector2(1,1)




func _draw():
	draw_circle(Vector2(0,0), size, color)


func _physics_process(delta):
	var collision = move_and_collide(direction *speed*delta)
	if (collision):
		direction = direction.bounce((collision.normal))
		speed = min(speed+SPEED_INCREASE, MAX_SPEED)


func delete_node():
	queue_free()
	
