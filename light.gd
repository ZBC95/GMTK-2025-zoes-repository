extends MeshInstance2D

@export var channel: int = 1
@onready var player = get_node("../../Player")
@onready var game = get_node("../..")
@onready var light_sprite: AnimatedSprite2D = %LightSprite

var is_button_on = false

func _ready() -> void:
	player.button_active.connect(button_press)
	game.ghost_spawned.connect(new_ghost)

func _process(delta: float) -> void:
	if is_button_on:
		is_button_on = false

		modulate = Color(0, 1, 0, 1)
		light_sprite.play("red")

	else:

		modulate = Color(1, 0, 0, 1)
		light_sprite.play("green")

func button_press(channel_sent):
	if channel_sent == channel:
		is_button_on = true

func new_ghost(sent_ghost):
	sent_ghost.button_active.connect(button_press)
