extends Node2D

var active := false
var enemies_alive := 0
@export var is_ambush := false
@export var background_music : Array[AudioStream]
var doors = []
var enemy_spawners = []
var cinna : AudioStream = preload("res://cinna.wav")
var bun : AudioStream =  preload("res://bun.wav")
var song_counter = 0
var loop_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.stream = bun
	$AudioStreamPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate():
	active = true
	enemy_spawners = get_tree().get_nodes_in_group("Spawner")
	spawn_enemies()

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
