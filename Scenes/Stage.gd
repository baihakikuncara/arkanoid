extends Area2D

var player
var level:Node2D

func _ready():
	player = get_node("Player")
	loadStage(1)
	
	

func loadStage(var stage:int):
	var path = "res://Scenes/Stages/Stage%0*d.tscn"%[3, stage]
	var scene = load(path)
	level = scene.instance()
	add_child(level)
	player.setStage(stage)
	

func brickDestroyed(var score):
	player.incScore(score)
	print(level.get_child_count())
