extends Label
@onready var label: Label = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Opens the json then gets the conent and closes it
	var file = FileAccess.open("res://Data/hiragana.json", FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	#parses the json whatever that means
	var json = JSON.new()
	var error = json.parse(content)
	#Checks if the parsing went through
	if error == OK:
		#Gets the data from the json
		var data = json.data
		#[Main dictonary][array],then [Index]
		label.text = data["hiragana_chart"]["basic_gojuon"][randi_range(0,46)]["hiragana"]
	else:
		print("JSON Parse Error", json.get_error_message())
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
