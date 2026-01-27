extends CharacterBody2D


@export var max_speed := 100.0
@export var attack_speed := 1.0
@export var base_health := 10
@export var attack_damage := 2
@export var tier := 1
@export var damage_sound : AudioStream
@export var death_sound : AudioStream
var max_health = 0

var player : Node2D = null
var player_in_range := false
var health
var is_attacking = false
var lvl
func _ready():
	lvl = get_tree().current_scene.get_node("Player").lvl
	max_health  = (0.8*base_health) + base_health * (.2*lvl)
	health = max_health
	$Label.text = str(health)


func _physics_process(delta: float) -> void: 
	if player_in_range: 
		var dir = player.global_position - global_position
		update_direction(dir)
		velocity = (player.global_position - global_position).normalized() * max_speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		player_in_range = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null
		player_in_range = false

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Attack"):
		take_damage(area.get_damage())
		$AudioStreamPlayer2D.stream = damage_sound
		$AudioStreamPlayer2D.play()

func take_damage(damage):
	health -= damage
	$AudioStreamPlayer2D.play()
	if health <= 0:
		get_tree().current_scene.get_node("Player").xp += max_health * 1.5
		get_tree().current_scene.enemies_alive -= 1
		$AudioStreamPlayer2D.stream = death_sound
		$AudioStreamPlayer2D.play()
		queue_free()

func update_direction(dir):
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			$AnimatedSprite2D.play("right")
		else:
			$AnimatedSprite2D.play("left")
	else:
		if dir.y < 0:
			$AnimatedSprite2D.play("up")
		else:
			$AnimatedSprite2D.play("down")


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body == player:
		is_attacking = true
		attack_player()

func _on_hitbox_body_exited(body: Node2D) -> void:
	if body == player:
		is_attacking = false

func attack_player():
	while is_attacking and player:
		player.take_damage(attack_damage)
		await get_tree().create_timer(attack_speed).timeout
	is_attacking = false
