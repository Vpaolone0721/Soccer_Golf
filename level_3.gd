extends Node3D
@onready var right_wall = $right_wall
@onready var left_wall = $left_wall
@onready var middle_wall = $middle_wall

func move_middle_wall():
	var tween = create_tween().set_loops()
	
	#tween.tween_property(object, "property", target_value, duration)
	# object: what we want to tween
	# property: like shape, position, size, etc.
	# target_value: 
	tween.tween_property(middle_wall, "size:y", 5.0, 1.0)
	tween.tween_property(middle_wall, "size:y", 1.0, 1.0)
func move_walls():
	var right_tween = create_tween().set_loops()
	var left_tween = create_tween().set_loops()
	
	var right_start = right_wall.position.x
	var left_start = left_wall.position.x
	
	right_tween.tween_property(right_wall, "position:x", right_start -3.0, 1.0)
	right_tween.tween_property(right_wall, "position:x", right_start, 1.0)
	
	left_tween.tween_property(left_wall, "position:x", left_start + 3.0, 1.0)
	left_tween.tween_property(left_wall, "position:x", left_start, 1.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_middle_wall()
	move_walls()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
