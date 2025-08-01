extends Camera2D

@onready var player = get_node("../Player")
@onready var loop = get_node("../Level/Looping_Componenet")

func _ready() -> void:
	SignalBus.player_looped.connect(_on_player_looped)
	limit_left = loop.bl_x*64
	position_camera()



func _physics_process(delta: float) -> void:
	if player != null:
		position_camera()


func _on_player_looped(movement_data):
	limit_left = -1000000

func position_camera():
	if get_viewport_rect().size.y < loop.bl_y*64 - loop.tl_y*64:
		limit_top = loop.tl_y*64
		limit_bottom = loop.bl_y*64
		position = player.position
	else:
		position.y = (loop.bl_y*64 + loop.tl_y*64)/2
		position.x = player.position.x
