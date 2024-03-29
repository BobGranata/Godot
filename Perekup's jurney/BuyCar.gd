extends Node2D

signal start_check
signal level_changed(level_name)

const base_models = preload("res://base_script.gd")

var choose_items = []

var check_mode = false
var m_status_description : String
var m_mismatch : base_models.mismatch_class

var dict_papers = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var dict_car = BaseScript.get_currect_car()
	
	var dict_pts = dict_car[BaseScript.PTS]
	var dict_advert = dict_car[BaseScript.PHONE]
	
	dict_papers = {BaseScript.PTS: $Pts,
#					BaseScript.PHONE: $Phone, 
					BaseScript.ORDER: $Order}

	
	$Pts.set_data_dict(dict_pts)
#	$Phone.set_data_dict(dict_advert)
	$CarView.set_data_dict(dict_car)
	
	$Order.set_data()
	
func _draw():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_data():
	var dict_car = BaseScript.get_currect_car()
	
	var dict_pts = dict_car[BaseScript.PTS]
	var dict_advert = dict_car[BaseScript.PHONE]
	
	$Pts.set_data_dict(dict_pts)
#	$Phone.set_data_dict(dict_advert)
	$CarView.set_data_dict(dict_car)	

func add_compare_item(_type_doc, type_item, control_item):
	print("compare")
	print(_type_doc)
	print(": ")
	print(type_item)
	for i in range(choose_items.size(), 0, -1) :
		if choose_items[i - 1].control_item == control_item :
			choose_items.remove_at(i - 1)
			$ChooseItemLayer.queue_redraw()
			$Info.text = ""
			return
			
	if choose_items.size() >= 2 :
		choose_items.remove_at(0)
			
	var item = base_models.adv_item.new()
	item.type_doc = _type_doc
	item.type_item = type_item
	item.control_item = control_item	
	choose_items.append(item)
	$ChooseItemLayer.queue_redraw()
	
	if choose_items.size() >= 2:
		var first = choose_items[0]
		var second =  choose_items[1]
		if first.type_doc == second.type_doc :
			m_status_description = "Нет связи"
		elif first.type_item != second.type_item :
			m_status_description = "Нет связи"

		elif first.type_item == second.type_item :
			var res = true
			if m_mismatch != null:
				var mis1 = m_mismatch.type_doc_first
				var mis2 = m_mismatch.type_doc_second
				var f1 = mis1 == first.type_doc || mis1 == second.type_doc 
				var f2 = mis2 == first.type_doc || mis2 == second.type_doc
				if m_mismatch != null && f1 && f2:
					if first.type_item == m_mismatch.field :
						# несовпадение
						m_status_description = "Обнаружено несоответсвие"
						res = false
			if res :
				m_status_description = "Всё верно"
				
	if choose_items.size() < 2:	
		m_status_description = ""	
		
#	if !m_status_description.is_empty():
#		$Info.text = m_status_description
	$Info.text = m_status_description

func move_doc(type_doc):	
	for dict_type_doc in dict_papers:
		if dict_type_doc == type_doc:
			dict_papers[dict_type_doc].set("z_index", 1)
		else:
			dict_papers[dict_type_doc].set("z_index", 0)
	
func _on_BtnStartCheck_pressed():
	if !check_mode :
		emit_signal("start_check", true)
		check_mode = true		
		$BtnStartCheck.text = 'x'
	else :
		emit_signal("start_check", false)
		check_mode = false
		choose_items.clear()
		$ChooseItemLayer.queue_redraw()
		$Info.text = ""
		$BtnStartCheck.text = '?'

func _on_button_pressed():
	for dict_type_doc in dict_papers:
		dict_papers[dict_type_doc].set("z_index", 0)	
	
#	BaseScript.check_order(true)
	
	$Shade.set("visible", true)
	$Shade/OrderResult.show_result(true)

func _on_button_2_pressed():
	for dict_type_doc in dict_papers:
		dict_papers[dict_type_doc].set("z_index", 0)	
	
#	BaseScript.check_order(false)
	
	$Shade.set("visible", true)
	$Shade/OrderResult.show_result(false)	
	
func _on_gui_work_end():
	emit_signal("level_changed", "results_of_day")

func _on_order_result_close_order_result():
	BaseScript.load_game()
	
	$AnimatedSprite2D.set("visible", true)
	$AnimatedSprite2D.play()	
	
func _on_animated_sprite_2d_animation_finished():
	emit_signal("level_changed", "BuyCar")
