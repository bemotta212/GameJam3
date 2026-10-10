extends CharacterBody2D


@export var SPEED = 150.0

@onready var sprite : Sprite2D = $Sprite2D
var current_door : int
@export var delivers : int = 20
var delivers_made : int = 0

var game_lost: bool = false
signal game_won


func _ready() -> void:
	change_objective()


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Restart") and game_lost:
		get_tree().reload_current_scene()
	
	if game_lost: 
		return
	#Move para os lados
	var direction_x := Input.get_axis("Move_left", "Move_right")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#Move para cima e para baixo
	var direction_y := Input.get_axis("Move_up", "Move_down")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func get_current_door() -> int:
	return current_door


#Resorteia o objetivo atual quando chamado
func change_objective():
	current_door = randi_range(1, 4)
	var new_color : Color
	if current_door == 1:
		new_color = Color.BLUE
	elif current_door == 2:
		new_color = Color.RED
	elif current_door == 3:
		new_color = Color.ORANGE
	elif current_door == 4:
		new_color = Color.GREEN
	change_color(new_color)


func change_color(new_color : Color):
	sprite.modulate = new_color


#Teleporta o jogador até o ponto de respawn e muda o objetivo
func respawn(respawn_point: Marker2D):
	delivers_made += 1
	if delivers_made >= delivers:
		emit_signal("game_won")
		return
	position = respawn_point.position
	change_objective()


func on_game_lost() -> void:
	game_lost = true
