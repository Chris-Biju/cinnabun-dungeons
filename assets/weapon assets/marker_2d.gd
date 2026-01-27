extends Marker2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = get_parent().direction
	if dir == "up":
		position = Vector2(-50,-18)
	elif dir == "down":
		position = Vector2(-40,50)
	elif dir == "left":
		position = Vector2(-35, 22)
	else:
		position = Vector2(35, 22)
