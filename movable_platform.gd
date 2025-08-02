extends AnimatableBody2D

# To add the second position add a marker2D node as a child of the moveable platform
# don't you dare think about renaming the marker though!

@export var channel: int = 1
var initial_position : Vector2
var second_position : Vector2
@onready var player = get_node("../../Player")
@onready var game = get_node("../..")

var is_button_on = false
var button_pressed = false

func _ready() -> void:
	initial_position = global_position
	second_position = find_child("Marker2D").global_position
	player.button_active.connect(button_press)
	game.ghost_spawned.connect(new_ghost)

func _process(delta: float) -> void:
	if is_button_on:
		global_position = second_position
		is_button_on = false
		if button_pressed:
			button_pressed = not button_pressed
	
	elif not is_button_on:
		global_position = initial_position
		if not button_pressed:
			button_pressed = not button_pressed
		

func button_press(channel_sent):
	if channel_sent == channel:
		is_button_on = true

func new_ghost(sent_ghost):
	sent_ghost.button_active.connect(button_press)
