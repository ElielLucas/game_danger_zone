extends Node2D

@export var mob_scene: PackedScene

func _ready():
	pass

func game_over():
	$MobTime.stop()
	$HUD_Inicial.update_score(Globals.inimigos_mortos)
	$HUD_Inicial.show_game_over()
	get_tree().reload_current_scene()
	
	
	


func new_game():
	$MobTime.stop()
	$HUD_Inicial.show_message("Get Ready")
	Globals.inimigos_mortos = 0
	$Jogador.start($StartPosition.position)
	$StartTime.start()


func _on_mob_time_timeout():
	var mob = mob_scene.instantiate()
	var player_position = $Jogador.position
	
	#chose a random location
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	var safe_distance = 300  # Distância mínima do jogador, ajuste conforme necessário
	
	mob_spawn_location.progress_ratio = randf()
	# Set the mob's position to a random location.
	#mob.position = mob_spawn_location.position
	
	var potential_position = mob_spawn_location.position
	var distance_to_player = potential_position.distance_to(player_position)
	
	while distance_to_player < safe_distance:
		mob_spawn_location.progress_ratio = randf()
		potential_position = mob_spawn_location.position
		distance_to_player = potential_position.distance_to(player_position)

	# Add some randomness to the direction.
	var direction = mob_spawn_location.rotation + PI / 2
	mob.position = potential_position
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
	mob.set_initial_direction(velocity.rotated(mob_spawn_location.rotation))
	
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)


func _on_start_time_timeout():
	$MobTime.start()



