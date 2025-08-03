extends Control

@onready var menu = get_node("../menu")
@onready var level_select = get_node("../level_select")
@onready var settings = get_node("../settings")

func _ready() -> void:
	#var menu = get_node("../menu")
	#var level_select = get_node("../level_select")
	#var settings = get_node("../settings")
	
	# Grab focus on first element in menu for controllers
	var vbox = get_node("VBoxContainer")
	vbox.get_child(0).grab_focus()
	
	menu.visible = true
	level_select.visible = false
	settings.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Mute"):
		Global.music_volume = 0.0

func _on_new_game_pressed() -> void:
	Global.cur_level = 0
	Global.load_cur()


func _on_level_select_pressed() -> void:
	open_level_select()


func _on_settings_pressed() -> void:
	open_settings()


func _on_exit_game_pressed() -> void:
	get_tree().quit()

func open_level_select():

	level_select.visible = true


func open_settings():


	settings.visible = true
