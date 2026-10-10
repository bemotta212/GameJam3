extends Node2D

@onready var button_up : Area2D = $Up
@onready var button_down : Area2D = $Down
@onready var button_left : Area2D = $Left
@onready var button_right : Area2D = $Right

var is_holding : bool = false
var mouse_click : bool = false


#Segurando o botão
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:	#Caso o input seja com o mouse
		if event.button_index == MOUSE_BUTTON_LEFT:	#Caso o Input seja o botão esquerdo do mouse
			if event.is_pressed():
				is_holding = true
			else:	#Caso o Input não esteja mais sendo pressionado
				Input.action_release("Move_up")
				Input.action_release("Move_down")
				Input.action_release("Move_left")
				Input.action_release("Move_right")
				is_holding = false
				mouse_click = false


func _on_button_up_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:	#Caso o input seja com o mouse
		if event.button_index == MOUSE_BUTTON_LEFT:	#Caso o Input seja o botão esquerdo do mouse
			if event.is_pressed():
				Input.action_press("Move_up")


func _on_button_down_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:	#Caso o input seja com o mouse
		if event.button_index == MOUSE_BUTTON_LEFT:	#Caso o Input seja o botão esquerdo do mouse
			if event.is_pressed():
				Input.action_press("Move_down")


func _on_button_left_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:	#Caso o input seja com o mouse
		if event.button_index == MOUSE_BUTTON_LEFT:	#Caso o Input seja o botão esquerdo do mouse
			if event.is_pressed():
				Input.action_press("Move_left")


func _on_button_right_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:	#Caso o input seja com o mouse
		if event.button_index == MOUSE_BUTTON_LEFT:	#Caso o Input seja o botão esquerdo do mouse
			if event.is_pressed():
				Input.action_press("Move_right")
