extends Node2D

signal level_changed(level_name)
signal level_back()
signal add_compare_value

@onready var plate_model = $Panel/Model
@onready var plate_vin = $Panel/VIN
@onready var plate_color = $Panel/Color

const base_models = preload("res://base_script.gd")
var m_dict_buy_car

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_data(dict_buy_car):
	plate_model.text 
	
	m_dict_buy_car = dict_buy_car
	var dict_engine_plate = m_dict_buy_car[base_models.VIN_PLATE]
	plate_model.text = dict_engine_plate[base_models.MODEL]
	plate_vin.text = "VIN: " + dict_engine_plate[base_models.VIN]
	plate_color.text = dict_engine_plate[base_models.COLOR]


func _on_model_gui_input(event):
	emit_signal("add_compare_value", event, base_models.VIN_PLATE, base_models.MODEL, plate_model)


func _on_vin_gui_input(event):
	emit_signal("add_compare_value", event, base_models.VIN_PLATE, base_models.VIN, plate_vin)

func _on_color_gui_input(event):
	emit_signal("add_compare_value", event, base_models.VIN_PLATE, base_models.COLOR, plate_color)

func _on_button_gui_input(event):
	if event.is_pressed() :	
		emit_signal("level_back")	
