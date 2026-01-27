extends Area2D

signal triggered

var used := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if used:
		return
	if body.is_in_group("Player"):
		used = true
		emit_signal("triggered")
