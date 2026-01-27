extends ColorRect
func _ready():
	$Label.position = Vector2((size.x/2)-$Label.size.x/2, 250)
	$title.position = Vector2((size.x/2)-$title.size.x/2, 100)
	$Button.position = Vector2((size.x/2)-$Button.size.x/2, 500)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://battle_room.tscn")
