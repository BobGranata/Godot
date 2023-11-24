extends Node2D

var caption : String
var i : int
var gap : int = 0
var start_typing_caption = false

# Called when the node enters the scene tree for the first time.
func _ready():
#	caption = "Proverka mikrophona"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_typing_caption :
		if gap == 1 :			
#		if true :
			$Label.text += caption[i]
			i += 1
			if i >= caption.length() :	
				i = 0
				start_typing_caption = false
			gap = 0
		gap += 1
	pass


func _on_area_2d_mouse_entered():
#	$Timer.start()
	if caption.length() != 0 :
		start_typing_caption = true
		
	$AnimatedSprite2D.play()
	Input.set_default_cursor_shape(2)


func _on_area_2d_mouse_exited():
	start_typing_caption = false
	$Label.text = ""
	i = 0
	$Timer.stop()
	
	$AnimatedSprite2D.stop()
	Input.set_default_cursor_shape(0)


func _on_timer_timeout():
	$Label.text += caption[i]
	i = i + 1
	if i >= caption.length() :	
		i = 0
		$Timer.stop()
	pass # Replace with function body.
