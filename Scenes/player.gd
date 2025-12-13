extends Node2D
@onready var lives: Label = $"../Lives"

var life:int = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lives.text = "LIVES: " + str(life)
	if life == 0:
		get_tree().change_scene_to_file("res://Scenes/lose.tscn")


func _on_area_2d_area_entered(area: Area2D) -> void:
	life -= 1
	print(lives)

	
