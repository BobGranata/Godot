extends Node2D
var buttLaunch = false
var buttAcc = false
var buttGas = false
var gas = -1
var AirbagLamp = 0
var maslLamp = 0
var chekLamp = 0
var temp = -0.9
var timeTemp = 0
var error = 0
var rng = RandomNumberGenerator.new()
var timer_starta = 0
var motor_sound =false
var probeg



func _ready():
	randomize()
	error = rng.randi_range(0, 2)
	stop_lamp()
	probeg = rng.randi_range(10000, 99999)
	$Label.set("text", "0" + str(probeg)) # Пробег
	$diagnostics.visible = false
	$diagnostics/probeg.set("text", "Пробег: " + str(probeg))
	$diagnostics/motochas.set("text", "Моточасы: " + str(probeg/10000*365*2) + " моточасов")
	$CheckButton.disabled = true
	$Label2.set("text", str(error))
	$car_inspection.visible = false
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
	if buttLaunch:
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
	pass


func _on_gas_button_down():
	if buttLaunch:
		gas += 0.05
		if gas > 2.4-1:
			gas = 2.25-1
		buttGas = true
	pass 

func Sound():
	if buttGas:
		$Motor2.play()
	else:
		$Motor2.stop()
	pass
		

func _on_gas_button_up():
	if buttLaunch:
		if gas >= 0.18-1:
			gas -= 0.02 
		buttGas = false
	pass

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
	buttAcc = true
	start_lamp()
	$CheckButton.disabled = false
	
func launch():
	$launch.set("text", "Выключить")	
	$Timer0_5sek.start()
	$Starter.play()
	_on_timer_0_5_sek_timeout()
	starter()
	buttLaunch = true		
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
	buttAcc = false
	buttLaunch = false
	stop_lamp()
	if error == 0:
		$Motor.stop()
	elif error == 1:
		$slomMotor.stop()
	$diagnostics.visible = false
	$CheckButton.disabled = true
	$CheckButton.button_pressed = false

func starter():
	if error == 0:
		if timer_starta == 20: # работа стартера
			$Timer0_5sek.stop()
			timer_starta = 0
			$Starter.stop()
	elif error == 1:
		if timer_starta == 40: # работа стартера
			$Timer0_5sek.stop()
			timer_starta = 0
			$Starter.stop()
	elif error == 2:
		if timer_starta == 40: # работа стартера
			$Timer0_5sek.stop()
			timer_starta = 0
			gas = -1
			$Starter.stop()
	
	
func Motor():
	gas = -0.75
	if error == 0:
		$Motor.play()
	elif error == 1:
		$slomMotor.play()
	elif error == 2:
		$Motor.stop()

func launch_norm():
	if buttAcc == false and buttLaunch == false:
		acc()
	elif buttLaunch == false and buttAcc:
		launch()
	elif buttAcc and buttLaunch:		
		off_acc()
		
func launch_error_1():
	if buttAcc == false and buttLaunch == false:
		acc()
	elif buttLaunch == false and buttAcc:
		$launch.set("text", "Выключить")	
		$Timer0_5sek.start()
		$Starter.play()
		_on_timer_0_5_sek_timeout()
		starter()		
		buttLaunch = true		
		$TimerLampMasl.start()
		$Akb.visible = false
		$Airbag.visible = false
		$Abs.visible = false
		$TimerTemp.start()
		_on_timer_temp_timeout()
	elif buttAcc and buttLaunch:		
		off_acc()
		
func launch_error_2():
	if buttAcc == false and buttLaunch == false:
		acc()
	elif buttLaunch == false and buttAcc and $launch.get("text") == "Запуск":
		$launch.set("text", "Выключить")	
		$Timer0_5sek.start()
		$Starter.play()
		_on_timer_0_5_sek_timeout()
		starter()		
		buttLaunch = false
	elif buttAcc and buttLaunch == false:		
		off_acc()


func _on_launch_pressed():
	if error == 0:
		launch_norm()
	elif error == 1:
		launch_error_1()
	elif error == 2:
		launch_error_2()
	pass 


func _on_timer_lamp_timeout():
	AirbagLamp += 1
	pass 


func _on_timer_lamp_masl_timeout():
	maslLamp += 1
	pass


func _on_timer_lamp_chek_timeout():
	chekLamp += 1
	pass 



func _on_timer_temp_timeout():
	if gas >= 0.15-1 and gas<=0.35-1:
		temp += 0.01		
	elif gas >= 0.35-1:
		temp += 0.03		
	elif gas >= 0.6-1:
		temp += 0.06
	pass


func _on_timer_0_5_sek_timeout():
	timer_starta += 1  # работа стартера
	gas = rng.randf_range(-0.85, -0.88)



func _on_check_button_toggled(button_pressed):
	if button_pressed:
		$diagnostics.visible = true
	else:
		$diagnostics.visible = false
		
	if error == 0:
		$diagnostics/error.set("text", "Ошибок не обнаружено")
	elif error == 1:
		$diagnostics/error.set("text", "Ошибка двигателя, запуск затруднен")
	elif  error == 2:
		$diagnostics/error.set("text", "Ошибка двигателя, запуск невозможен")
	pass # Replace with function body.


func _on_check_button_2_toggled(button_pressed):
	if button_pressed:
		$car_inspection.visible = true
	else :
		$car_inspection.visible = false
	
	pass # Replace with function body.
