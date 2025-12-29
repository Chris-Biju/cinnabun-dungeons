extends CharacterBody2D


@export var max_speed := 300.0
@export var attack_speed := 1
@export var health := 10
@export var damge := 2

var player : Node2D = null


func _physics_process(delta: float) -> void:
	if player:
		move_toward_player(player.global_position)
	move_and_slide()

#life/death
func die():
	queue_free()

#player detection
func _on_DetectionArea_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _on_DetectionArea_body_exited(body):
	if(body == player):
		body = null

#movement
func move_toward_player(target: Vector2):
	velocity = (target - global_position).normalized() * max_speed
	move_and_slide()
	
#direction
func update_direction():
	if(player.global_position.y < global_position.y):
		$AnimatedSprite2D.play("up")
	elif(player.global_position.y > global_position.y):
		$AnimatedSprite2D.play("down")
	elif(player.global_position.x < global_position.x):
		$AnimatedSprite2D.play("left")
	else:
		$AnimatedSprite2D.play("right")

#damage detection
func _on_Hurtbox_body_entered(area):
	if area.is_in_group("player_attack"):
		health -= area.damage
