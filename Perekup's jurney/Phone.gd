extends Node2D

const base_models = preload("res://base_script.gd")

signal add_compare_value
signal move_doc

var check_mode = false

@onready var phone_model = $PhonePanel/Model
@onready var phone_vin = $PhonePanel/VIN
@onready var phone_color = $PhonePanel/Color

# Called when the node enters the scene tree for the first time.
func _ready():
#	$PhonePanel.connect("_on_Phone_gui_input")
	pass # Replace with function body.

func set_data(model, vin, color):
	phone_model.text += " " + model
	phone_vin.text += " " + vin
	phone_color.text += " " + color
	
func set_data_dict(dict_phone):
	phone_model.text = "Марка: "
	phone_vin.text = "VIN: "
	phone_color.text = "Цвет кузова: "
#	phone_cost.text = "Цена: "
	
	phone_model.text += dict_phone[base_models.MODEL]
	phone_vin.text += dict_phone[base_models.VIN]
	phone_color.text += dict_phone[base_models.COLOR]
#	phone_cost.text += dict_phone["cost"]
	
func set_check_mode(mode : bool):
	check_mode = mode
	
func set_compare_type(event, type, item : Control):
	if check_mode :
		if event is InputEventMouseButton && event.is_pressed() :
			if event.button_index == MOUSE_BUTTON_LEFT:
				emit_signal("add_compare_value", base_models.PHONE, type, item)

func _on_Model_gui_input(event):
	set_compare_type(event, base_models.MODEL, phone_model)	

func _on_VIN_gui_input(event):
	set_compare_type(event, base_models.VIN, phone_vin)	

func _on_Color_gui_input(event):
	set_compare_type(event, base_models.COLOR, phone_color)	

func _on_Phone_gui_input(event : InputEvent):
	if !check_mode :
		if event.is_action_pressed("click") :
			$PhonePanel/PhoneShadow.set("visible", true)
			emit_signal("move_doc", base_models.PHONE)
		
		if event.is_action_released("click"):
			$PhonePanel/PhoneShadow.set("visible", false)
			
		if event is InputEventScreenDrag :
			$PhonePanel.position += event.relative
			emit_signal("move_doc", base_models.PHONE)
