extends Control

var t: int = 0
var rng = RandomNumberGenerator.new()
var died = false

@onready var game = $"../.."
@onready var player = $"../../Player"

var speech_tutorial: Array = [
	"res://assets/speech_tutorial/professor_mcloop_speech3.png",
	"res://assets/speech_tutorial/professor_mcloop_speech1.png",
	"res://assets/speech_tutorial/professor_mcloop_speech5.png",
	"res://assets/speech_tutorial/professor_mcloop_speech.png"
]
var speech_joke: Array = [
	"res://assets/speech_joke/professor_mcloop_speech4.png",
	"res://assets/speech_joke/professor_mcloop_speech6.png"
]

var speech_reset = "res://assets/speech_other/professor_mcloop_speech2.png"

func _ready() -> void:
	player.dies.connect(player_died)
	var my_random_number = rng.randf_range(-10.0, 10.0)
	$AnimatedSprite2D.play("default")
	if Global.cur_level < 4:
		if Global.speech_tutorial_num < speech_tutorial.size():
			$Marker2D/speech.texture = load(speech_tutorial[Global.speech_tutorial_num])
		else:
			Global.speech_tutorial_num = 0
			$Marker2D/speech.texture = load(speech_tutorial[Global.speech_tutorial_num])
	else:
		if Global.speech_level_count < 5:
			$AnimatedSprite2D.visible = false
			Global.speech_level_count += 1
		elif Global.speech_level_count < 10 and my_random_number > 0.0:
			$AnimatedSprite2D.visible = false
			Global.speech_level_count += 1
		else:
			Global.speech_level_count = 0
			if Global.speech_joke_num < speech_joke.size():
				$Marker2D/speech.texture = load(speech_joke[Global.speech_joke_num])
			else:
				Global.speech_joke_num = 0
				$Marker2D/speech.texture = load(speech_joke[Global.speech_joke_num])

func _process(delta: float) -> void:
	
	if not game.is_paused:
		$AnimatedSprite2D.play("default")
		t+=1
		if t == 300:
			$AnimatedSprite2D.visible = false
			$Marker2D.visible = false
		if t == 3600:
			$AnimatedSprite2D.visible = true
			$Marker2D.visible = true
			$Marker2D/speech.texture = load(speech_reset)
		if died:
			$AnimatedSprite2D.visible = true
			$Marker2D.visible = true
			$Marker2D/speech.texture = load(speech_reset)
	else:
		$AnimatedSprite2D.pause()

func player_died():
	died = true
