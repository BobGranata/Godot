extends Control

var m_dict_buy_car

var ignition = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_data(dict_buy_car):
	m_dict_buy_car = dict_buy_car
	var dict_control_panel = m_dict_buy_car[BaseScript.CONTROL_PANEL]
	
	var probeg = dict_control_panel[BaseScript.MELEAGE]
	ignition = dict_control_panel[BaseScript.IGNITION]
	
	$probeg.set("text", "Пробег: " + str(probeg))
	$motochas.set("text", "Моточасы: " + str(probeg/10000*365*2) + " моточасов")	
	
	if ignition == 0:
		$error.set("text", "Ошибок не обнаружено")
	elif ignition == 1:
		$error.set("text", "Ошибка двигателя, запуск затруднен")
	elif  ignition == 2:
		$error.set("text", "Ошибка двигателя, запуск невозможен")	
