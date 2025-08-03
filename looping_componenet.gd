extends Node2D

@export var tl_x: int = 0
@export var tl_y: int = 0

@export var tr_x: int = 0
@export var tr_y: int = 0

@export var bl_x: int = 0
@export var bl_y: int = 0

@export var br_x: int = 0
@export var br_y: int = 0

@export var instances:int = 1



func _ready() -> void:
	$bottom_left/AnimatedSprite2D.play("default")
	$bottom_left/AnimatedSprite2D2.play("default")
	$bottom_left/AnimatedSprite2D3.play("default")
	$bottom_left/AnimatedSprite2D4.play("default")
	
	$bottom_right/AnimatedSprite2D2.play("default")
	$bottom_right/AnimatedSprite2D3.play("default")
	$bottom_right/AnimatedSprite2D4.play("default")
	$bottom_right/AnimatedSprite2D5.play("default")
	
	
	var player = get_node("../../Player")
	var level = get_node("../../Level")
	var tilemap = get_node("../Platforms")
	var tilemap_bg = get_node("../Background")
	var temp = tilemap
	var temp2
	
	get_node("top_left").position = Vector2(tl_x*64, tl_y*64)
	get_node("top_right").position = Vector2(tr_x*64, tr_y*64)
	get_node("bottom_left").position = Vector2(bl_x*64, bl_y*64)
	get_node("bottom_right").position = Vector2(br_x*64, br_y*64)
	
	for i in instances:
		temp = tilemap.duplicate()
		temp.name = tilemap.name + str(i) + "f"
		temp.i = i
		temp.position.x += (get_node("bottom_right").position.x - get_node("bottom_left").position.x)*(i+1)
		temp.position.y += (get_node("bottom_right").position.y - get_node("bottom_left").position.y)*(i+1)
		add_sibling.call_deferred(temp)
		
		temp = tilemap.duplicate()
		temp.name = tilemap.name + str(i) + "b"
		temp.i = i
		temp.position.x -= (get_node("bottom_right").position.x - get_node("bottom_left").position.x)*(i+1)
		temp.position.y -= (get_node("bottom_right").position.y - get_node("bottom_left").position.y)*(i+1)
		add_sibling.call_deferred(temp)
		
		temp = tilemap_bg.duplicate()
		temp.name = tilemap_bg.name + str(i) + "f"
		temp.i = i
		temp.position.x += (get_node("bottom_right").position.x - get_node("bottom_left").position.x)*(i+1)
		temp.position.y += (get_node("bottom_right").position.y - get_node("bottom_left").position.y)*(i+1)
		add_sibling.call_deferred(temp)
		
		temp = tilemap_bg.duplicate()
		temp.name = tilemap_bg.name + str(i) + "b"
		temp.i = i
		temp.position.x -= (get_node("bottom_right").position.x - get_node("bottom_left").position.x)*(i+1)
		temp.position.y -= (get_node("bottom_right").position.y - get_node("bottom_left").position.y)*(i+1)
		add_sibling.call_deferred(temp)
		
		#for x in level.get_children():
			#if x.name.left(4) == "Door" or x.name.left(4) == "Exit" or x.name.left(4) == "Ligh" or x.name.left(4) == "Butt":
				#temp = x.duplicate()
				#temp2 = x.duplicate()
				#temp.position.x = temp.position.x + ($"bottom_right".position.x - $"bottom_left".position.x)
				#print((get_node("bottom_right").position.x - get_node("bottom_left").position.x))
				#temp.position.y += x.position.y + (get_node("bottom_right").position.y - get_node("bottom_left").position.y)
				#temp.position.x -= x.position.x + (get_node("bottom_right").position.x - get_node("bottom_left").position.x)
				#temp.position.y -= x.position.y + (get_node("bottom_right").position.y - get_node("bottom_left").position.y)
				#print(temp.position)
				#print(temp2.position)
		
		#print(temp.name) 
		#print(temp.i)
		#print(temp.position)
		#print("\n")
	#print(get_parent().get_children())
