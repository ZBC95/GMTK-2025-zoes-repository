extends StaticBody2D

@export var channel: int = 1
@onready var player = get_node("../../Player")
@onready var game = get_node("../..")
@onready var door_sprite: AnimatedSprite2D = %DoorSprite

var is_button_on = false
var is_door_open = true  # New latch variable

func _ready() -> void:
	for x in $"..".get_children():
		if x.name.left(6) == "Button" and x.channel == channel:
			x.connect("signal_button_on", button_on)
			x.connect("signal_button_off", button_off)
	# Ensure door starts in closed state
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)

func _process(_delta: float) -> void:
	if is_button_on:
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
		if is_door_open:
			door_sprite.play("clopen")
			is_door_open = not is_door_open
	elif not is_button_on:
		
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
		if not is_door_open:
			door_sprite.play_backwards("clopen")
			is_door_open = not is_door_open


func button_on():
	is_button_on = true

func button_off():
	is_button_on = false
