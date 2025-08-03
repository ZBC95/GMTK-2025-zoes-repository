extends Control

@onready var menu = get_node("../menu")
@onready var level_select = get_node("../level_select")
@onready var settings = get_node("../settings")

func _ready() -> void:
	var level_count = Global.levels.size()
	var label_count = Global.levels.size()
	var count = 0
	for x in get_children():
		for y in x.get_children():
			for z in y.get_children():
				if z.name.left(5) == "Level":
					if level_count > 0:
						level_count -= 1
					else:
						z.visible = false
				elif z.name.left(5) == "Label":
					if label_count > 0:
						if z.name.left(5) == "Label":
							if Global.level_score.get(count) == 1:
								z.text = ":)"
							elif Global.level_score.get(count) == 2:
								z.text = ":D"
							count += 1
						label_count -= 1
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
	Global.load_cur()


func _on_level_02_pressed() -> void:
	Global.cur_level = 1
	Global.load_cur()


func _on_level_03_pressed() -> void:
	Global.cur_level = 2
	Global.load_cur()


func _on_level_04_pressed() -> void:
	Global.cur_level = 3
	Global.load_cur()


func _on_level_05_pressed() -> void:
	Global.cur_level = 4
	Global.load_cur()


func _on_level_06_pressed() -> void:
	Global.cur_level = 5
	Global.load_cur()


func _on_level_07_pressed() -> void:
	Global.cur_level = 6
	Global.load_cur()

func _on_level_08_pressed() -> void:
	Global.cur_level = 7
	Global.load_cur()


func _on_level_09_pressed() -> void:
	Global.cur_level = 8
	Global.load_cur()
