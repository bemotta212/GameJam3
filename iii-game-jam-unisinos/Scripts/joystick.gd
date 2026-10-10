extends Node2D

@onready var area2d : Area2D = $Area2D
@onready var center : Marker2D = $Marker2D

@export var deadzone : float = 33

var is_holding : bool = false
var mouse_click : bool = false


func _physics_process(delta: float) -> void:
	if is_holding and mouse_click:	#Caso o jogador esteja mexemndo no joystick
		#Detecta em qual direção o jogador está segurando o joystick
		
		#Segurando para os lados
		var current_mouse_position = get_local_mouse_position()
		if current_mouse_position.x > center.position.x + deadzone / 2:
			Input.action_press("Move_right")
			Input.action_release("Move_left")
		elif current_mouse_position.x < center.position.x - deadzone / 2:
			Input.action_press("Move_left")
			Input.action_release("Move_right")
		else:
			Input.action_release("Move_right")
			Input.action_release("Move_left")
			
		#Segurando para cima e para baixo
		if current_mouse_position.y > center.position.y + deadzone / 2:
			Input.action_press("Move_down")
			Input.action_release("Move_up")
		elif current_mouse_position.y < center.position.y - deadzone / 2:
			Input.action_press("Move_up")
			Input.action_release("Move_down")
		else:
			Input.action_release("Move_up")
			Input.action_release("Move_down")
	else:
		Input.action_release("Move_up")
		Input.action_release("Move_down")
		Input.action_release("Move_right")
		Input.action_release("Move_left")


#Segurando o botão
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:	#Caso o input seja com o mouse
		if event.button_index == MOUSE_BUTTON_LEFT:	#Caso o Input seja o botão esquerdo do mouse
			if event.is_pressed():
				is_holding = true
			else:	#Caso o Input não esteja mais sendo pressionado
				is_holding = false
				mouse_click = false


func _on_player_move_joystick(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:	#Caso o input seja com o mouse
		if event.button_index == MOUSE_BUTTON_LEFT:	#Caso o Input seja o botão esquerdo do mouse
			if event.is_pressed():
				mouse_click = true
