extends Control

@onready var menu = get_node("../menu")
@onready var level_select = get_node("../level_select")
@onready var settings = get_node("../settings")
@onready var music_slider = $VBoxContainer/music_container/VBoxContainer/music_slider
@onready var sfx_slider = $VBoxContainer/sfx_container/VBoxContainer/sfx_slider

func _ready() -> void:
	music_slider.value = Global.music_volume
	sfx_slider.value = Global.sfx_volume

func _on_back_pressed() -> void:
	if get_node("..").name == "main_menu":
		menu.visible = true
		level_select.visible = false
		settings.visible = false
	else:
		pass

func _process(delta: float) -> void:
	$VBoxContainer/music_container/VBoxContainer/music_value.text = str(music_slider.value).pad_decimals(2)
	$VBoxContainer/sfx_container/VBoxContainer/sfx_value.text = str(sfx_slider.value).pad_decimals(2)


func _on_music_submit_pressed() -> void:
	Global.music_volume = music_slider.value


func _on_sfx_submit_pressed() -> void:
	Global.sfx_volume = sfx_slider.value
