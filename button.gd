extends StaticBody2D

@export var channel: int = 1
@onready var player = get_node("../../Player")
@onready var game = get_node("../..")  ###################
var is_button_on = false

func _ready() -> void:
	player.button_active.connect(button_press)
	game.ghost_spawned.connect(new_ghost)
	
func _process(delta: float) -> void:
	
	grow_shrink(delta)
	
	if is_button_on:
		is_button_on = false


func grow_shrink(delta):

	if $Collision.scale.y > 0.5 and is_button_on:
		#print("shrinking")
		#print($Collision.scale.y)
		#print(is_button_on)
		$Collision.scale.y -= delta*2
		$CollisionShape2D.scale.y -= delta*2
		$CollisionShape2D2.scale.y -= delta*2
	elif $Collision.scale.y < 1.0 and not is_button_on:
		#print("growing")
		#print($Collision.scale.y)
		#print(is_button_on)
		$Collision.scale.y += delta*15
		$CollisionShape2D.scale.y += delta*15
		$CollisionShape2D2.scale.y += delta*15
		
		

func button_press(channel_sent):
	if channel_sent == channel:
		is_button_on = true

func new_ghost(sent_ghost):
	sent_ghost.button_active.connect(button_press)
