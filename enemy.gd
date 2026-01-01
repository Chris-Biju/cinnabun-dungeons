extends CharacterBody2D


@export var max_speed := 100.0
@export var attack_speed := 1
@export var max_health := 10
@export var attack_damage := 2

var player : Node2D = null
var player_in_range := false
var health

func _ready():
	health = max_health

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

func take_damage(damage):
	health -= damage
	print(health)
	if health <= 0:
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
		print("HEYYYYYYY THERE, IMMA KILL YOU, SLAYYYYYYYYYYYYYYYYYY")
		player.take_damage(attack_damage)
