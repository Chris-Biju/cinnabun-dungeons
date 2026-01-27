extends Area2D

var direction : Vector2
var speed : float
var damage : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setup(dir : Vector2, spd : float, dmg : int):
	direction = dir
	speed = spd
	damage = dmg

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_area_entered(area: Area2D) -> void:
	if (not area.is_in_group("Enemy")) and (not area.is_in_group("Player")) and not (area.get_parent().is_in_group("Spawner")) and not area.is_in_group("EnemyDetectionArea"):
		queue_free()
		
	if area.is_in_group("EnemyHurtbox"):
		queue_free()

func get_damage():
	return damage
