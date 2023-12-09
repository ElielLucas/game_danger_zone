extends CharacterBody2D
signal hit
signal jogo_terminado

@onready var ray_cast_2d = $RayCast2D
@export var move_speed = 200
@onready var _animated_sprite2 = $AnimatedPlayerSprite2D
@onready var contador_inimigos_label = $ContadorInimigosLabel

var morte = false


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		restart()
	if morte:
		return
	
	update_rotation()
	
	if Input.is_action_just_pressed("shoot"):
		tiro()


func _physics_process(delta):
	if morte:
		return
		
	var move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if Input.is_action_pressed("Correr"):
		velocity = move_dir * (move_speed + 150)
	else:
		velocity = move_dir * move_speed
	
	
	if(velocity):
		_animated_sprite2.play("move")
	else:
		_animated_sprite2.play("idle")
		
	move_and_slide()
	
	
func kill():
	if morte:
		return
		
	morte = true
	
	$SomMorte.play()
	$Graficos/Morto.show()
	$AnimatedPlayerSprite2D.hide()
	z_index = 555
	
	restart()
	
	
func restart():
	Globals.move_speed_monster = 50
	Globals.inimigos_mortos = 0
	get_tree().reload_current_scene()
	

func update_rotation():
	global_rotation = global_position.direction_to(get_global_mouse_position()).angle() + PI/2.0
	
func tiro():
	$ChamaDoCano.show()
	$ChamaDoCano/Timer.start()
	$SomTiro.play()
	
	if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider().has_method("kill"):
		Globals.inimigos_mortos += 1
		ray_cast_2d.get_collider().kill()
		
		adjust_monster_speed()

			
func adjust_monster_speed():
	if Globals.inimigos_mortos % 5 in [1, 2, 3]:
		Globals.move_speed_monster += 5
	elif Globals.inimigos_mortos % 5 in [4, 5, 6]:
		Globals.move_speed_monster += 10
	else:
		Globals.move_speed_monster += 20
	
			
