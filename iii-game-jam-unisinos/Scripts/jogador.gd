extends CharacterBody2D


@export var SPEED = 150.0

@onready var sprite : Sprite2D = $Sprite2D
var current_objective : int


func _ready() -> void:
	change_objective()


func _physics_process(delta: float) -> void:
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


func get_objective() -> int:
	return current_objective


#Resorteia o objetivo atual quando chamado
func change_objective():
	current_objective = randi_range(1, 4)
	print("Valor sorteado: ", current_objective)
	var new_color : Color
	if current_objective == 1:
		new_color = Color.BLUE
	elif current_objective == 2:
		new_color = Color.RED
	elif current_objective == 3:
		new_color = Color.YELLOW
	elif current_objective == 4:
		new_color = Color.GREEN
	change_color(new_color)


func change_color(new_color : Color):
	sprite.modulate = new_color


#Teleporta o jogador até o ponto de respawn e muda o objetivo
func respawn(respawn_point: Marker2D):
	position = respawn_point.position
	change_objective()
