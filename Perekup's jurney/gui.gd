extends Node2D

signal work_end

# Called when the node enters the scene tree for the first time.
func _ready():
	update_bank_account()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_bank_account():
	$Panel/BankAccount.text = str(BaseScript.m_bank_account)

func _on_timer_timeout():
	BaseScript.game_minutes += 1

	if BaseScript.game_minutes >= 60:
		BaseScript.game_minutes = 0

		BaseScript.game_hours += 1
		if BaseScript.game_hours >= 24:
			BaseScript.game_hours = 0
			
		if BaseScript.game_hours >= 18:
			$Timer.stop()
			emit_signal("work_end")
			
	var sHours = str(BaseScript.game_hours)
	var sMinutes = str(BaseScript.game_minutes)

	if sMinutes.length() < 2:
		sMinutes = "0" + sMinutes

	if sHours.length() < 2:
		sHours = "0" + sHours
	
	$Panel/MarginContainer/VBoxContainer/Time.text = sHours + ":" + sMinutes
	$Panel/MarginContainer/VBoxContainer/Date.text = str(BaseScript.game_day) + "." + str(BaseScript.game_month) + "." + str(BaseScript.game_year)
	
#	
