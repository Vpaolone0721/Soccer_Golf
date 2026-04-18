extends Node3D

var ball = null

func ball_entered_goal(body): # grabs the object that enters our area and assigns it to a variable
	ball = body

func test():
	print(ball.name)
	ball = null
	GameManager.goal_scored.emit() #emits a singal that other scenes can use if they connect it
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if ball:
		test()
	pass
