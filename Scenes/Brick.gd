tool

extends StaticBody2D

export var durability = 1
export var score = 10
export var breakable = true


func _ready():
	if !breakable:
		$Outline.color = Color.white
		$Fill.color = Color.black


func hit():
	if !breakable: return
	durability -= 1
	if durability == 0:
		queue_free()


func _on_Brick_tree_exiting():
	var stage = get_parent().get_parent()
	if stage.has_method("brick_destroyed"):
		stage.brick_destroyed(score)
