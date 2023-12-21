extends Node2D

signal close_order_result

var m_dict_order

@onready var model_view = $ColorRect/MarginContainer/VBoxContainer/Model
@onready var color_view = $ColorRect/MarginContainer/VBoxContainer/Color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_data():
	model_view.text = BaseScript.order_model[BaseScript.MODEL]
	color_view.text = BaseScript.order_model[BaseScript.COLOR]
#	Модель
#	Год выпуска
#	Пробег
#	Количество владельцев
#	Цена

func show_result():
	set("visible", true)
	$ColorRect/Button.set("visible", true)
	$ColorRect/lbResultMoney.set("visible", true)
	
	BaseScript.m_result_order[BaseScript.MODEL]
	model_view.text = BaseScript.order_model[BaseScript.MODEL]
	if (!BaseScript.m_result_order[BaseScript.MODEL]) :
		model_view.text += " Ошибка"
	else:
		model_view.text += " Ok"
		
	color_view.text = BaseScript.order_model[BaseScript.COLOR]
	if (!BaseScript.m_result_order[BaseScript.COLOR]) :
		color_view.text += " Ошибка"
	else:
		color_view.text += " Ok"
		
	var res_money = 100
	var res_decriment = 0
	for res in BaseScript.m_result_order:
		if (!BaseScript.m_result_order[res]):
			res_decriment -= 100
	
	if (res_decriment != 0):
		res_money = res_decriment
		
	$ColorRect/lbResultMoney.text = "Итого: " 
	$ColorRect/lbResultMoney.text += str(res_money)


func _on_button_pressed():
	set("visible", false)
	$ColorRect/lbResultMoney.set("visible", false)
	$ColorRect/Button.set("visible", false)

	BaseScript.m_result_order.clear()
	
	emit_signal("close_order_result")
