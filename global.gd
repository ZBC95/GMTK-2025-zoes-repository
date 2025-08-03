extends Node

var levels = [
	"res://Levels/game_level_dev_01.tscn", 
	"res://Levels/game_level_dev_02.tscn",
	"res://Levels/game_level_tutorial_03.tscn",
	"res://Levels/game_level_tutorial_04.tscn",
	"res://Levels/game_level_hard1.tscn",
]
var music_volume = 1.0
var sfx_volume = 1.0
var cur_level: int
var speech_tutorial_num: int = 0
var speech_level_count: int = 0
var speech_joke_num: int = 0

var level_score = {
	0: 0,
	1: 0
}
func load_cur():
	speech_tutorial_num += 1
	get_tree().change_scene_to_file(levels[cur_level])
