extends CharacterBody3D

@onready var CameraNode = $CameraPivot
@onready var SpringArm = $CameraPivot/SpringArm3D
@onready var Camera = $CameraPivot/SpringArm3D/Camera3D

var ball = null
var power = 10

func entered(body): # grabs the object that enters our area and assigns it to a variable
	ball = body
func kickball():
	var camera_direction = -Camera.global_transform.basis.z #this grabs the direction our camera is facing (basis - apart of transfomr)
	var final_power = power + velocity.length()
	# this factors how fast we are moving for the shot. velocity.length tells us how fast were going regardless of direction
	# so we take power + speed and get force!
	
	ball.apply_impulse(camera_direction * final_power + Vector3(0, 5, 0))
	# apply impulse takes in a vector for velocity and a optional vector for where the impulse is applied
	# in this instance, camera direction hols the foward facing position of the camera
	# so we take the foward facing postion of the camera and multiply that by power
	# and that gives us our directional shot!
	
	ball = null # we erase the variable since this needs to be true for the ball to stick to the player 
				# - by clearing it, we basically unstick the ball allowing us to kick it
func move():
	var speed = 5
	var target_speed = speed
	
	var input_dir = Vector3.ZERO #(0, 0, 0)
		
	if Input.is_action_pressed("foward"):
		input_dir.z -= 1 #(0, 0, -1)
	if Input.is_action_pressed("backward"):
		input_dir.z += 1 #(0, 0, 1)
	if Input.is_action_pressed("left"):
		input_dir.x -= 1 #(-1, 0, 0)
	if Input.is_action_pressed("right"):
		input_dir.x += 1 #(1, 0, 0)
	if Input.is_action_pressed("sprint"): 
		target_speed = speed * 2
	if input_dir == Vector3.ZERO: #resets our speed so we are not always sprinting
		target_speed = 0

			
	input_dir = input_dir.normalized() #this helps with normalising diagonal movement
	var direction = transform.basis * input_dir #this makes it so player movement stays the same even when we change rotation
	var target_velocity = direction * target_speed #used for our overall movement
	#input_dir is a vector 3 (0, 0, 0) so we accsess just the x and z values with input_dir.x/z	and add our input calculations
	# - it's good practice to calculate the vectors, then add them to the vector of what we want to move
	velocity.x = move_toward(velocity.x, target_velocity.x, 0.5)
	velocity.z = move_toward(velocity.z, target_velocity.z, 0.5)
	# i learned that move_toward can be used for all movement - cool beans
	
	move_and_slide()
func _input(event): #MOUSE CONTROLS
	if event.is_action_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) # lets you escape the centered mouse
		
	if event.is_action_pressed("center"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # lets you escape the centered mouse
	
	if event is InputEventMouseMotion: #checks if the event captured from the function is mouse motion
		rotate_y(-event.relative.x * 0.002) #rotates the character body (like rotating irl) - ROTATES THE ACTUAL CHARACTER (brings caamera with is
		CameraNode.rotate_x(-event.relative.y * 0.002) #rotates the camera head up and down 
		# The goal for a ORBIT like affect is to keep the camera still and rotate everything else. 
		# Here we orbit the node up and down which brings the spring arm and camera with it - it creates the intended affect
		# because if moving just the spring arm, then it just rotates up and down, not oribitng up and down
		
		# stops the camera from moving past certain limits
		CameraNode.rotation.x = clamp(CameraNode.rotation.x, deg_to_rad(-70), deg_to_rad(20)) #controls the pitch - the up and down
func _physics_process(delta: float) -> void:
	move()
	if ball: #grabs the ball and sticks it to the player
		ball.global_position = ball.global_position.lerp($DribblePoint.global_position, 0.2)
	
	if ball and Input.is_action_just_pressed("kick"): #kicks the ball if the player is holding it
		kickball()
	
