extends Node2D

@export var mark_circle: PackedScene

signal level_changed(level_name)
signal level_back()
signal add_compare_value

const base_models = preload("res://base_script.gd")
var m_dict_buy_car

var char_tex = load("res://Sprites/1/1.jpg") 

# Called when the node enters the scene tree for the first time.
func _ready():
	load_new_view()
	
	$VinCircle.caption = "Табличка VIN"
	pass # Replace with function body.
	
func set_data(dict_buy_car):
	m_dict_buy_car = dict_buy_car	
	
func load_new_view():
	var circle = mark_circle.instantiate()
	circle.position.x = 210
	circle.position.y = 170
	circle.scale = Vector2(0.5, 0.5)
	circle.caption = "Подкапотное пространство"
	circle.input_event.connect(_on_Area2D_input_event)
	add_child(circle)
#	set_process_input(true)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_pressed() :
#		$Sprite.texture = load("res://Sprites/1/6.jpg")
		get_tree().call_group("circles", "queue_free")
		Input.set_default_cursor_shape(0)		
		
		emit_signal("level_changed", "CarUnderHood")	

func _on_vin_circle_input_event(viewport, event, shape_idx):
	if event.is_pressed() :
		get_tree().call_group("circles", "queue_free")
		Input.set_default_cursor_shape(0)		
		
		emit_signal("level_changed", "VinPlate")

func _on_door_input_event(viewport, event, shape_idx):
	if event.is_pressed() :
#		$Sprite.texture = load("res://Sprites/1/6.jpg")
		get_tree().call_group("circles", "queue_free")
		Input.set_default_cursor_shape(0)		
		
		emit_signal("level_changed", "CarInterior")	
