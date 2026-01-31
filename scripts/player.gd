extends CharacterBody2D


const maxSPEED = 300.0
const ACCELERATION = 300.0
const DECELERATION = 400.0
const FACE_ACCELERATION = 5.0

const CANNONBALL = preload("res://scenes/cannonball.tscn")

func _process(delta):
	if Input.is_action_just_pressed("fire"):
		fire_cannonball()

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * maxSPEED, ACCELERATION * delta)
		var face_vector = Vector2.from_angle(rotation + PI/2)
		rotation = face_vector.move_toward(velocity, FACE_ACCELERATION * delta).angle() - PI/2
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta)
	
	move_and_slide()
	
func fire_cannonball():
	var cannonball_instance = CANNONBALL.instantiate()
	get_tree().root.add_child(cannonball_instance)
	cannonball_instance.global_position = position
	cannonball_instance.look_at(get_global_mouse_position())
	
