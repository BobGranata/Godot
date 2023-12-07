extends CanvasLayer

signal level_changed(level_name)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var dict_car = BaseScript.m_dict_car
	
	for item_buy_car in dict_car:		
		var ad = dict_car[item_buy_car]
		var ad_ = dict_car[item_buy_car][BaseScript.PHONE]		
		var new_car_ad = load("res://car_ad.tscn").instantiate()
		new_car_ad.set_data(ad_)
		$ScrollContainer/VBoxContainer.add_child(new_car_ad)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_gui_input(event):
	if event.is_action_pressed("click") :
		emit_signal("level_changed", "Room/room")

func cleanup():	
	queue_free()


func _on_button_2_pressed():	
	BaseScript.set_car_id(0)
	emit_signal("level_changed", "BuyCar")
