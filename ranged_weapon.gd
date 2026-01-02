extends Node2D

@export var damage = 5
@export var fire_rate = 1.0
@export var projectile_speed = 1000
@export var projectile_scene : PackedScene
var dir
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimatedSprite2D.play(get_dir())

#cooldown
func can_attack():
	return $AttackTimer.is_stopped()

#attack
func attack(direction):
	if can_attack():
		spawn_projectile((get_global_mouse_position() - global_position).normalized())
		$AttackTimer.start(fire_rate)

#projectile spawn
func spawn_projectile(dir):
	var projectile = projectile_scene.instantiate()
	projectile.global_position = $Muzzle.global_position
	projectile.setup(dir, projectile_speed, damage)
	get_tree().current_scene.add_child(projectile)

func get_dir():
	var pos = get_global_mouse_position()
	if abs(pos.x) > abs(pos.y):
		if pos.x > 0:
			return "right"
		else:
			return "left"
	else:
		if pos.y > 0:
			return "down"
		else:
			return "up"
