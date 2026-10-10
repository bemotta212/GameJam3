extends CanvasLayer

@onready var timer: Timer = $Timer
@onready var timer_bar:  ProgressBar = $Control/Timer_bar
@onready var message: Label = $Control/Message
@onready var delivers_made : Label = $Control/Delivers_made

var level_completed: bool = false
signal game_lost


func _physics_process(delta: float) -> void:
	if !level_completed:
		timer_bar.value = timer.time_left
	else:
		timer_bar.value += 1


func _on_timer_timeout() -> void:
	message.text = "Game Over\nPressione R para recomeçar"
	game_lost.emit()


func on_level_completed() -> void:
	message.text = "Você Venceu!!!"
	level_completed = true
	timer.stop()


func _on_deviver_made(player_delivers_made : int) -> void:
	delivers_made.text = str(player_delivers_made) + " / 20"
