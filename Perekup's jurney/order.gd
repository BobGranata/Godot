extends Node2D

var m_dict_order

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_data(dict_order):
	m_dict_order = dict_order		
	
#	Модель
#	Год выпуска
#	Пробег
#	Количество владельцев
#	Цена
