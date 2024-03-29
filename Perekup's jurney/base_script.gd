extends Node

enum { NONE, MODEL, MELEAGE, OWNERS, VIN, COLOR, YEAR, COST, VOLUME, ENGINE_NUMBER, IGNITION }
# 
const title_rus = {
	MODEL: "Модель: ", 
	MELEAGE: "Пробег: ", 
	OWNERS: "Владельцы: ", 
	VIN: "VIN: ", 
	COLOR: "Цвет: ", 
	YEAR: "Год выпуска: ", 
	COST: "Цена: ", 
	VOLUME: "Объём: ", 
	ENGINE_NUMBER: "Номер двигателя: "}

enum { PTS, ENGINE_PLATE, VIN_PLATE, CONTROL_PANEL, ORDER}
enum { PHONE }
	
# Called when the node enters the scene tree for the first time.
func _ready():
	start_new_day()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

class adv_item:
	var type_doc : int
	var type_item : int
	var control_item : Control	

class engine_class:
	var volume : String
	var number : String
	
class mismatch_class:
	var type_doc_first : int
	var type_doc_second : int
	var field : int
	
var characters = 'abcdefghijklmnopqrstuvwxyz1234567890'

#var dict = {"name":"generalistprogrammer", 
#		"		skills": {"frontend":"javascript","backend":"golang","gamedevelopment":"godot"}
#	}

const car_models = ["Lada", "KIA", "Subaru", "Datsun", "Audi", "Scoda", "Siat", "Jeep", "Toyota", "Ford", "Renault"]
const car_colors = ["Зелёный", "Красный", "Бежевый", "Синий", "Чёрный", "Белый", "Жёлтный", "Оранжевый", "Голубой"]
const car_engine_volums = ["1.2", "1.4", "1.6", "1.8", "2.0"]

const car_gears = ["МКПП", "АКПП"]

# Требование: Идеальное, хорошее, 
# Не бит не крашен, крашен, поцарапан 
const car_body_condition = [1, 2, 3, 4, 5]

const car_class = ["a", "b", "c", "d", "f", "g"]
const car_price_category = [1, 2, 3, 4, 5]

func generate_word(chars, length):
	var word : String = ""
	var n_char = len(chars)
	for i in range(length):
		word += chars[randi()% n_char]
	return word.to_upper()	
	
func generate_value(key):
	if key == VIN :
		return generate_word(characters, 6)
	elif key == COLOR:
#		var res = car_colors[randi() % len(car_colors)]
#		if res == except:
		return car_colors[randi() % len(car_colors)]
	elif key == MODEL:
		return car_models[randi() % len(car_models)]
	elif key == VOLUME:
		return car_engine_volums[randi() % len(car_engine_volums)]
	elif key == ENGINE_NUMBER:
		return generate_word(characters, 5)
		
	elif key == MELEAGE:
		return str(randi() % 30 * 10000)
	elif key == OWNERS:
		return str(randi() % 3 + 1)
	elif key == YEAR:
		var time = Time.get_date_dict_from_system()		
		var year = time['year']
		return str(year - randi() % 20)
	elif key == COST:
		return str(randi() % 100 * 10000)
	elif key == IGNITION:	
		return randi_range(0, 2)


var m_dict_car = {}
var m_current_car = {}
var order_model = {}
var m_result_order = {}

#var m_current_car_id
var m_level = 1

var game_minutes = 40
var game_hours = 17
var game_year = 2022
var game_month = 06
var game_day = 12

var m_bank_account = 1500

var m_room_rent = -500
var m_utility_fee = -100
var m_food = -100

var m_number_of_good_deal = 0

func load_game():
	load_order()	
	for i in 1:
		load_car_by_order()

#func set_car_id(id : int):
#	m_current_car_id = id
#
func get_currect_car():
	return m_dict_car
#	return m_dict_car[m_current_car_id]
#
#func delete_currect_car():
#	m_dict_car.erase(m_current_car_id)	

func load_order():
#	Модель
#	Год выпуска
#	Пробег
#	Количество владельцев
#	Цена		

#	m_level = 5
	if m_level >= 1:
		order_model[MODEL] = generate_value(MODEL)
		order_model[COLOR] = generate_value(COLOR)
		order_model[YEAR] = generate_value(YEAR)
	if m_level >= 2:
		order_model[VOLUME] = generate_value(VOLUME)
	if m_level >= 3:		
		order_model[OWNERS] = generate_value(OWNERS)
	if m_level >= 4:		
		order_model[MELEAGE] = generate_value(MELEAGE)
	if m_level >= 5:
		order_model[COST] = generate_value(COST)
	if m_level >= 6:	
		order_model[COST] = generate_value(COST)
		
	
func load_car_by_order():
	randomize()		
	
	var generate_data = {VIN: generate_value(VIN),
							MODEL: generate_value(MODEL),
							COLOR: generate_value(COLOR),
							VOLUME: generate_value(VOLUME),
							YEAR: generate_value(YEAR),
							MELEAGE: generate_value(MELEAGE),
							OWNERS: generate_value(OWNERS),
							COST: generate_value(COST),
							ENGINE_NUMBER: generate_value(ENGINE_NUMBER),
							IGNITION: generate_value(IGNITION)
							}

	for order_item in order_model:
		generate_data[order_item] = order_model[order_item]
		
	var vin = generate_data[VIN]
	var model = generate_data[MODEL]
	var color = generate_data[COLOR]
	var volume = generate_data[VOLUME]	
	var year = generate_data[YEAR]
	var meleage = generate_data[MELEAGE]	
	var owners = generate_data[OWNERS]
	var cost = generate_data[COST]	
	var number = generate_data[ENGINE_NUMBER]	
	
	var dict_pts = {}
	dict_pts[MODEL] = model
	dict_pts[VIN] = vin
	dict_pts[COLOR] = color
	dict_pts[VOLUME] = volume
	dict_pts[ENGINE_NUMBER] = number

	dict_pts[YEAR] = year
	dict_pts[MELEAGE] = meleage
	dict_pts[OWNERS] = owners
	
	var dict_advert = {}
	dict_advert[MODEL] = model
	dict_advert[VIN] = vin
	dict_advert[COLOR] = color
	dict_advert[VOLUME] = volume
	dict_advert[COST] = cost
	
	var dict_engine_plate = {}
	dict_engine_plate[ENGINE_NUMBER] = number	
	dict_engine_plate[VOLUME] = volume	
	
	var dict_vin_plate = {}
	dict_vin_plate[MODEL] = model
	dict_vin_plate[VIN] = vin
	dict_vin_plate[COLOR] = color
	
	var dict_control_panel = { MELEAGE: meleage,
								IGNITION: generate_data[IGNITION]}
	
	var dict_buy_car = {PTS: dict_pts, 
#						PHONE: dict_advert, 
						ENGINE_PLATE: dict_engine_plate, 
						VIN_PLATE: dict_vin_plate,
						CONTROL_PANEL: dict_control_panel}
	
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
		
		var m_mismatch = null
		if size_cross:		
			var mismatch
			if size_cross == 1:			
				mismatch = doc_dictionary_cross[0]
			else:
				mismatch = doc_dictionary_cross[randi() % size_cross]
				
			if randi() % 2 == 1:
				doc_dictionary_1[mismatch] = generate_value(mismatch)
			else:
				doc_dictionary_2[mismatch] = generate_value(mismatch)
				
			if (doc_dictionary_1[mismatch] != doc_dictionary_2[mismatch]):				
				m_mismatch = mismatch_class.new()
				m_mismatch.type_doc_first = mismatch_doc_1
				m_mismatch.type_doc_second = mismatch_doc_2
				m_mismatch.field = mismatch

				print(m_mismatch.type_doc_first)
				print(m_mismatch.type_doc_second)
				print(m_mismatch.field)
				
			else:
				m_mismatch = null
				print(null)
		else:
			m_mismatch = null
			print(null)	
	
#	m_dict_car[0] = dict_buy_car
	m_dict_car = dict_buy_car

func intersect_arrays(arr1, arr2):
	var arr2_dict = {}
	for v in arr2:
		arr2_dict[v] = true

	var in_both_arrays = []
	for v in arr1:
		if arr2_dict.get(v, false):
			in_both_arrays.append(v)
	return in_both_arrays

func check_order(deal) -> int : 
	var compare_car = get_currect_car()	
	
	for order_item in order_model:
		m_result_order[order_item] = true
	
	for buy_car_model_type in compare_car:
		var buy_car_model = compare_car[buy_car_model_type]
		var doc_dictionary_cross = intersect_arrays(order_model, buy_car_model)
		for compare_key in doc_dictionary_cross:
			if	compare_key == YEAR:
				if int(order_model[compare_key]) > int(buy_car_model[compare_key]):
						m_result_order[compare_key] = false
			if  compare_key == MELEAGE || compare_key == OWNERS || compare_key ==  COST:
				if int(order_model[compare_key]) < int(buy_car_model[compare_key]):
					m_result_order[compare_key] = false
			elif order_model[compare_key] != buy_car_model[compare_key]:
				m_result_order[compare_key] = false
	
	var res_money = 100
	
	var there_is_mistake = false
	for res in m_result_order:
		if (!m_result_order[res]):
			there_is_mistake = true
			break
				
	if deal && there_is_mistake:
		res_money = -100
				
	if !deal && there_is_mistake:
		res_money = 100

	if !deal && !there_is_mistake:
		res_money = -100	
		
	if res_money > 0:
		m_number_of_good_deal += 1
		
	m_bank_account += res_money	
	
	return res_money
	
#	var dict_buy_car = {PTS: dict_pts, 
#						PHONE: dict_advert, 
#						ENGINE_PLATE: dict_engine_plate, 
#						VIN_PLATE: dictVinPlate }	

func sum_up_the_day():
	m_level += 1

	m_room_rent = -200
	m_utility_fee = -50
	m_food = -100
	
	m_number_of_good_deal
	
	m_bank_account += m_room_rent
	m_bank_account += m_utility_fee
	m_bank_account += m_food		
	
func start_new_day():
	m_number_of_good_deal = 0
	
	game_day += 1
	game_hours = 12
	game_minutes = 0
