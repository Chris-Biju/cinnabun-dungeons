extends Node2D

var active := false
var enemies_alive := 0
@export var is_ambush := false
var doors = []
var enemy_spawners = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate():
	active = true
	$Camera.make_current()
	spawn_enemies()
	if is_ambush:
		lock_doors()

func spawn_enemies():
	for spawner in enemy_spawners:
		spawner.spawn()

func lock_doors():
	for door in doors:
		door.lock()

func unlock_doors():
	for door in doors:
		door.unlock()

func on_enemy_died():
	enemies_alive -= 1
	if enemies_alive <= 0:
		unlock_doors()
