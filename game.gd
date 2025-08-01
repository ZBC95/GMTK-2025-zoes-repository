extends Node2D

signal ghost_spawned(sent_ghost)

@export var ghost_scene : PackedScene
@export var next_level : String
@onready var player = get_node("Player")
@onready var loop = get_node("Level/Looping_Componenet")

func _ready():
	SignalBus.player_looped.connect(_on_player_looped)
	SignalBus.level_completed.connect(_on_level_completed)
	var ghost_init = ghost_scene.instantiate()
	
	ghost_init.is_static = true
	ghost_init.movement_data = {0: {
		"position_x": player.position.x + (loop.br_x*64 - loop.bl_x*64),
		"position_y": player.position.y + (loop.br_y*64 - loop.bl_y*64),
		"animation": "idle",
		"flip_h": false
	}}
	add_child(ghost_init)

func _on_player_looped(movement_data):
	var ghost = ghost_scene.instantiate()
	ghost.movement_data = movement_data
	var ghost2 = ghost_scene.instantiate()
	ghost2.movement_data = {0: {
		"position_x": player.position.x,
		"position_y": player.position.y,
		"animation": "idle",
		"flip_h": false
	}}
	ghost2.is_static = true
	#print(ghost.movement_data)
	#print(ghost2.movement_data)
	add_child(ghost)
	ghost_spawned.emit(ghost)
	add_child(ghost2)

func _on_level_completed():
	print("level complete")
	get_tree().change_scene_to_file(next_level)
