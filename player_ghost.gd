extends CharacterBody2D

var movement_data : Dictionary = Dictionary()
var count = -1
@onready var loop = get_node("../Level/Looping_Componenet")
@onready var loop_position_end: Vector2 = Vector2(loop.br_x*64, loop.br_y*64)

func _ready() -> void:
	print(get_node(".."))
	if movement_data.has(0):
		global_position = movement_data[0]

func _physics_process(_delta: float) -> void:
	update_position()
	if position.x > loop_position_end.x:
		queue_free()

func update_position():
	count += 1
	if movement_data.has(count):
		global_position = movement_data[count]
