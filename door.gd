extends StaticBody2D

@export var channel: int = 1
@onready var player = get_node("../../Player")
@onready var game = get_node("../..")
@onready var door_sprite: AnimatedSprite2D = %DoorSprite

var is_button_on = false
var is_door_open = false  # New latch variable

func _ready() -> void:
	player.button_active.connect(button_press)
	game.ghost_spawned.connect(new_ghost)
	# Ensure door starts in closed state
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)

func _process(_delta: float) -> void:
	if is_button_on and not is_door_open:
		door_sprite.play("clopen")
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
		is_door_open = true
	elif not is_button_on and is_door_open:
		door_sprite.play_backwards("clopen")
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
		is_door_open = false

func button_press(channel_sent):
	if channel_sent == channel:
		is_button_on = true

func new_ghost(sent_ghost):
	sent_ghost.button_active.connect(button_press)
