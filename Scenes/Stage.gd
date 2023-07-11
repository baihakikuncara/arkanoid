extends Area2D

var player
var level:Node2D
var stage = 1

func _ready():
	player = get_node("Player")
	loadStage(stage)


func loadStage(var stage:int):
	var path = "res://Scenes/Stages/Stage%0*d.tscn"%[3, stage]
	var scene = load(path)
	level = scene.instance()
	add_child(level)
	player.setStage(stage)
	

func brickDestroyed(var score):
	player.incScore(score)
	if level.get_child_count() <= 1:
		stage += 1
		level.queue_free()
		loadStage(stage)
