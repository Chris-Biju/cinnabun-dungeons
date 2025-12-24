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

var current_health := max_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		print("hi")
		current_weapon.attack()

func _physics_process(delta: float) -> void:
	#var direction = "down"
	var input_vector = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up"))
	if(input_vector.length() > 0):
		input_vector = input_vector.normalized()
	if (input_vector != Vector2.ZERO):
		if(Input.get_action_strength("down") - Input.get_action_strength("up") < 0): #check up
			$AnimatedPlayer.play("up_walk")
			direction = "up"
		elif(Input.get_action_strength("down") - Input.get_action_strength("up") > 0): # check down
			$AnimatedPlayer.play("down_walk") 
			direction = "down"
		elif(Input.get_action_strength("right") - Input.get_action_strength("left") < 0): #check right
			$AnimatedPlayer.play("right_walk")
			direction = "right"
		elif(Input.get_action_strength("right") - Input.get_action_strength("left") > 0): #check left
			$AnimatedPlayer.play("left_walk")
			direction = "left"
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
