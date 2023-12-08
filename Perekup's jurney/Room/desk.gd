extends CanvasLayer

signal level_changed(level_name)
signal reset_selection(id : int)

var m_ad_id : int

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var dict_car = BaseScript.m_dict_car
	
	for item_buy_car in dict_car:		
		var new_car_ad = load("res://car_ad.tscn").instantiate()
		new_car_ad.ad_selected.connect(set_ad_id)
		new_car_ad.set_data(item_buy_car)
		reset_selection.connect(new_car_ad.reset_item_color)
		$ScrollContainer/VBoxContainer.add_child(new_car_ad)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_gui_input(event):
	if event.is_action_pressed("click") :
		emit_signal("level_changed", "Room/room")

func cleanup():	
	queue_free()

func set_ad_id(ad_id):
	if ad_id != m_ad_id:
		emit_signal("reset_selection", ad_id)
	m_ad_id = ad_id	

func _on_button_2_pressed():	
	BaseScript.set_car_id(m_ad_id)
	emit_signal("level_changed", "BuyCar")
