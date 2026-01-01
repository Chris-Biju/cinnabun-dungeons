extends Node2D

@export var damage := 5
@export var attackSpeed := 0.4
@export var attackHitboxTime := 0.1
@export var range := 1

var already_hit := []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position = Vector2(10,-30)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass #print($Hitbox.monitoring == true)


func attack(dir):
	if ($AttackTimer.is_stopped()):
		$Hitbox.monitoring = true
		$HitboxTimer.start(attackHitboxTime)
		$AttackTimer.start(attackSpeed)
		if(dir == "left"):
			$AnimationPlayer.play("attack_left")
		elif(dir == "right"):
			$AnimationPlayer.play("attack_right")
		else:
			$AnimationPlayer.play("attack_up")

func _on_hitbox_timer_timeout():
	$Hitbox.monitoring = false
	

func _on_Hitbox_body_entered(body):
	if body in already_hit:
		print("SLAYED")
	else:
		already_hit.append(body)
		
