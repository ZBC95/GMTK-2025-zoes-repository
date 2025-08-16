extends StaticBody2D

signal signal_button_on
signal signal_button_off

@export var channel: int = 1
@onready var player = get_node("../../Player")
@onready var game = get_node("../..")  ###################
@onready var button_sprite: AnimatedSprite2D = %ButtonSprite

var is_button_on = false
var button_pressers = 0


func _process(delta: float) -> void:
	
	grow_shrink(delta)
	
	#---------------------------------
	#replaces grow_shrink()
	if is_button_on:
		button_sprite.play("on")
	elif not is_button_on:
		button_sprite.play("off")
	#---------------------------------


func grow_shrink(delta):
	if $Collision.scale.y > 0.5 and is_button_on:
		$Collision.scale.y -= delta*5
		$CollisionShape2D.scale.y -= delta*5
		$CollisionShape2D2.scale.y -= delta*5
		button_sprite.play("on")
	elif $Collision.scale.y < 1.0 and not is_button_on:
		$Collision.scale.y += delta*15
		$CollisionShape2D.scale.y += delta*15
		$CollisionShape2D2.scale.y += delta*15
		button_sprite.play("off")
		
		



func _on_pressed_area_area_entered(area: Area2D) -> void:
	button_pressers += 1
	if button_pressers == 1:
		is_button_on = true
		emit_signal("signal_button_on")


func _on_pressed_area_area_exited(area: Area2D) -> void:
	button_pressers -= 1
	if button_pressers == 0:
		is_button_on = false
		emit_signal("signal_button_off")
