extends Node

var next_level = null

@onready var current_level = $Home
@onready var anim = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	current_level.level_changed.connect(handle_level_changed)
#	current_level.play_loaded_sound()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func handle_level_changed(current_level_name: String):
	next_level = load("res://" + current_level_name + ".tscn").instantiate()
#	next_level.layer = -1
	add_child(next_level)
#	anim.play("fade_in")	
	
	current_level.queue_free()
	current_level = next_level

	print(current_level)
	next_level.connect("level_changed", Callable(self, "handle_level_changed"))
	
#	transfer_data_between_scenes(current_level, next_level)


func transfer_data_between_scenes(old_scene, new_scene):
#	new_scene.load_level_parameters(old_scene.level_parameters)
	pass


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	match anim_name:
		"fade_in":
#			current_level.cleanup()
			current_level.queue_free()
			print(current_level)
			current_level = next_level
			current_level.layer = 1
			next_level = null
			anim.play("fade_out")
#		"fade_out":
#			current_level.play_loaded_sound()
