extends Node2D

var base_models = preload("res://base_script.gd")

signal add_compare_value
signal move_doc

var check_mode = false

@onready var pts_model = $PtsPanel/Model
@onready var pts_vin = $PtsPanel/VIN
@onready var pts_color = $PtsPanel/Color
@onready var pts_volume = $PtsPanel/Volume
@onready var pts_number = $PtsPanel/Number

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_data(model : String, vin : String, color : String, volume : String, number : String):
	pts_model.text += " " + model
	pts_vin.text += " " + vin
	pts_color.text += " " + color
	pts_volume.text += " " + volume
	pts_number.text += " " + number
	pass
	
func set_data_dict(dict_advert):
	pts_model.text = "Марка: "
	pts_vin.text = "VIN: "
	pts_color.text = "Цвет кузова: "
	pts_volume.text = "Объём двигателя: "
	pts_number.text = "Номер двигателя: "
	
	pts_model.text += dict_advert[base_models.MODEL]
	pts_vin.text += dict_advert[base_models.VIN]
	pts_color.text += dict_advert[base_models.COLOR]
	pts_volume.text += dict_advert[base_models.VOLUME]
	pts_number.text += dict_advert[base_models.ENGINE_NUMBER]

func set_check_mode(mode : bool):
	check_mode = mode
	
func set_compare_type(event, type, item : Control):
	if check_mode :
		if event is InputEventMouseButton && event.is_pressed() :
			if event.button_index == MOUSE_BUTTON_LEFT:
				emit_signal("add_compare_value", base_models.PTS, type, item)
	else:
		if event is InputEventScreenDrag :	
			$PtsPanel.position += event.relative
			emit_signal("move_doc", base_models.PTS)

func _on_Model_gui_input(event):		
	set_compare_type(event, base_models.MODEL, pts_model)	

func _on_VIN_gui_input(event):
	set_compare_type(event, base_models.VIN, pts_vin)	

func _on_Color_gui_input(event):
	set_compare_type(event, base_models.COLOR, pts_color)	

func _on_volume_gui_input(event):
	set_compare_type(event, base_models.VOLUME, pts_volume)	

func _on_number_gui_input(event):
	set_compare_type(event, base_models.ENGINE_NUMBER, pts_number)	

func _on_Pts_gui_input(event):
	if !check_mode :
		if event.is_action_pressed("click") :
			$PtsPanel/Shadow.set("visible", true)
			emit_signal("move_doc", base_models.PTS)
		
		if event.is_action_released("click"):
			$PtsPanel/Shadow.set("visible", false)
			
		if event is InputEventScreenDrag :
		
#			var xxx = $PtsPanel.position[0]
#			var yyy = $PtsPanel.position[1]
#
#			var rrrx = event.relative[0]
#			var rrry = event.relative[1]
#
#			if xxx + rrrx < -$PtsPanel.size.x/2 :
#				return
				
#			if $PtsPanel.position.x > 100 && $PtsPanel.position.x < 1000:				
			
			$PtsPanel.position += event.relative
			emit_signal("move_doc", base_models.PTS)
