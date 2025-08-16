extends Area2D

var collected = false
var count = 0
var when_collected: int

func _ready() -> void:
	SignalBus.player_looped.connect(_on_player_looped)

func _process(delta: float) -> void:
	#print(count)
	count += 1
	if count == when_collected:
		$Sprite2D.visible = false
		
	
func _on_player_looped(movement_data):
	#print("player looped")
	count = 0
	$Sprite2D.visible = true
	
	


func _on_area_entered(area: Area2D) -> void:
	if collected == false:
		collected = true
		$Sprite2D.modulate.a = 0.4
		$Sprite2D.visible = false
		when_collected = count
