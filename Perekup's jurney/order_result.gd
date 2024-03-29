extends Node2D

signal close_order_result

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_result(deal):
	set("visible", true)
	$ColorRect/Button.set("visible", true)
	$ColorRect/lbResultMoney.set("visible", true)
	
	get_tree().call_group("order_result_list", "queue_free")	
	
	var res_money = BaseScript.check_order(deal)
	
	for order_item in BaseScript.order_model:
#		if order_item != BaseScript.MODEL:
#			continue
		var new_label = Label.new()
				
		var title = BaseScript.title_rus[order_item]
		title += BaseScript.order_model[order_item]

		if (!BaseScript.m_result_order[order_item]) :
			title += " Ошибка"
		else:
			title += " Ok"
		
		new_label.text = title
		new_label.visible = true
		new_label.set("theme_override_colors/font_color", "000000")
#		new_car_ad.ad_selected.connect(set_ad_id)
#		new_car_ad.set_data(item_buy_car)
#		reset_selection.connect(new_car_ad.reset_item_color)
		$ColorRect/MarginContainer/VBoxContainer.add_child(new_label)	
		
#	var res_money = 100
#	var res_decriment = 0
#	for res in BaseScript.m_result_order:
#		if (!BaseScript.m_result_order[res]):
#			res_decriment -= 100
#
#	if (res_decriment != 0):
#		res_money = res_decriment
#	else:
#		BaseScript.m_number_of_good_deal += 1
#
#	BaseScript.m_bank_account += res_money
#
	$ColorRect/lbResultMoney.text = "Итого: " 
	$ColorRect/lbResultMoney.text += str(res_money)


func _on_button_pressed():
	set("visible", false)
	$ColorRect/lbResultMoney.set("visible", false)
	$ColorRect/Button.set("visible", false)

	BaseScript.m_result_order.clear()
	
	emit_signal("close_order_result")
