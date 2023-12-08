extends Node2D

const base_models = preload("res://base_script.gd")

const SAVE_PATH = "res://car_adv.json"
signal start_check

var choose_items = []

var check_mode = false
var m_status_description : String
var m_mismatch : base_models.mismatch_class

# Called when the node enters the scene tree for the first time.
func _ready():
#	load_game()	

	var dict_car = BaseScript.get_currect_car()
	
	var dict_pts = dict_car[BaseScript.PTS]
	var dict_advert = dict_car[BaseScript.PHONE]
	
	$Pts.set_data_dict(dict_pts)
	$Phone.set_data_dict(dict_advert)
	$CarView.set_data_dict(dict_car)
	pass
	
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
	$Phone.set_data_dict(dict_advert)
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
	if type_doc == base_models.PTS :
		$Pts.set("z_index", 1)
		$Phone.set("z_index", 0)
	elif type_doc == base_models.PHONE :
		$Pts.set("z_index", 0)
		$Phone.set("z_index", 1)

# `load()` is reserved.
func load_game_json():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var test_json_conv = JSON.new()
	test_json_conv.parse(file.get_as_text())
	var save_dict = test_json_conv.get_data()
	
	var root = save_dict.advertisement
	
#	var idPts = str_to_var(root.pts.id)
	var modelPts= root.pts.model
	var vinPts = root.pts.vin
	var colorPts = root.pts.color
	var volume_pts = root.pts.volume
	var number_pts = root.pts.number	

	$Pts.set_data(modelPts, vinPts, colorPts, volume_pts, number_pts)
	
#	var idAd = str_to_var(root.pts.id)
	var modelAd = root.adv.model
	var vinAd = root.adv.vin
	var colorAd = root.adv.color	
	
	$Phone.set_data(modelAd, vinAd, colorAd)

	var engine = base_models.engine_class.new()
	engine.volume = root.car.engine.volume
	engine.number = root.car.engine.number
	$CarView.set_data(engine)
	
	
	m_mismatch = base_models.mismatch_class.new()
	m_mismatch.type_doc_first = str_to_var(root.mismatch.type_first)
	m_mismatch.type_doc_second = str_to_var(root.mismatch.type_second)
	m_mismatch.field = str_to_var(root.mismatch.field)
	
	$CarView.set_data(engine)	
	
func load_game():
	randomize()
	
	var base = base_models.new()
	var vin = base.generate_value(base.VIN)
	var color = base.generate_value(base.COLOR)
	var model = base.generate_value(base.MODEL)
	var volume = base.generate_value(base.VOLUME)
	var number = base.generate_value(base.ENGINE_NUMBER)
	
	var dict_pts = {}
	dict_pts[base.MODEL] = model
	dict_pts[base.VIN] = vin
	dict_pts[base.COLOR] = color
	dict_pts[base.VOLUME] = volume
	dict_pts[base.ENGINE_NUMBER] = number
	
	var dict_advert = {}
	dict_advert[base.MODEL] = model
	dict_advert[base.VIN] = vin
	dict_advert[base.COLOR] = color
#	dict_advert[base.VOLUME] = volume
	
	var dict_engine_plate = {}
	dict_engine_plate[base.ENGINE_NUMBER] = number	
	dict_engine_plate[base.VOLUME] = volume	
	
	var dictVinPlate = {}
	dictVinPlate[base.MODEL] = model
	dictVinPlate[base.VIN] = vin
	dictVinPlate[base.COLOR] = color
	
	var dict_buy_car = {base.PTS: dict_pts, 
						base.PHONE: dict_advert, 
						base.ENGINE_PLATE: dict_engine_plate, 
						base.VIN_PLATE: dictVinPlate }
	
	var doc_count = dict_buy_car.size()
	# С вероятностью 1/4 будет ошибка
#	if randi() % 4 == 3 :
	if true:
		var mismatch_doc_1 = randi() % doc_count
		var mismatch_doc_2 = randi() % doc_count
		
		if (mismatch_doc_1 == mismatch_doc_2) :
			if mismatch_doc_1 + 1 <= doc_count :
				++mismatch_doc_1
			elif mismatch_doc_1 - 1 >= 1 :
				--mismatch_doc_1
						
		var doc_dictionary_1 = dict_buy_car[mismatch_doc_1]
		var doc_dictionary_2 = dict_buy_car[mismatch_doc_2]
		var doc_dictionary_cross = intersect_arrays(doc_dictionary_1, doc_dictionary_2)
		var size_cross = doc_dictionary_cross.size()
		
		if size_cross:		
			var mismatch
			if size_cross == 1:			
				mismatch = doc_dictionary_cross[0]
			else:
				mismatch = doc_dictionary_cross[randi() % size_cross]
				
			if randi() % 2 == 1:
				doc_dictionary_1[mismatch] = base.generate_value(mismatch)
			else:
				doc_dictionary_2[mismatch] = base.generate_value(mismatch)
				
			if (doc_dictionary_1[mismatch] != doc_dictionary_2[mismatch]):				
				m_mismatch = base_models.mismatch_class.new()
				m_mismatch.type_doc_first = mismatch_doc_1
				m_mismatch.type_doc_second = mismatch_doc_2
				m_mismatch.field = mismatch

				print(m_mismatch.type_doc_first)
				print(m_mismatch.type_doc_second)
				print(m_mismatch.field)
				
#				$VBoxContainer/LabelTest1.text
#				$VBoxContainer/LabelTest2.text
#				$VBoxContainer/LabelTest3.text
			else:
				m_mismatch = null
				print(null)
		else:
			m_mismatch = null
			print(null)
	
	$Pts.set_data_dict(dict_pts)
	$Phone.set_data_dict(dict_advert)
	$CarView.set_data_dict(dict_buy_car)

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

func intersect_arrays(arr1, arr2):
	var arr2_dict = {}
	for v in arr2:
		arr2_dict[v] = true

	var in_both_arrays = []
	for v in arr1:
		if arr2_dict.get(v, false):
			in_both_arrays.append(v)
	return in_both_arrays

func _on_button_pressed():
	load_game()	
	pass # Replace with function body.

func _on_button_2_pressed():
	pass # Replace with function body.
