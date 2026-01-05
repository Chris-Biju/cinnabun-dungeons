extends CharacterBody2D

#movement properties
@export_group("Movement")
@export var max_speed := 200
@export var acceleration := 800
@export var friction := 1800

#health
@export_group("Health")
@export var max_health := 100
var current_weapon
var direction = "down"

var health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_weapon = $Marker2D/Weapon
	health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		current_weapon.attack(direction)

func _physics_process(delta: float) -> void:
	#var direction = "down"
	var input_vector = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up"))
	if(input_vector.length() > 0):
		input_vector = input_vector.normalized()
	
	if (input_vector != Vector2.ZERO):
		direction = update_direction(input_vector)
		if(direction == "up"): #check up
			$AnimatedPlayer.play("up_walk")
		if(direction == "down"): # check down
			$AnimatedPlayer.play("down_walk") 
		if(direction == "right"): #check right
			$AnimatedPlayer.play("right_walk")
		if(direction == "left"): #check left
			$AnimatedPlayer.play("left_walk")
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	if(velocity == Vector2.ZERO):
		if (direction == "down"):
			$AnimatedPlayer.play("down_idle")
		elif(direction == "left"):
			$AnimatedPlayer.play("left_idle")
		elif(direction == "right"):
			$AnimatedPlayer.play("right_idle")
		else:
			$AnimatedPlayer.play("up_idle")
	move_and_slide()

func update_direction(dir):
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			return "right"
		else:
			return "left"
	else:
		if dir.y < 0:
			return "up"
		else:
			return "down"

func take_damage(damage):
	health = health - damage
	if (health <= 0):
		queue_free()


func _on_regen_timer_timeout() -> void:
	if health < 50 and current_weapon.get_node("AttackTimer").is_stopped:
		health += 1
