extends Control
@onready var main_page = $"Panel/Main Screen"
@onready var controls_page = $"Panel/Controls Screen"
@onready var levels_page = $"Panel/Levels"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	controls_page.visible = false
	controls_page.mouse_filter = Control.MOUSE_FILTER_IGNORE
	levels_page.visible = false
	levels_page.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_play_pressed() -> void:
	main_page.visible = false
	levels_page.visible = true
	levels_page.mouse_filter = Control.MOUSE_FILTER_STOP
	main_page.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func _on_controls_pressed() -> void:
	main_page.visible = false
	controls_page.visible = true
	main_page.mouse_filter = Control.MOUSE_FILTER_STOP
	controls_page.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func _on_back_pressed() -> void:
	main_page.visible = true
	controls_page.visible = false
	main_page.mouse_filter = Control.MOUSE_FILTER_STOP
	controls_page.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func _on_back_levels_pressed() -> void:
	main_page.visible = true
	levels_page.visible = false
	main_page.mouse_filter = Control.MOUSE_FILTER_STOP
	levels_page.mouse_filter = Control.MOUSE_FILTER_IGNORE

func level_1() -> void:
	get_tree().change_scene_to_file("res://level_1.tscn")
	
func level_2() -> void:
	get_tree().change_scene_to_file("res://level_2.tscn")
	
func level_3() -> void:
	get_tree().change_scene_to_file("res://level_3.tscn")


#get_tree().change_scene_to_file("res://level_3.tscn")
