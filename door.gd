extends StaticBody2D

@export var channel: int = 1
@onready var player = get_node("../../Player")
@onready var game = get_node("../..")
@onready var start_pos = position
var is_button_on = false

func _ready() -> void:
	player.button_active.connect(button_press)
	game.ghost_spawned.connect(new_ghost)

func _process(delta: float) -> void:
	if is_button_on:
		#print("door open")
		position.x = 100000
		is_button_on = false
	else:
		#print("door closed")
		position.x = start_pos.x
			

func button_press(channel_sent):
	if channel_sent == channel:
		is_button_on = true

func new_ghost(sent_ghost):
	sent_ghost.button_active.connect(button_press)
