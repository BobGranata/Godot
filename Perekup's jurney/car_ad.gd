extends Control

var m_ad_id : int

signal ad_selected(id : int)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_data(ad_id):
	m_ad_id = ad_id
	var ad_model = BaseScript.m_dict_car[m_ad_id][BaseScript.PHONE]	
	$MarginContainer/VBoxContainer/Model.text = ad_model[BaseScript.MODEL]
	$MarginContainer/VBoxContainer/Volume.text = ad_model[BaseScript.VOLUME]
	pass


func _on_color_rect_gui_input(event):
	if event.is_action_pressed("click") :
		$ColorRect.color = "a7a7a7"
		emit_signal("ad_selected", m_ad_id)

func reset_item_color(ad_id):
	if m_ad_id != ad_id:
		$ColorRect.color = "ffffff"
