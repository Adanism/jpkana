extends Node2D
@onready var score: Label = $"../Score"
var scene = preload("res://Scenes/letter_generator.tscn")
var letter_generator_instance = null
var LG_Romaji: String
var correct_counter:int = 0
var check_value:int = 5
var scoring = 0
@onready var typing_manager: Node2D = $"../Typing_Manager"
@onready var viewportx = get_viewport().size.x
@onready var viewport_middle_x = viewportx/2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	letter_generator_instance = scene.instantiate()
	letter_generator_instance.position.x = viewport_middle_x
	typing_manager.position.x = viewport_middle_x
	add_child(letter_generator_instance)
	_load_next_character()


func _load_next_character() -> void:
	if letter_generator_instance:
		letter_generator_instance.load_new_character()
		# Update the Romaji after the new character is loaded
		LG_Romaji = letter_generator_instance.current_romaji
		print("Expected Romaji: ", LG_Romaji)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var speed:int = 3
	#Code For Difficulty
	if correct_counter*5 == check_value:
		speed += 2
	letter_generator_instance.position.y += speed
	
	

# Called when the Typing Manager sends a message
func _on_typing_manager_text_sent(message: String) -> void:
	if message == LG_Romaji:
		print("horray - Correct!")
		scoring += 100
		score.text = "Score: " + str(scoring)
		correct_counter += 1
		if correct_counter == check_value:
			check_value += 5
		
		# Success: Load the next character
		letter_generator_instance.position.y = 0
		_load_next_character()
	else:
		print("Incorrect. Try again.")


func _on_area_2d_area_entered(area: Area2D) -> void:
	letter_generator_instance.global_position.y = 0
