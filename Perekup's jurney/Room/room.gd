extends CanvasLayer

signal level_changed(level_name)
# Called when the node enters the scene tree for the first time.
func _ready():	

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click") :
		emit_signal("level_changed", "Room/picture_on_the_wall")

func _on_window_input_event(viewport, event, shape_idx):
	if event.is_pressed() :
		$Label.text = 'Window'


func _on_area_2d_2_mouse_entered():
	$Area2D2/AnimatedSprite2D.play()


func _on_area_2d_2_mouse_exited():
	$Area2D2/AnimatedSprite2D.stop()

func _on_desk_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click") :
		emit_signal("level_changed", "Room/desk")
		
func cleanup():	
	queue_free()
