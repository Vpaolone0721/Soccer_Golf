extends MarginContainer

@onready var GoalText = $CenterContainer/GoalText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.goal_scored.connect(GOAL)
	GoalText.visible_characters = 0

func GOAL():
	GoalText.visible_characters = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
