extends ColorRect

func _ready() -> void:
	$Text.position = Vector2((size.x/2)-$Text.size.x/2, (size.y/2)-$Text.size.y/2)
