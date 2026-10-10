extends CharacterBody2D


@export var SPEED = 150.0


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

func choose_door():
	
