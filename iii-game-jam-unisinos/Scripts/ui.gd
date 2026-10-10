extends CanvasLayer

@onready var timer: Timer = $Timer
@onready var timer_bar:  ProgressBar = $Control/Timer_bar
@onready var message: Label = $Control/Message

signal game_lost


func _physics_process(delta: float) -> void:
	timer_bar.value = timer.time_left


func _on_timer_timeout() -> void:
	message.text = "Game Over\nPressione R para recomeçar"
	game_lost.emit()


func on_game_won() -> void:
	message.text = "Você Venceu!!!"
	timer.stop()
	timer_bar.value = timer_bar.max_value
