extends MeshInstance2D

@export var channel: int = 1
@onready var player = get_node("../../Player")
@onready var game = get_node("../..")
@onready var light_sprite: AnimatedSprite2D = %LightSprite
var colours = [Color.BLUE, Color.RED, Color.PURPLE, Color.GREEN, Color.ORANGE, Color.YELLOW, Color.WHITE]

var is_button_on = false

func _ready() -> void:
	player.button_active.connect(button_press)
	game.ghost_spawned.connect(new_ghost)
	$Sprite2D.modulate = colours[channel-1]

func _process(delta: float) -> void:
	if is_button_on:
		
		is_button_on = false
		$Sprite2D2.visible = false

	else:
		pass
		$Sprite2D2.visible = true

func button_press(channel_sent):
	if channel_sent == channel:
		is_button_on = true

func new_ghost(sent_ghost):
	sent_ghost.button_active.connect(button_press)
