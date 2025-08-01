extends Node2D

@export var tl_x: int = 0
@export var tl_y: int = 0

@export var tr_x: int = 0
@export var tr_y: int = 0

@export var bl_x: int = 0
@export var bl_y: int = 0

@export var br_x: int = 0
@export var br_y: int = 0

@export var instances:int = 2



func _ready() -> void:
	var player = get_node("../../Player")
	var level = get_node("../../Level")
	var tilemap = get_node("../Platforms")
	var temp = tilemap
	
	get_node("top_left").position = Vector2(tl_x*64, tl_y*64)
	get_node("top_right").position = Vector2(tr_x*64, tr_y*64)
	get_node("bottom_left").position = Vector2(bl_x*64, bl_y*64)
	get_node("bottom_right").position = Vector2(br_x*64, br_y*64)
	
	for i in instances:
		temp = tilemap.duplicate()
		temp.name = tilemap.name + str(i) + "f"
		temp.i = i
		temp.position.x += (get_node("bottom_right").position.x - get_node("bottom_left").position.x)*i
		temp.position.y += (get_node("bottom_right").position.y - get_node("bottom_left").position.y)*i
		add_sibling.call_deferred(temp)
		
		temp = tilemap.duplicate()
		temp.name = tilemap.name + str(i) + "b"
		temp.i = i
		temp.position.x -= (get_node("bottom_right").position.x - get_node("bottom_left").position.x)*i
		temp.position.y -= (get_node("bottom_right").position.y - get_node("bottom_left").position.y)*i
		add_sibling.call_deferred(temp)
		
		#print(temp.name) 
		#print(temp.i)
		#print(temp.position)
		#print("\n")
	#print(get_parent().get_children())
