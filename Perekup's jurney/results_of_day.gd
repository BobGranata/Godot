extends Node2D

signal level_changed(level_name)

# Called when the node enters the scene tree for the first time.
func _ready():
	BaseScript.sum_up_the_day()
	$VBoxContainer/HBoxContainer3/Label2.text = str(BaseScript.m_bank_account)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_data():
	pass

func _on_button_pressed():		
	emit_signal("level_changed", "Room/room")
