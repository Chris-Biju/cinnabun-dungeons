extends Marker2D

@export var enemy_list: Array[PackedScene]
@export var spawn_on_activate := true
var tier1 = []
var tier2 = []
var tier3 = []
var tier4 = []
var lvl
var in_range = false
var enemies_spawned = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lvl = get_tree().current_scene.get_node("Player").lvl
	tier1.append(enemy_list[0])
	tier1.append(enemy_list[1])
	tier1.append(enemy_list[2])
	tier2.append(enemy_list[3])
	tier2.append(enemy_list[4])
	tier2.append(enemy_list[5])
	tier3.append(enemy_list[6])
	tier3.append(enemy_list[7])
	tier4.append(enemy_list[8])
	tier4.append(enemy_list[7])
	tier4.append(enemy_list[6])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn()
	lvl = get_tree().current_scene.get_node("Player").lvl

func spawn():
	if in_range and enemies_spawned < 5:
		get_tree().create_timer(5)
		if(lvl >= 1 and lvl < 6):
			var enemy = tier1.pick_random().instantiate()
			enemy.global_position = global_position
			get_tree().current_scene.add_child(enemy)
			get_tree().current_scene.enemies_alive += 1
			enemies_spawned +=1
			return enemy
		elif(lvl >= 6 and lvl < 11):
			var enemy = tier2.pick_random().instantiate()
			enemy.global_position = global_position
			get_tree().current_scene.add_child(enemy)
			get_tree().current_scene.enemies_alive += 1
			enemies_spawned +=1
			return enemy
		elif(lvl >= 11 and lvl < 16):
			var enemy = tier3.pick_random().instantiate()
			enemy.global_position = global_position
			get_tree().current_scene.add_child(enemy)
			get_tree().current_scene.enemies_alive += 1
			enemies_spawned +=1
			return enemy
		elif(lvl >= 16):
			var enemy = tier4.pick_random().instantiate()
			enemy.global_position = global_position
			get_tree().current_scene.add_child(enemy)
			get_tree().current_scene.enemies_alive += 1
			enemies_spawned +=1
			return enemy
		

func _on_spawn_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):	
		in_range = true


func _on_spawn_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_range = false


func _on_player_level_up() -> void:
	lvl = get_tree().current_scene.get_node("Player").lvl
	print(lvl)


func _on_timer_timeout() -> void:
	if enemies_spawned > 0:
		enemies_spawned -= 1
