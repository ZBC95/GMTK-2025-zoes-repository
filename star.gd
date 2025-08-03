extends Area2D

var overlaps
var collected = false
var count = 0
var when_collected: int

func _ready() -> void:
	SignalBus.player_looped.connect(_on_player_looped)

func _process(delta: float) -> void:
	print(count)
	count += 1
	var overlaps = get_overlapping_areas()
	if overlaps.size() != 0 and collected == false:
		collected = true
		#$Sprite2D.modulate = Color("BLUE")
		$Sprite2D.modulate.a = 0.4
		$Sprite2D.visible = false
		when_collected = count
	elif count == when_collected:
		$Sprite2D.visible = false
		
	
func _on_player_looped(movement_data):
	print("player looped")
	count = 0
	$Sprite2D.visible = true
