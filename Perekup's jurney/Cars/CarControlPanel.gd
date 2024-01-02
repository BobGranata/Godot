extends Node2D

signal level_changed(level_name)
signal level_back()
signal add_compare_value

# 0 - off, 1 - acc, 2 - start
var key_state = 0

var buttGas = false
var gas = -1
var AirbagLamp = 0
var maslLamp = 0
var chekLamp = 0
var temp = -0.9
var ignition = 0
var timer_starta = 0

var m_dict_buy_car

func _ready():
	pass 

func process_lamp():
	if AirbagLamp == 2:  #Лампа подушки
		$Airbag.visible = false
		AirbagLamp = 0
		$TimerLampAirbag.stop()
	if maslLamp == 2:   #Лампа масла
		$Masl.visible = false
		maslLamp = 0
		$TimerLampMasl.stop()
	if chekLamp == 3:   #Лампа чек
		$Chek.visible = false
		chekLamp = 0
		$TimerLampChek.stop()

func _process(delta):
	Sound()
	process_lamp()
	if key_state == 2:
		if buttGas:
			_on_gas_button_down()
		else:
			_on_gas_button_up()
	starter()
	
	if timer_starta == 19:
		Motor()
	elif timer_starta == 39:
		Motor()
	elif timer_starta == 40:
		Motor()
	$Panel/Temp.set("rotation", temp)
	$Panel/Centr.set("rotation", gas)

func _on_gas_button_down():
	if key_state == 2:
		gas += 0.05
		if gas > 2.4-1:
			gas = 2.25-1
		buttGas = true

func Sound():
	if buttGas:
		$Motor2.play()
	else:
		$Motor2.stop()

func _on_gas_button_up():
	if key_state == 2:
		if gas >= 0.18-1:
			gas -= 0.02 
		buttGas = false

func start_lamp():
	$Akb.visible = true
	$Chek.visible = true
	$Masl.visible = true
	$Airbag.visible = true
	$Abs.visible = true
	$TimerLampAirbag.start()
	_on_timer_lamp_timeout()

func stop_lamp():
	$Akb.visible = false
	$Chek.visible = false
	$Masl.visible = false
	$Airbag.visible = false
	$Abs.visible = false
	$Toplivo.visible = false

func acc():
	$launch.set("text", "Запуск")
	key_state = 1
	start_lamp()
	$CheckButton.disabled = false
	
func launch():
	$launch.set("text", "Выключить")	
	$Timer0_5sek.start()
	$Starter.play()
	_on_timer_0_5_sek_timeout()
	starter()
	key_state = 2
	$TimerLampMasl.start()
	$TimerLampChek.start()
	_on_timer_lamp_chek_timeout()
	_on_timer_lamp_masl_timeout()
	$Akb.visible = false
	$Airbag.visible = false
	$Abs.visible = false
	$TimerTemp.start()
	_on_timer_temp_timeout()
	
func off_acc():
	$launch.set("text", "Зажигание")
	gas = -1		
	key_state = 0
	stop_lamp()
	if ignition == 0:
		$Motor.stop()
	elif ignition == 1:
		$slomMotor.stop()
	$diagnostics.visible = false
	$CheckButton.disabled = true
	$CheckButton.button_pressed = false

func starter():
	if ignition == 0:
		if timer_starta == 20: # работа стартера
			$Timer0_5sek.stop()
			timer_starta = 0
			$Starter.stop()
	elif ignition == 1:
		if timer_starta == 40: # работа стартера
			$Timer0_5sek.stop()
			timer_starta = 0
			$Starter.stop()
	elif ignition == 2:
		if timer_starta == 40: # работа стартера
			$Timer0_5sek.stop()
			timer_starta = 0
			gas = -1
			$Starter.stop()
	
func Motor():
	gas = -0.75
	if ignition == 0:
		$Motor.play()
	elif ignition == 1:
		$slomMotor.play()
	elif ignition == 2:
		$Motor.stop()

func launch_norm():
	if key_state == 0:
		acc()
	elif key_state == 1:
		launch()
	elif key_state > 1:
		off_acc()
		
func launch_error_1():
	if key_state == 0:
		acc()
	elif key_state == 1:
		$launch.set("text", "Выключить")	
		$Timer0_5sek.start()
		$Starter.play()
		_on_timer_0_5_sek_timeout()
		starter()		
		key_state = 2
		$TimerLampMasl.start()
		$Akb.visible = false
		$Airbag.visible = false
		$Abs.visible = false
		$TimerTemp.start()
		_on_timer_temp_timeout()
	elif key_state == 2:
		off_acc()
		
func launch_error_2():
	if key_state == 0:
		acc()
	elif key_state == 1 and $launch.get("text") == "Запуск":
		$launch.set("text", "Выключить")	
		$Timer0_5sek.start()
		$Starter.play()
		_on_timer_0_5_sek_timeout()
		starter()		
#		buttLaunch = false
	elif key_state == 1:
		off_acc()

func _on_launch_pressed():
	if ignition == 0:
		launch_norm()
	elif ignition == 1:
		launch_error_1()
	elif ignition == 2:
		launch_error_2()

func _on_timer_lamp_timeout():
	AirbagLamp += 1

func _on_timer_lamp_masl_timeout():
	maslLamp += 1

func _on_timer_lamp_chek_timeout():
	chekLamp += 1

func _on_timer_temp_timeout():
	if gas >= 0.15-1 and gas<=0.35-1:
		temp += 0.01		
	elif gas >= 0.35-1:
		temp += 0.03		
	elif gas >= 0.6-1:
		temp += 0.06

func _on_timer_0_5_sek_timeout():
	timer_starta += 1  # работа стартера
	gas = randf_range(-0.85, -0.88)

func _on_check_button_toggled(button_pressed):
	$diagnostics.visible = button_pressed
			
	if ignition == 0:
		$diagnostics/error.set("text", "Ошибок не обнаружено")
	elif ignition == 1:
		$diagnostics/error.set("text", "Ошибка двигателя, запуск затруднен")
	elif  ignition == 2:
		$diagnostics/error.set("text", "Ошибка двигателя, запуск невозможен")

func _on_check_button_2_toggled(button_pressed):
	$car_inspection.visible = button_pressed

func _on_button_gui_input(event):
	if event.is_pressed() :	
		emit_signal("level_back")	

func set_data(dict_buy_car):
	m_dict_buy_car = dict_buy_car
	var dict_control_panel = m_dict_buy_car[BaseScript.CONTROL_PANEL]
	
	var probeg = dict_control_panel[BaseScript.MELEAGE]
	ignition = dict_control_panel[BaseScript.IGNITION]
	
	stop_lamp()
	$Label.text = "0" + probeg # Пробег
	$diagnostics.visible = false
#	$diagnostics/probeg.set("text", "Пробег: " + str(probeg))
#	$diagnostics/motochas.set("text", "Моточасы: " + str(probeg/10000*365*2) + " моточасов")
	$CheckButton.disabled = true
	$Label2.text = str(ignition)
	$car_inspection.visible = false
