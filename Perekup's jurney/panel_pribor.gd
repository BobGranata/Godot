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



func _ready():
	$Akb.visible = false
	$Chek.visible = false
	$Masl.visible = false
	$Airbag.visible = false
	$Abs.visible = false
	$Toplivo.visible = false
	$Label.set("text", "0" + str(20354)) # Пробег
	pass 



func _process(delta):
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
						
	if buttLaunch:
		if buttGas:
			_on_gas_button_down()
		else:
			_on_gas_button_up()
	
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


func _on_launch_pressed():
	if buttAcc == false and buttLaunch == false:
		$launch.set("text", "Запуск")
		buttAcc = true
		$Akb.visible = true
		$Chek.visible = true
		$Masl.visible = true
		$Airbag.visible = true
		$Abs.visible = true
		$TimerLampAirbag.start()
		_on_timer_lamp_timeout()
		
		
		
		
	elif buttLaunch == false and buttAcc:
		$launch.set("text", "Выключить")	
		gas = 0.3-1		
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
		
	elif buttAcc and buttLaunch:		
		$launch.set("text", "Зажигание")
		gas = -1		
		buttAcc = false
		buttLaunch = false
	
		$Akb.visible = false
		$Chek.visible = false
		$Masl.visible = false
		$Airbag.visible = false
		$Abs.visible = false
		$Toplivo.visible = false
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
