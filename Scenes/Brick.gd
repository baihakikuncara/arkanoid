tool

extends StaticBody2D

export var durability = 1
export var score = 10
export var breakable = true
export var outline: Color = Color.black
export var fill: Color = Color.green
export var line_width = 2
export var has_powerup = false
export var powerup_type = 0


func _ready():
	if !breakable:
		outline = Color.white
		fill = Color.black
	if has_powerup:
		fill = Color.cyan
		

func _draw():
	var width = $CollisionShape2D.shape.extents.x 
	var height = $CollisionShape2D.shape.extents.y
	draw_rect(Rect2(-width, -height, width*2, height*2), fill)
	draw_rect(Rect2(-width+(line_width/2), -height+(line_width/2), width*2-line_width, height*2-line_width), outline, false, line_width, true)


func hit():
	if !breakable: return
	durability -= 1
	if durability == 0:
		queue_free()
		if has_powerup:
			var parent = get_parent().get_parent()
			if parent.has_method("spawn_powerup"):
				parent.spawn_powerup(global_position, powerup_type)


func _on_Brick_tree_exiting():
	var stage = get_parent().get_parent()
	if stage.has_method("brick_destroyed"):
		stage.brick_destroyed(score)
