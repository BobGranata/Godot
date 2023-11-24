extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#var char_tex = load("C:/1.jpg") 
var char_tex = load("res://Sprites/1/1.jpg") 


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)
	$Sprite2D.texture = char_tex
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	$Sprite2D.texture = load("res://Sprites/1/2.jpg")


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_pressed() :
		$Sprite2D.texture = load("res://Sprites/1/6.jpg")
	pass # Replace with function body.
