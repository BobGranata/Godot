extends Node

enum { NONE, MODEL, MELEAGE, OWNERS, VIN, COLOR, YEAR, COST, VOLUME, ENGINE_NUMBER }

enum { PTS, PHONE, ENGINE_PLATE, VIN_PLATE}

#	var vin = base.generate_value("vin")
#	var color = base.generate_value("color")
#	var model = base.generate_value("model")
#	var volume = base.generate_value("volume")
#	var number = base.generate_value("number")

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
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
