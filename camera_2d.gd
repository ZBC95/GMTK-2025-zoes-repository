extends Camera2D

@onready var player = get_node("../Player")
@onready var loop = get_node("../Level/Looping_Componenet")

func _ready() -> void:
	limit_left = loop.bl_x*64
	limit_top = loop.tl_y*64
	limit_bottom = loop.bl_y*64
