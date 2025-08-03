extends Node2D

signal ghost_spawned(sent_ghost)

@export var ghost_scene : PackedScene

@onready var player = get_node("Player")
@onready var loop = get_node("Level/Looping_Componenet")
@onready var star = get_node("Level/star")
@onready var level = get_node("Level")
@onready var pause_comp = get_node("CanvasLayer/pause_component")
@onready var pause_sound: AudioStreamPlayer = %PauseSound
@onready var nice_sound: AudioStreamPlayer = %NiceSound


var is_paused = false
var pause_vol = 1.0
var pause_pitch = 1.0

func _ready():
	Global.ghost_num = 0
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

func _process(delta: float) -> void:
	$MusicPlayer.volume_linear = Global.music_volume*pause_vol
	$MusicPlayer.pitch_scale = pause_pitch
	if Input.is_action_just_pressed("Restart"):
		Global.load_cur()
	if Input.is_action_just_pressed("Pause"):
		pause()
	if Input.is_action_just_pressed("Mute"):
		Global.music_volume = 0.0
	

func _on_player_looped(movement_data):
	player.loop_sound.play()
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
	nice_sound.play()
	if star.collected == true:
		Global.level_score.set(Global.cur_level, 2)
	elif Global.level_score.get(Global.cur_level) != 2:
		Global.level_score.set(Global.cur_level, 1)
		
	Global.cur_level += 1
	if Global.levels.size() > Global.cur_level:
		Global.load_cur()
	else:
		get_tree().change_scene_to_file("res://main_menu.tscn")

func pause():
	pause_sound.play()
	if not is_paused:
		pause_comp.visible = true
		for x in get_children():
			if x != $Camera2D and x != $MusicPlayer and x != $CanvasLayer:
				x.process_mode = PROCESS_MODE_DISABLED
		pause_vol = 0.25
		pause_pitch = 0.5
		is_paused = not is_paused
	else:
		pause_comp.visible = false
		for x in get_children():
			if x != $Camera2D and x != $MusicPlayer and x != $CanvasLayer:
				x.process_mode = PROCESS_MODE_INHERIT
		pause_vol = 1.0
		pause_pitch = 1.0
		is_paused = not is_paused
