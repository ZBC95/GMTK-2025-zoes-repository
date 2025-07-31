extends CharacterBody2D

var movement_data : Dictionary = Dictionary()
var count = -1
var is_static: bool = false

@onready var loop = get_node("../Level/Looping_Componenet")
@onready var loop_position_end: Vector2 = Vector2(loop.br_x*64, loop.br_y*64)
@onready var player = get_node("../Player")

func _ready() -> void:
	SignalBus.player_looped.connect(_on_player_looped)
	if movement_data.has(0):
		global_position = movement_data[0]

func _physics_process(_delta: float) -> void:
	update_position()
	if position.x > loop_position_end.x and is_static == false:
		position.x = 1000000

func update_position():
	count += 1
	if movement_data.has(count):
		global_position = movement_data[count]

func _on_player_looped(movement_data):
	get_node(".").count = -1
	
