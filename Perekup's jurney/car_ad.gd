extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_data(ad_model):
	$MarginContainer/VBoxContainer/Model.text = ad_model[BaseScript.MODEL]
	$MarginContainer/VBoxContainer/Volume.text = ad_model[BaseScript.VOLUME]
	pass


func _on_color_rect_gui_input(event):
	if event.is_action_pressed("click") :
		$ColorRect.color = "a7a7a7"
	pass
