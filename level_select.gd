extends Control

@onready var menu = get_node("../menu")
@onready var level_select = get_node("../level_select")
@onready var settings = get_node("../settings")

func _ready() -> void:
	var num_of_levels = Global.levels.size()
	for x in get_children():
		for y in x.get_children():
			for z in y.get_children():
				if num_of_levels > 0:
					num_of_levels -= 1
				else:
					z.visible = false

func _on_back_pressed() -> void:
	if get_node("..").name == "main_menu":
		menu.visible = true
		level_select.visible = false
		settings.visible = false
	else:
		pass


func _on_level_01_pressed() -> void:
	Global.cur_level = 0
	get_tree().change_scene_to_file(Global.levels[Global.cur_level])


func _on_level_02_pressed() -> void:
	Global.cur_level = 1
	get_tree().change_scene_to_file(Global.levels[Global.cur_level])


func _on_level_03_pressed() -> void:
	Global.cur_level = 2
	get_tree().change_scene_to_file(Global.levels[Global.cur_level])


func _on_level_04_pressed() -> void:
	Global.cur_level = 3
	get_tree().change_scene_to_file(Global.levels[Global.cur_level])


func _on_level_05_pressed() -> void:
	Global.cur_level = 4
	get_tree().change_scene_to_file(Global.levels[Global.cur_level])
