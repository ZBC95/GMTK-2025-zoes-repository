extends CharacterBody2D

signal button_active(channel_sent)
signal dies()

@export var SPEED = 600.0
@export var JUMP_VELOCITY = 910.0
@export var gravity = 1500

enum PlayerState {
	IDLE,
	RUN,
	JUMP_UP,
	FALL,
	LAND,
	SKID,
	BLOCK,
	DEAD
}

var current_state: PlayerState = PlayerState.IDLE
var frame_counter: int = 0
var was_on_floor: bool = true
var previous_direction: float = 0.0
var is_blocking: bool = false
var lap_start_count = 0  # Track when current lap started
var count = 0
# A Dictionary to store our position
var movement_data = {}
var overlaps
var channel_to_emit: int = 0

@onready var loop = get_node("../Level/Looping_Componenet")
@onready var loop_position_start: Vector2 = Vector2(loop.bl_x*64, loop.bl_y*64)
@onready var loop_position_end: Vector2 = Vector2(loop.br_x*64, loop.br_y*64)
@onready var player_sprite: AnimatedSprite2D = %PlayerSprite
@onready var death_sound: AudioStreamPlayer = %DeathSound
@onready var loop_sound: AudioStreamPlayer = %LoopSound
@onready var nice_sound: AudioStreamPlayer = %NiceSound

func _physics_process(delta: float) -> void:
	
	check_overlaps()
	
	record_movement()
	 # If not dead
	if current_state != PlayerState.DEAD:
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
			# Set jump_up or fall animation based on vertical velocity
			if velocity.y < 0:
				current_state = PlayerState.JUMP_UP
			else:
				current_state = PlayerState.FALL

		# Handle jump.
		if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y = -JUMP_VELOCITY
			current_state = PlayerState.JUMP_UP

		# Handle blocking
		if Input.is_action_pressed("Down") and (is_on_floor() or overlaps.size() != 0):
			is_blocking = true
			current_state = PlayerState.BLOCK
			velocity.x = move_toward(velocity.x, 0, SPEED)
		elif Input.is_action_just_released("Down"):
			is_blocking = false
			current_state = PlayerState.IDLE
		
	# Only allow movement if not blocking
		if !is_blocking:
			var direction := Input.get_axis("Left", "Right")
			
			if direction:
				# Check for skid state
				if abs(velocity.x) > SPEED * 0.8 and sign(direction) != sign(previous_direction) and previous_direction != 0:
					current_state = PlayerState.SKID
					player_sprite.frame = 0  # Reset frame when entering skid state
				
				velocity.x = direction * SPEED
				if direction == -1:
					player_sprite.flip_h = true
				else:
					player_sprite.flip_h = false
					
				if current_state != PlayerState.SKID and is_on_floor():
					current_state = PlayerState.RUN
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				if current_state != PlayerState.LAND and is_on_floor() and !is_blocking:
					current_state = PlayerState.IDLE

		# Landing state check
		if is_on_floor() and !was_on_floor:
			current_state = PlayerState.LAND
			player_sprite.frame = 0  # Reset frame when landing


	elif current_state == PlayerState.DEAD:
		# Dead blob boys don't move
		velocity = Vector2.ZERO
	update_animation()
	
	was_on_floor = is_on_floor()
	previous_direction = sign(velocity.x)

	# Handle looping off screen right
	if position.x > loop_position_end.x:
		var lap_data = {}
		for i in range(lap_start_count, count + 1):
			if movement_data.has(i):
				lap_data[i - lap_start_count] = movement_data[i]
		
		SignalBus.player_looped.emit(lap_data)
		position.x = loop_position_start.x
		lap_start_count = count + 1

	move_and_slide()

func update_animation():
	match current_state:
		PlayerState.IDLE:
			player_sprite.play("idle")
		PlayerState.RUN:
			player_sprite.play("run")
		PlayerState.JUMP_UP:
			player_sprite.play("jump_up")
		PlayerState.FALL:
			player_sprite.play("fall")
		PlayerState.LAND:
			if player_sprite.animation != "land":
				player_sprite.play("land")
				player_sprite.frame = 0
			# Wait for animation to complete
			if player_sprite.frame >= player_sprite.sprite_frames.get_frame_count("land") - 1:
				current_state = PlayerState.IDLE
		PlayerState.SKID:
			if player_sprite.animation != "skid":
				player_sprite.play("skid")
				player_sprite.frame = 0
			# Wait for animation to complete
			if player_sprite.frame >= player_sprite.sprite_frames.get_frame_count("skid") - 1:
				current_state = PlayerState.RUN
		PlayerState.BLOCK:
			player_sprite.play("block")
		PlayerState.DEAD:
			player_sprite.play("die")


func record_movement():
	count += 1
	movement_data[count] = {
		"position_x": position.x,
		"position_y": position.y,
		"animation": player_sprite.animation,
		"flip_h": player_sprite.flip_h
	}

func check_overlaps():
	overlaps = get_node("Area2D").get_overlapping_areas()
	if overlaps.size() != 0:
		#print("")
		for ol in overlaps:
			if ol.get_parent().name.left(6) == "Button" and player_sprite.animation == "block":
				button_active.emit(ol.get_parent().channel)
			elif ol.get_parent().name.left(6) == "@Chara" or ol.get_parent().name.left(4) == "Door":
				die()

func die():
	dies.emit()
	death_sound.play()
	current_state = PlayerState.DEAD
	await get_tree().create_timer(0.875).timeout
	queue_free()
