extends Area2D

@export var direction := "north"
var locked := false

signal entered(direction)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("HEY") # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func lock():
	locked = true

func unlock():
	locked = false

func _on_body_entered(body: Node2D) -> void:
	print("HIaSD")
	if body.is_in_group("Player") and not locked:
		print("HI")
		emit_signal("entered", direction)
