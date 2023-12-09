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



func _ready():
	randomize()
	stop_lamp()
	$Label.set("text", "0" + str(20354)) # Пробег
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
	process_lamp()
						
	if buttLaunch:
		if buttGas:
			_on_gas_button_down()
		else:
			_on_gas_button_up()
	starter()
	if timer_starta == 19:
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

func starter():
	if timer_starta == 20: # работа стартера
		$Timer0_5sek.stop()
		timer_starta = 0
		if error == 0:
			Motor()
		$Starter.stop()
	
func Motor():
	gas = -0.75
	$Motor.play()

func launch_norm():
	if buttAcc == false and buttLaunch == false:
		acc()
	elif buttLaunch == false and buttAcc:
		launch()
	elif buttAcc and buttLaunch:		
		off_acc()
		
func launch_error_1():
	rng.randomize()
	if buttAcc == false and buttLaunch == false:
		acc()
	elif buttLaunch == false and buttAcc:
		$launch.set("text", "Выключить")	
		starter()
		#gas = rng.randf_range(-1, 0.1)
		#gas = -0.88  # 400 оборотов
		buttLaunch = true		
		start_lamp()
	elif buttAcc and buttLaunch:
		off_acc()


func _on_launch_pressed():
	if error == 0:
		launch_norm()
	elif error == 1:
		launch_error_1()
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
	
	






