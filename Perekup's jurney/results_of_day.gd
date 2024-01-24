extends Node2D

enum { MORTGAGE, UTILITY_FEE}

signal level_changed(level_name)

# Called when the node enters the scene tree for the first time.
func _ready():
	BaseScript.sum_up_the_day()
	
	BaseScript.m_room_rent
	BaseScript.m_utility_fee
		
	var m_daily_expenses = {"Ипотека:": BaseScript.m_room_rent, 
	"Бензин:": BaseScript.m_utility_fee, 
	"Еда:": BaseScript.m_utility_fee, 
	"Удачных сделок:": BaseScript.m_number_of_good_deal,
	".............................": "",
	"Всего:": BaseScript.m_bank_account}
	
	for order_item in m_daily_expenses:
		var new_label_key = Label.new()
		var new_label_value = Label.new()

		var sss = str(m_daily_expenses[order_item])

		new_label_key.text = order_item
		new_label_value.text = str(m_daily_expenses[order_item])

		new_label_key.set("theme_override_font_sizes/font_size", 14)
		new_label_value.set("theme_override_font_sizes/font_size", 14)		
		
#		new_label_key.add_to_group("order_list")
#		new_label_value.add_to_group("order_list")
		
		$HBoxContainer/Key.add_child(new_label_key)
		$HBoxContainer/Value.add_child(new_label_value)	
		
	BaseScript.start_new_day()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_data():
	pass

func _on_button_pressed():		
	emit_signal("level_changed", "Room/room")
