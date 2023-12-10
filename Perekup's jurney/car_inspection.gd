extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Yes.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	$Yes.visible = true
	pass # Replace with function body.


func _on_error_0_toggled(button_pressed):
	
	pass # Replace with function body.
