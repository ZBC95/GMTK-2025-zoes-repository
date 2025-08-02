extends Control

@onready var game = get_node("../../..")
@onready var pause_menu = get_node("../pause_menu")
@onready var settings = get_node("../settings")

func _on_resume_pressed() -> void:
	game.pause()


func _on_settings_pressed() -> void:
	pause_menu.visible = false
	settings.visible = true


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
