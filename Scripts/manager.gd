extends Node2D

var scene = preload("res://Scenes/letter_generator.tscn") 
var LG_Romaji: String  
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = scene.instantiate()
	add_child(instance)
	LG_Romaji = instance.current_romaji


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_typing_manager_text_sent(message: String) -> void:
	if message == LG_Romaji:
		#make sure it loads a new character so look back to old scene
		print("horray")
