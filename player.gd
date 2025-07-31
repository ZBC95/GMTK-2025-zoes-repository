extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = 600.0
@export var gravity = 1000

@onready var loop = get_node("../Level/Looping_Componenet")
@onready var loop_position_start: Vector2 = Vector2(loop.bl_x*64, loop.bl_y*64)
@onready var loop_position_end: Vector2 = Vector2(loop.br_x*64, loop.br_y*64)
@onready var player_sprite: AnimatedSprite2D = %PlayerSprite


var count = 0

# A Dictionary to store our position
var movement_data = {}

func _ready():
	
	#Ititial position
	movement_data[0] = {
		"position_x": position.x,
		"position_y": position.y,
		"animation": player_sprite.animation,
		"flip_h": player_sprite.flip_h
	}

var lap_start_count = 0  # Track when current lap started

func _physics_process(delta: float) -> void:
	record_movement()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y = -JUMP_VELOCITY
	
	# Handle looping off screen right
	if position.x > loop_position_end.x:
		# Create dictionary with just this lap's movement data
		var lap_data = {}
		for i in range(lap_start_count, count + 1):
			if movement_data.has(i):
				lap_data[i - lap_start_count] = movement_data[i]
				
		SignalBus.player_looped.emit(lap_data)
		position.x = loop_position_start.x
		lap_start_count = count + 1  # Start counting new lap from here
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		player_sprite.play("run")
		velocity.x = direction * SPEED
		if direction == -1:
			player_sprite.flip_h = true
		else:
			player_sprite.flip_h = false
	else:
		player_sprite.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func record_movement():
	count += 1
	movement_data[count] = {
		"position_x": position.x,
		"position_y": position.y,
		"animation": player_sprite.animation,
		"flip_h": player_sprite.flip_h
	}
