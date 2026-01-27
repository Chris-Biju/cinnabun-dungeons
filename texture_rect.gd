extends TextureRect

func _ready() -> void:
	if $StartButton:
		$StartButton.position = Vector2((size.x/2)-$StartButton.size.x/2, 300)
		$Credits.position = Vector2((size.x/2)-$Credits.size.x/2, 350)
	else:
		$Text.position = Vector2((size.x/2)-$Text.size.x/2, 300)

func _on_start_button_pressed() -> void:
	$Credits/AudioStreamPlayer2D.play()
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://instructions.gd")


func _on_credits_pressed() -> void:
	$Credits/AudioStreamPlayer2D.play()
