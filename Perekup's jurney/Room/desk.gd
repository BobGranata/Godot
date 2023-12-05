extends CanvasLayer

signal level_changed(level_name)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var dict_car = BaseScript.m_dict_car
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_gui_input(event):
	if event.is_pressed() :
		emit_signal("level_changed", "Room/room")

func cleanup():	
	queue_free()
