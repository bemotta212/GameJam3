extends Node2D

@onready var valve_sprite: Sprite2D = $Valvula_de_pressao/Sprite
@onready var pointer_sprite: Sprite2D = $Ponteiro

@export_group("Ponteiro")
@export var pointer_min_rotation : float = -192.0
@export var pointer_max_rotation : float = 80.5

var is_dragging : bool = false
var mouse_click : bool = false

var last_rotation_degrees : float
signal valve_rotated(rotation_degrees: float)


#Segurado fora da área
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:	#Caso o input seja com o mouse
		if event.button_index == MOUSE_BUTTON_LEFT:	#Caso o Input seja o botão esquerdo do mouse
			if event.is_pressed():
				is_dragging = true
			else:	#Caso o Input não esteja mais sendo pressionado
				is_dragging = false
				mouse_click = false
				
	#Quando o jogador girar a válvula
	if is_dragging == true and mouse_click == true:
		valve_sprite.look_at(get_global_mouse_position())
		#Quanto que o jogador rodou a válvula
		var rotation_change = valve_sprite.global_rotation_degrees - last_rotation_degrees
		#Impede o jogador de rodar a válvula ao contrário
		if rotation_change < 0:
			rotation_change = 0
		#Atualiza o valor e envia o sinal de rotação
		last_rotation_degrees = valve_sprite.global_rotation_degrees
		valve_rotated.emit(rotation_change)


#Pressionado dentro da área
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:	#Caso o input seja com o mouse
		if event.button_index == MOUSE_BUTTON_LEFT:	#Caso o Input seja o botão esquerdo do mouse
			if event.is_pressed():
				mouse_click = true


#Muda a rotação do ponteiro sempre que a velocidade do jogador mudar
func on_player_speed_change(player_current_speed : float, player_max_speed : float, player_min_speed : float):
	#Intervalo entre os valores máximos e mínimos da velocidade do jogador e da rotação do ponteiro
	var player_speed_range = player_max_speed - player_min_speed
	var pointer_rotation_range = pointer_max_rotation - pointer_min_rotation
	#Quantas unidades a velocidade do jogador são um grau de rotação do ponteiro
	var speed_to_degrees = pointer_rotation_range / player_speed_range
	
	#A velocidade do jogador é mostrada na rotação do ponteiro
	var player_absolute_speed = player_current_speed - player_min_speed
	pointer_sprite.global_rotation_degrees = pointer_min_rotation + player_absolute_speed * speed_to_degrees
