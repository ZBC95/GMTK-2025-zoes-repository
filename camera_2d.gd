extends Camera2D

@onready var player = get_node("../Player")
@onready var loop = get_node("../Level/Looping_Componenet")

func _ready() -> void:
	SignalBus.player_looped.connect(_on_player_looped)
	limit_left = loop.bl_x*64
	limit_top = loop.tl_y*64
	limit_bottom = loop.bl_y*64


func _physics_process(delta: float) -> void:
	position = player.position

func _on_player_looped(movement_data):
	limit_left = -1000000
