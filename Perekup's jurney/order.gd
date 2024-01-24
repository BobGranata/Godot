extends Node2D

signal close_order_result

signal add_compare_value
signal move_doc

var check_mode = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_data():	
	for order_item in BaseScript.order_model:
		var new_label_key = Label.new()
		var new_label_value = Label.new()

		new_label_key.text = BaseScript.title_rus[order_item]
		new_label_value.text = BaseScript.order_model[order_item]

		new_label_key.visible = true
		new_label_value.visible = true
		new_label_key.set("theme_override_colors/font_color", "000000")
		new_label_value.set("theme_override_colors/font_color", "000000")
		
		new_label_key.set("theme_override_font_sizes/font_size", 14)
		new_label_value.set("theme_override_font_sizes/font_size", 14)		
		
#		new_label_key.add_to_group("order_list")
#		new_label_value.add_to_group("order_list")
		
		$ColorRect/MarginContainer/HBoxContainer/Key.add_child(new_label_key)
		$ColorRect/MarginContainer/HBoxContainer/Value.add_child(new_label_value)
		
#		var new_label = Label.new()
#
#		var title = BaseScript.title_rus[order_item]
#		title += BaseScript.order_model[order_item]
#		new_label.text = title
#		new_label.visible = true
#		new_label.set("theme_override_colors/font_color", "000000")
#
#		new_label.add_to_group("order_list")
#		$ColorRect/MarginContainer/VBoxContainer.add_child(new_label)
		
#	Модель
#	Год выпуска
#	Пробег
#	Количество владельцев
#	Цена

func _on_color_rect_gui_input(event):
	if !check_mode :
		if event.is_action_pressed("click") :
			$ColorRect/Shadow.set("visible", true)
			emit_signal("move_doc", BaseScript.ORDER)
		
		if event.is_action_released("click"):
			$ColorRect/Shadow.set("visible", false)
		if event is InputEventScreenDrag :
			$ColorRect.position += event.relative
			emit_signal("move_doc", BaseScript.ORDER)
