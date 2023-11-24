extends Node2D

signal add_compare_value

@onready var current_level = $CarFront

const base_models = preload("res://base_script.gd")

var check_mode = false
var car_data : base_models.engine_class 
var m_dict_buy_car = {}

var level_stack = []

# Called when the node enters the scene tree for the first time.
func _ready():
	current_level.level_changed.connect(handle_level_changed)	
	level_stack.push_back("CarFront")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_data(engine : base_models.engine_class):
	car_data = engine
	
func set_data_dict(dict_buy_car):
	m_dict_buy_car = dict_buy_car	
	
func set_check_mode(mode : bool):
	check_mode = mode	
	
func set_compare_type(event, type_doc, type_item, control_item : Control):
	if check_mode :
		if event is InputEventMouseButton && event.is_pressed() :
			if event.button_index == MOUSE_BUTTON_LEFT:
				emit_signal("add_compare_value", type_doc, type_item, control_item)	
	
func handle_level_changed(current_level_name : String):
	level_stack.push_back(current_level_name)
	load_new_level(current_level_name)	

func handle_level_back():	
	level_stack.pop_back()
	var level_name = level_stack[level_stack.size() - 1]
	
	load_new_level(level_name)

func load_new_level(level_name : String):
	var next_level_resource = load("res://Cars/" + level_name + ".tscn")
	var next_level = next_level_resource.instantiate()
	add_child(next_level)
	
	next_level.set_data(m_dict_buy_car)
	
	next_level.level_changed.connect(handle_level_changed)
	next_level.level_back.connect(handle_level_back)
	next_level.add_compare_value.connect(set_compare_type)
	
	current_level.queue_free()
	current_level = next_level
