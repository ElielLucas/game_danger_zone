extends CharacterBody2D


@onready var ray_cast_2d = $RayCast2D
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("jogador")
@onready var _animated_sprite = $AnimatedSprite2D

var morto = false

func set_initial_direction(direction: Vector2):
	velocity = direction * Globals.move_speed_monster

func _physics_process(delta):
	if morto:
		return
		
	var dir_para_jogador = global_position.direction_to(player.global_position)
	velocity = dir_para_jogador * Globals.move_speed_monster
	
	if(velocity):
		_animated_sprite.play("mover")
	move_and_slide()
	
	global_rotation = dir_para_jogador.angle() + PI/2.0
	
	if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider() == player:
		player.kill()
	
	$CharacterBody2D/Sprite2D.global_position = player.global_position + (dir_para_jogador* - 200)
				
func kill():
	
	if morto:
		return
		
	morto = true
	
	$SomMorte.play()
	$Graficos/Morto.show()
	$CharacterBody2D/Sprite2D.hide()
	$Graficos/Morto.z_index=2
	$AnimatedSprite2D.hide()
	$Graficos/Vivo.hide()
	$CollisionShape2D.disabled = true
	z_index = -4

