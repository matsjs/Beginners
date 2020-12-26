extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 100
const FRICTION = 500

var velocity = Vector2.ZERO
var idle = "Idle right"


onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	player_animation()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta) 
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta) 
	
	velocity = move_and_slide(velocity)

func player_animation():
	if (Input.get_action_strength("ui_right") > 0):
		animationPlayer.play("Run right")
		idle = "Idle right"
	elif (Input.get_action_strength("ui_left") > 0):
		animationPlayer.play("Run left")
		idle = "Idle left"
	elif (Input.get_action_strength("ui_up") > 0):
		animationPlayer.play("Run up")
		idle = "Idle up"
	elif (Input.get_action_strength("ui_down") > 0):
		animationPlayer.play("Run down")
		idle = "Idle down"
	else:
		animationPlayer.play(idle)
