extends Node2D
@onready var text_edit: TextEdit = $TextEdit
@onready var send: Button = $Send

signal text_sent(message: String)
var message = "ghello"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_edit.grab_focus()
	var viewportx = get_viewport().size.x
	var viewporty = get_viewport().size.y
	position.x = viewportx*.536
	position.y = viewporty 
	var typing_sizex = text_edit.size.x
	text_edit.size.x = typing_sizex*0.92
	var typing_sizey = text_edit.size.y
	text_edit.size.y = typing_sizey*0.92
	print(position.x)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _input(event):
	if $TextEdit.has_focus():
		if event is InputEventKey and event.is_pressed():
			if event.key_label == KEY_ENTER:
				get_viewport().set_input_as_handled()
				_on_send_button_down()

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
