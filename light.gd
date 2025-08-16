extends MeshInstance2D

@export var channel: int = 1
@onready var player = get_node("../../Player")
@onready var game = get_node("../..")
@onready var light_sprite: AnimatedSprite2D = %LightSprite
var colours = [Color.BLUE, Color.RED, Color.PURPLE, Color.GREEN, Color.ORANGE, Color.YELLOW, Color.WHITE]

var is_button_on = false

func _ready() -> void:
	for x in $"..".get_children():
		if x.name.left(6) == "Button" and x.channel == channel:
			x.connect("signal_button_on", button_on)
			x.connect("signal_button_off", button_off)
	$Sprite2D.modulate = colours[channel-1]

func _process(delta: float) -> void:
	if is_button_on:
		$Sprite2D2.visible = false
	else:
		$Sprite2D2.visible = true

func button_on():
	is_button_on = true

func button_off():
	is_button_on = false
