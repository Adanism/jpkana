extends Node2D

# 1. Define instance variables outside of functions so they are accessible everywhere.
@onready var label: Label = $Label
var current_romaji: String = "" # Store the correct answer (romaji) here.
var game_data: Dictionary = {} # Store the parsed JSON data here.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Load the JSON content
	var file = FileAccess.open("res://Data/hiragana.json", FileAccess.READ)
	if file == null:
		print("ERROR: Could not open hiragana.json")
		return

	var content = file.get_as_text()
	file.close()

	# Parse the JSON
	var json = JSON.new()
	var error = json.parse(content)

	# 2. Store the parsed data in the instance variable
	if error == OK:
		game_data = json.data
		# 3. Call a function to load the first character
		load_new_character()
	else:
		print("JSON Parse Error:", json.get_error_message())


# Function to select and display a new character
func load_new_character() -> void:
	if not game_data.has("hiragana_chart"):
		print("Error: JSON is missing 'hiragana_chart' key.")
		return

	# Access the specific part of the dictionary
	var basic_gojuon = game_data["hiragana_chart"]["basic_gojuon"]
	
	# Select a random index (Ensure the range is correct based on the array size)
	var random_index = randi_range(0, basic_gojuon.size() - 1)
	
	# Get the dictionary for the random character
	var basic_index = basic_gojuon[random_index]
	
	var hiragana: String = basic_index["hiragana"]
	# 4. Store the correct romaji in the instance variable
	current_romaji = basic_index["romaji"]
	
	# Update the Label
	label.text = hiragana
	
	# Optional: Print for debugging
	print("New Character: ", hiragana)


# This function is connected to your Typing Manager's signal
func _on_typing_manager_text_sent(message: String) -> void:
	# 5. Check the received message against the instance variable
	if message.to_lower() == current_romaji: # Use .to_lower() for case-insensitive check
		print("🎉 HORRAY! Correct.")
		# Load the next character immediately after a correct answer
		load_new_character()
	else:
		print("❌ Incorrect. Try again.")
