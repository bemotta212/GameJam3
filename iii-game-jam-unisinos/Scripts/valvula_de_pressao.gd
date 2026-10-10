extends Node2D

@onready var sprite: Sprite2D = $Valvula_de_pressao/Sprite

var is_dragging : bool = false
var mouse_click : bool = false

var last_rotation_degrees : float
signal valve_rotated(rotation_degrees: float)

#Segurado fora da área
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:	#Caso o input seja com o mouse
		if event.button_index == MOUSE_BUTTON_LEFT:	#Caso o Input seja o botão esquerdo do mouse
			if event.is_pressed():
				print("pressionado")
				is_dragging = true
			else:	#Caso o Input não esteja mais sendo pressionado
				is_dragging = false
				mouse_click = false
				
	#Quando o jogador girar a válvula
	if is_dragging == true and mouse_click == true:
		sprite.look_at(get_global_mouse_position())
		#Quanto que o jogador rodou a válvula
		var rotation_change = sprite.global_rotation_degrees - last_rotation_degrees
		#Impede o jogador de rodar a válvula ao contrário
		if rotation_change < 0:
			rotation_change = 0
		print(rotation_change)
		#Atualiza o valor e envia o sinal de rotação
		last_rotation_degrees = sprite.global_rotation_degrees
		valve_rotated.emit(rotation_change)

#Pressionado dentro da área
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:	#Caso o input seja com o mouse
		if event.button_index == MOUSE_BUTTON_LEFT:	#Caso o Input seja o botão esquerdo do mouse
			if event.is_pressed():
				print("pressionado na area")
				mouse_click = true
