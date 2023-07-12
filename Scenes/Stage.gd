extends Area2D

var player
var level:Node2D
var stage = 1

func _ready():
	player = get_node("Player")
	load_stage(stage)


func load_stage(var stage:int):
	var path = "res://Scenes/Stages/Stage%0*d.tscn"%[3, stage]
	var scene = load(path)
	level = scene.instance()
	add_child(level)
	player.set_stage(stage)
	player.pause()
	get_node("StartTimer").start()


func brick_destroyed(var score):
	player.increase_score(score)
	if level.get_child_count() <= 1:
		level.queue_free()
		player.pause()
		player.clear_balls()
		stage += 1
		load_stage(stage)


func _on_StartTimer_timeout():
	player.resume()
