extends CharacterBody2D

var movement_data : Dictionary = Dictionary()
var count = -1
@onready var loop = get_node("../Level/Looping_Componenet")
@onready var loop_position_end: Vector2 = Vector2(loop.br_x*64, loop.br_y*64)
@onready var ghost_sprite: AnimatedSprite2D = %GhostSprite

func _ready() -> void:
	if movement_data.has(0):
		var frame_data = movement_data[0]
		position = Vector2(frame_data["position_x"], frame_data["position_y"])
		if ghost_sprite:
			ghost_sprite.play(frame_data["animation"])
			ghost_sprite.flip_h = frame_data["flip_h"]

func _physics_process(_delta: float) -> void:
	update_position()
	if position.x > loop_position_end.x:
		queue_free()

func update_position():
	count += 1
	if movement_data.has(count):
		var frame_data = movement_data[count]
		position = Vector2(frame_data["position_x"], frame_data["position_y"])
		if ghost_sprite:
			ghost_sprite.play(frame_data["animation"])
			ghost_sprite.flip_h = frame_data["flip_h"]
