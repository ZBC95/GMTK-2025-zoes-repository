extends Area2D

@onready var exit_pipe_sprite: AnimatedSprite2D = %ExitPipeSprite

func _ready() -> void:
	# Make sure animation is stopped when scene loads
	exit_pipe_sprite.stop()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):  # Only trigger for player
		if body.has_method("die"):
			body.die()
		exit_pipe_sprite.play("suck")

func _on_exit_pipe_sprite_animation_finished() -> void:
	SignalBus.level_completed.emit()
