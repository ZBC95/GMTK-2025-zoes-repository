extends CharacterBody2D

var movement_data : Dictionary = Dictionary()
var count = -1
var is_static: bool = false
var overlaps
var channel_to_emit: int = 0
var colours = [Color.BLUE,Color.BLUE, Color.RED,Color.RED, Color.GREEN,Color.GREEN, Color.ORANGE,Color.ORANGE, Color.YELLOW,Color.YELLOW, Color.WHITE,Color.WHITE, Color.PURPLE,Color.PURPLE,]
var colour
var found_unblock = false
var unblock_forward = 0
var next_unblock: int

@onready var loop = get_node("../Level/Looping_Componenet")
@onready var loop_position_end: Vector2 = Vector2(loop.br_x*64, loop.br_y*64)
@onready var player = get_node("../Player")
@onready var ghost_sprite: AnimatedSprite2D = %GhostSprite
@onready var game = $".."

func _ready() -> void:
	SignalBus.player_looped.connect(_on_player_looped)
	ghost_sprite.modulate = colours[Global.ghost_num]
	ghost_sprite.modulate.a = 0.4
	colour = ghost_sprite.modulate
	Global.ghost_num += 1
	
	if movement_data.has(0):
		var frame_data = movement_data[0]
		position = Vector2(frame_data["position_x"], frame_data["position_y"])
		if ghost_sprite:
			ghost_sprite.play(frame_data["animation"])
			ghost_sprite.flip_h = frame_data["flip_h"]
		

func _physics_process(_delta: float) -> void:
	update_collision_layers()
	update_position()
	if position.x > loop_position_end.x and is_static == false:
		position.x = 1000000

func update_position():
	count += 1
	if movement_data.has(count):
		var frame_data = movement_data[count]
		position = Vector2(frame_data["position_x"], frame_data["position_y"])
		if ghost_sprite:
			ghost_sprite.play(frame_data["animation"])
			ghost_sprite.flip_h = frame_data["flip_h"]

func _on_player_looped(movement_data):
	get_node(".").count = -1
	
func update_collision_layers():
	if ghost_sprite.animation == "block":
		ghost_sprite.modulate.a = 1.0
		$Area2D.set_collision_layer_value(2, true)
		$Area2D.set_collision_layer_value(3, false)
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
		flash()
	else:
		ghost_sprite.modulate = colour
		$Area2D.set_collision_layer_value(2, false)
		$Area2D.set_collision_layer_value(3, true)
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
		found_unblock = false

func flash():
	if found_unblock == false:
		unblock_forward = 0
		while found_unblock == false:
			var frame_data = movement_data[count + unblock_forward]
			if frame_data["animation"] != "block":
				found_unblock = true
				next_unblock = count + unblock_forward
			else:
				unblock_forward += 1
			print(count)
			print(unblock_forward)
	if next_unblock - count < 30:
		ghost_sprite.modulate.a = 0.4+(0.6*(float(next_unblock - count)/30.0))
	elif next_unblock - count < 90:
		if count%6 < 3:
			ghost_sprite.modulate.a = 0.8
	elif next_unblock - count < 150:
		if count%16 < 4:
			ghost_sprite.modulate.a = 0.8
	elif next_unblock - count < 240:
		if count%30 < 4:
			ghost_sprite.modulate.a = 0.8
