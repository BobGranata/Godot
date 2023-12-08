extends Node

enum { NONE, MODEL, MELEAGE, OWNERS, VIN, COLOR, YEAR, COST, VOLUME, ENGINE_NUMBER }

enum { PTS, PHONE, ENGINE_PLATE, VIN_PLATE}
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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

func generate_word(chars, length):
	var word: String
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

var m_dict_car = {}
var m_current_car_id

func load_game():
	for i in 10:
		load_car(i)

func set_car_id(id : int):
	m_current_car_id = id
	
func get_currect_car():
	return m_dict_car[m_current_car_id]

func load_car(car_id):
	randomize()
	
	var vin = generate_value(VIN)
	var color = generate_value(COLOR)
	var model = generate_value(MODEL)
	var volume = generate_value(VOLUME)
	var number = generate_value(ENGINE_NUMBER)
	
	var dict_pts = {}
	dict_pts[MODEL] = model
	dict_pts[VIN] = vin
	dict_pts[COLOR] = color
	dict_pts[VOLUME] = volume
	dict_pts[ENGINE_NUMBER] = number
	
	var dict_advert = {}
	dict_advert[MODEL] = model
	dict_advert[VIN] = vin
	dict_advert[COLOR] = color
	dict_advert[VOLUME] = volume
	
	var dict_engine_plate = {}
	dict_engine_plate[ENGINE_NUMBER] = number	
	dict_engine_plate[VOLUME] = volume	
	
	var dictVinPlate = {}
	dictVinPlate[MODEL] = model
	dictVinPlate[VIN] = vin
	dictVinPlate[COLOR] = color
	
	var dict_buy_car = {PTS: dict_pts, 
						PHONE: dict_advert, 
						ENGINE_PLATE: dict_engine_plate, 
						VIN_PLATE: dictVinPlate }
	
	m_dict_car[car_id] = dict_buy_car
	
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

func intersect_arrays(arr1, arr2):
	var arr2_dict = {}
	for v in arr2:
		arr2_dict[v] = true

	var in_both_arrays = []
	for v in arr1:
		if arr2_dict.get(v, false):
			in_both_arrays.append(v)
	return in_both_arrays
