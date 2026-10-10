extends Area2D

@export var respawn_point : Marker2D
@export var color : Color = Color.WHITE

@onready var color_rect : ColorRect = $ColorRect

func _ready() -> void:
	color_rect.color = color

#Caso o jogador colida com a porta, teleporta ele pro respawn point
func on_player_entered(body: CharacterBody2D):
	if respawn_point and body.has_method("respawn"):
		body.respawn(respawn_point)
