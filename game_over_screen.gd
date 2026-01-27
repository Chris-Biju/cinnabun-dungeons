extends ColorRect

func _ready() -> void:
	$Text.position = Vector2((size.x/2)-$Text.size.x/2, (size.y/2)-$Text.size.y/2)
	$Button.position = Vector2((size.x/2)-$Button.size.x/2, 500)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://start_screen.tscn")
