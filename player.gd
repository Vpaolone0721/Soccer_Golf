extends CharacterBody3D

@onready var camera = $CameraPivot

var ball = null
var speed = 5

func entered(body): #grabs the object that enters our area
	ball = body

func kickball():
	ball.apply_impulse(Vector3(5, 5, 0))
	ball = null #we erase the variable since this needs to be true for the ball to stick to the player 
				# - by clearing it, we basically unstick the ball

func move():
	var input_dir = Vector3.ZERO #(0, 0, 0)
		
	if Input.is_action_pressed("foward"):
		input_dir.z -= 1 #(0, 0, -1)
	if Input.is_action_pressed("backward"):
		input_dir.z += 1 #(0, 0, 1)
	if Input.is_action_pressed("left"):
		input_dir.x -= 1 #(-1, 0, 0)
	if Input.is_action_pressed("right"):
		input_dir.x += 1 #(1, 0, 0)
			
	input_dir = input_dir.normalized() #this helps with normalising diagonal movement
	var direction = transform.basis * input_dir #this makes it so player movement stays the same even when we change rotation
			
	#input_dir is a vector 3 (0, 0, 0) so we accsess just the x and z values with input_dir.x/z	and add our input calculations
	# - it's good practice to calculate the vectors, then add them to the vector of what we want to move
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed


	move_and_slide()

func _physics_process(delta: float) -> void:
	move()
	if ball: #grabs the ball and sticks it to the player
		ball.global_position = ball.global_position.lerp($DribblePoint.global_position, 0.2)
	
	if ball and Input.is_action_just_pressed("kick"): #kicks the ball if the player is holding it
		kickball()
	
