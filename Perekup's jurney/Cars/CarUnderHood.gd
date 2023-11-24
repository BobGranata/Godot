extends Node2D

signal level_changed(level_name)
signal level_back()
signal add_compare_value

const base_models = preload("res://base_script.gd")
var m_dict_buy_car

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarkCircle.caption = "Плашка двигателя"
#	var mark_circle = load("res://MarkCircle.tscn")
#	var circle = mark_circle.instantiate()
#	circle.position.x = 210
#	circle.position.y = 170
#	circle.scale = Vector2(0.5, 0.5)
#	circle.input_event.connect(_on_mark_circle_input_event)
##	var ddd = circle.Area2D
#	add_child(circle)
#	set_process_input(true)	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_data(dict_buy_car):
	m_dict_buy_car = dict_buy_car

func _on_mark_circle_input_event(viewport, event, shape_idx):
	if event.is_pressed() :
#		$Sprite.texture = load("res://Sprites/1/6.jpg")
		get_tree().call_group("circles", "queue_free")
		Input.set_default_cursor_shape(0)		
		
		emit_signal("level_changed", "EnginePlate")	

func _on_button_gui_input(event):
	if event.is_pressed() :	
		emit_signal("level_back")	
