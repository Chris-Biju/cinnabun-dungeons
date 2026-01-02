extends Node2D

@export var damage = 5
@export var fire_rate = 1
@export var projectile_speed = 500
@export var projectile_scene : PackedScene
var dir
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#cooldown
func can_attack():
	return $AttackTimer.is_stopped()

#attack
func attack():
	if can_attack():
		spawn_projectile()
		$AttackTimer.start(fire_rate)

#projectile spawn
func spawn_projectile():
	var projectile = projectile_scene.instantiate()
	projectile.global_position = $Muzzle.global_position()
	projectile.setup(dir, damage, projectile_speed)
	get_tree().current_scene.add_child(projectile)
