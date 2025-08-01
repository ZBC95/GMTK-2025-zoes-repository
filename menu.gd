extends Control

@onready var menu = get_node("../menu")
@onready var level_select = get_node("../level_select")
@onready var settings = get_node("../settings")

var first_level = "res://Levels/game_level_dev_01.tscn"

func _ready() -> void:
	#var menu = get_node("../menu")
	#var level_select = get_node("../level_select")
	#var settings = get_node("../settings")
	
	menu.visible = true
	level_select.visible = false
	settings.visible = false

func _on_new_game_pressed() -> void:
	Global.cur_level = 0
	get_tree().change_scene_to_file(Global.levels[Global.cur_level])


func _on_level_select_pressed() -> void:
	open_level_select()


func _on_settings_pressed() -> void:
	open_settings()


func _on_exit_game_pressed() -> void:
	get_tree().quit()

func open_level_select():
	menu.visible = false
	level_select.visible = true
	settings.visible = false

func open_settings():
	menu.visible = false
	level_select.visible = false
	settings.visible = true
