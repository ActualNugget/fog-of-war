extends CharacterBody2D


const maxSPEED = 300.0
const ACCELERATION = 300.0
const DECELERATION = 400.0
const FACE_ACCELERATION = 5.0


#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * maxSPEED, ACCELERATION * delta)
		var face_vector = Vector2.from_angle(rotation + PI/2)
		rotation = face_vector.move_toward(velocity, FACE_ACCELERATION * delta).angle() - PI/2
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta)
	
	move_and_slide()
	
