extends Node2D

signal level_changed(level_name)
signal level_back()
signal add_compare_value

@onready var engine_volume = $Panel/Volume
@onready var engine_number = $Panel/Number

const base_models = preload("res://base_script.gd")
var m_dict_buy_car

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_data(dict_buy_car):
	m_dict_buy_car = dict_buy_car
	var dict_engine_plate = m_dict_buy_car[base_models.ENGINE_PLATE]
	engine_volume.text = dict_engine_plate[base_models.VOLUME]
	engine_number.text = dict_engine_plate[base_models.ENGINE_NUMBER]
	
	engine_volume.connect("gui_input", _on_volume_gui_input.bind("13456"))
#	engine_volume.gui_input.connect(_on_volume_gui_input, "kek")

func _on_button_gui_input(event):
	if event.is_pressed() :	
		emit_signal("level_back")	

func _on_volume_gui_input(event, test):
	emit_signal("add_compare_value", event, base_models.ENGINE_PLATE, base_models.VOLUME, engine_volume)

func _on_label_gui_input(event):
#	emit_signal("add_compare_value", event, base_models.ENGINE_PLATE, base_models.VOLUME, $Panel/Volume)
	pass


func _on_number_gui_input(event):
	emit_signal("add_compare_value", event, base_models.ENGINE_PLATE, base_models.ENGINE_NUMBER, engine_number)
