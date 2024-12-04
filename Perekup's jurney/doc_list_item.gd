extends Node

signal add_compare_value
signal move_doc

var check_mode

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_compare_type(event, type, item : Control):
	if check_mode :
		if event is InputEventMouseButton && event.is_pressed() :
			if event.button_index == MOUSE_BUTTON_LEFT:
				emit_signal("add_compare_value", BaseScript.PTS, type, item)
	else:
		if event is InputEventScreenDrag :	
			$PtsPanel.position += event.relative
			emit_signal("move_doc", BaseScript.PTS)


func _on_label_gui_input(event):
	if check_mode :
		if event is InputEventMouseButton && event.is_pressed() :
			if event.button_index == MOUSE_BUTTON_LEFT:
				emit_signal("add_compare_value", BaseScript.PTS, 1, $Label)
	else:
		if event is InputEventScreenDrag :	
			$PtsPanel.position += event.relative
			emit_signal("move_doc", BaseScript.PTS)
