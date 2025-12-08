extends Node2D
@onready var text_edit: TextEdit = $TextEdit
@onready var send: Button = $Send


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_send_button_down() -> void:
	# 1. Grab the current text
	var current_text: String = text_edit.text
	
	# Optional: Clear the text field after sending
	text_edit.clear()
	
	# 2. Emit the custom signal, passing the text as an argument
	emit_signal("text_sent", current_text)

# You can remove the _process function as it's just printing every frame.
# func _process(delta: float) -> void:
# 	var current_text = text_edit.text
# 	print(current_text)
