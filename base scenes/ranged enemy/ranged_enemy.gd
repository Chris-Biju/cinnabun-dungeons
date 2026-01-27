extends "res://base scenes/enemy/enemy.gd"
@export var projectile_scene : PackedScene
@export var fire_rate = 1.0
@export var projectile_speed = 1000

func _ready():
	health = max_health
	attack_speed = fire_rate

func _physics_process(delta: float) -> void: 
	if player_in_range: 
		if global_position.distance_to(player.global_position) > 100:
			var dir = player.global_position - global_position
			update_direction(dir)
			velocity = (player.global_position - global_position).normalized() * max_speed
			is_attacking = true
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func attack_player():
	while is_attacking and player:
		spawn_projectile(global_position - player.global_position)
		await get_tree().create_timer(attack_speed).timeout
	is_attacking = false

func spawn_projectile(dir):
	var projectile = projectile_scene.instantiate()
	projectile.global_position = global_position
	projectile.setup(dir, projectile_speed, attack_damage)
	get_tree().current_scene.add_child(projectile)
