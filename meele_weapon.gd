extends Node2D

@export var damage := 5
@export var attackSpeed := 0.4
@export var attackHitboxTime := 0.1

var already_hit := []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		attack()

func attack():
	if ($AttackTimer.is_stopped()):
		print("attacked")
		$Hitbox.monitoring = true
		$HitboxTimer.start(attackHitboxTime)
		$AttackTimer.start(attackSpeed)

func _on_hitbox_timer_timeout():
	$Hitbox.monitoring = false
	print($Hitbox.monitoring)
	

func _on_Hitbox_body_entered(body):
	if body in already_hit:
		return
	else:
		body.damage()
		already_hit.append(body)
		
