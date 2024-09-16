extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var ACTUAL_JUMPS = 0
const sprint_speed = normal_speed * 12
const normal_speed = 400.0
const JUMP_VELOCITY = -400.0
enum State {Idle, Run, Jump, Sprint}
var current_state

func _ready() -> void:
	current_state = State.Idle
	var mi_score = Global.score

func _physics_process(delta: float) -> void:
	_gravedad(delta)
	_idle(delta)
	_jumping(delta)
	_running(delta)
	_animations(delta)
	_sprint(delta)
	move_and_slide() ## sinceramente no se que hace eso, si alguno sabe me avisa
	
## Funcion para la gravedad
func _gravedad(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

## Funcion idle
func _idle(delta: float) -> void:
	if velocity.x == 0 and is_on_floor():
		current_state = State.Idle
		
## Funcion para moverse
func _running(delta:float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * normal_speed
	else:
		velocity.x = move_toward(velocity.x, 0, normal_speed)
	if direction != 0 :
		animated_sprite_2d.flip_h = false if direction > 0 else true
		if is_on_floor():
			current_state = State.Run
		else:
			current_state = State.Jump
			
## Funcion para sprintear
func _sprint(delta:float) -> void:

	if Input.is_action_just_pressed("sprint"):
		current_state = State.Sprint
		if animated_sprite_2d.flip_h :
			velocity.x = -sprint_speed
		else :
			velocity.x = sprint_speed


## Funcion para saltos
func _jumping(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		current_state = State.Jump
		ACTUAL_JUMPS = 1
	elif Input.is_action_just_pressed("ui_up") and ACTUAL_JUMPS == 1:
		velocity.y = JUMP_VELOCITY
		ACTUAL_JUMPS += 1 
		

## Funcion para animacions
func _animations(delta: float) -> void:
	if current_state == State.Run:
		animated_sprite_2d.play("run")
	elif current_state == State.Jump:
		animated_sprite_2d.play("jump")
	elif current_state == State.Sprint:
		animated_sprite_2d.play("sprint")
	elif current_state == State.Idle:
		animated_sprite_2d.play("idle")


## aca cree 3 funciones, para variar los mapas que tenemos y  que practiquemos lo que necesitamos hacer con
## los respectivos cambios que hagamos.
## lo que hice fue: meter una señal de "pressed" en la ventana "Nodos" arriba a la derecha
## esto envia una "señal" de que se presiono el boton a un script, en este caso, al player, podria ser el
## nodo padre, pero se me hizo mas facil asi para hacerlo rapido, si lo quieren modificar no hay problema
## seria agregarle un script al nodo padre y etc.

func _on_ami_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/ami.tscn")
	pass # Replace with function body.


func _on_mati_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/mati.tscn")
	pass # Replace with function body.



func _on_ema_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/level0.tscn")
	pass # Replace with function body.
