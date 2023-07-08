tool

extends Node2D


export var color: Color = Color.azure
export var size: float = 5.0


func _draw():
	draw_circle(Vector2(0,0), size, color)
