extends CharacterBody2D

#movement properties
@export_group("Movement")
@export var max_speed := 200
@export var acceleration := 800
@export var friction := 1800

@export_group("Misc")
@export var meele_list : Array[PackedScene]
@export var ranged_list : Array[PackedScene]
@export var walk_sound : AudioStream
@export var death_sound : AudioStream
@export var damage_sound : AudioStream
@export var level_up_sound : AudioStream

signal level_up
signal game_over
var lvl = 1
var xp = 0
var walk_sound_played = false
#health
@export_group("Health")
@export var max_health := 100
var current_weapon
var direction = "down"
var current_meele
var current_ranged
var health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_meele = meele_list[lvl-1].instantiate()
	current_weapon = current_meele
	$Marker2D.add_child(current_meele)
	current_ranged = ranged_list[0].instantiate()
	health = max_health

func switch_weapon():
	if Input.is_action_just_pressed("meele"):
		for child in $Marker2D.get_children():
			$Marker2D.remove_child(child)
		current_weapon = current_meele
		$Marker2D.add_child(current_meele)
	if Input.is_action_just_pressed("ranged"):
		for child in $Marker2D.get_children():
			$Marker2D.remove_child(child)
		current_weapon = current_ranged
		$Marker2D.add_child(current_ranged)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		current_weapon.attack(direction)
	if xp >= (100 * lvl):
		lvl += 1
		xp = 0
		$AudioStreamPlayer2D.stream = level_up_sound
		$AudioStreamPlayer2D.play()
		emit_signal("level_up")
		get_weapon()
		max_health = 80 + (100 * (float(lvl) * .2))
		print(float(lvl) * .2)
		print(50 * float(lvl) * .2)
		print(40 + (50 * float(lvl) * .2))
		health = max_health
	switch_weapon()
	$ProgressBar.value = (float(health)/float(max_health))*100
	$ProgressBar/Label.text = str(health) + " / " + str(max_health)
	$ProgressBar/Label.position = Vector2(($ProgressBar.size.x/2)-$ProgressBar/Label.size.x/2, $ProgressBar.size.y/2 - ($ProgressBar/Label.size.y/2))
	
	$XPBar.value = (float(xp)/float(100*lvl))*100
	$XPBar/Label.text = str(xp) + " / " + str(100*lvl) + " XP"
	$XPBar/Label.position = Vector2(($XPBar.size.x/2)-$XPBar/Label.size.x/2, $XPBar.size.y/2 - ($XPBar/Label.size.y/2))
func get_weapon():
	if(lvl < 5):
		current_meele = meele_list[0].instantiate()
	elif(lvl < 10):
		current_meele = meele_list[1].instantiate()
	elif(lvl < 15):
		current_meele = meele_list[2].instantiate()
	else:
		current_meele = meele_list[3].instantiate()
	if(lvl < 10):
		current_ranged = ranged_list[0].instantiate()
	else:
		current_ranged = ranged_list[1].instantiate()

func _physics_process(delta: float) -> void:
	#var direction = "down"
	var input_vector = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up"))
	if(input_vector.length() > 0):
		input_vector = input_vector.normalized()
		if(!walk_sound_played):
			walk_sound_played = true
			$AudioStreamPlayer2D.stream = walk_sound
			$AudioStreamPlayer2D.play()
	
	if (input_vector != Vector2.ZERO):
		if(!walk_sound_played):
			$AudioStreamPlayer2D.stream = walk_sound
			$AudioStreamPlayer2D.play()
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
		if $AudioStreamPlayer2D.has_stream_playback():
			$AudioStreamPlayer2D.stop()
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
	$AudioStreamPlayer2D.stream = damage_sound
	$AudioStreamPlayer2D.play()
	health = health - damage
	if (health <= 0):
		$AudioStreamPlayer2D.stream = death_sound
		$AudioStreamPlayer2D.play()
		emit_signal("game_over")
		$AudioStreamPlayer2D.stop()
		get_tree().change_scene_to_file("res://game_over_screen.tscn")
		

func _on_regen_timer_timeout() -> void:
	if health < 50 and current_weapon.get_node("AttackTimer").is_stopped:
		health += 1


func _on_heal_timer_timeout() -> void:
	if health < max_health:
		health += 1
		$HealTimer.start(1)
