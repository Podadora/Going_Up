class_name Personaje
extends CharacterBody2D
@onready var dash = $Dash
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var ACTUAL_JUMPS = 0
const sprint_speed = normal_speed * 10
const sprint_dist = .1
const normal_speed = 200.0
const JUMP_VELOCITY = -400.0
enum State {Idle, Run, Jump, Sprint}
var current_state
var preShield = preload("res://escenas/shield.tscn")
var OrbeAbsorbido = false
var NumbersOfShields = 1
		

func _ready() -> void:
	current_state = State.Idle
	var mi_score = Global.score

func _physics_process(delta: float) -> void:
	_gravedad(delta)
	_idle(delta)
	_jumping(delta)
	_running(delta)
	_animations(delta)
	move_and_slide() ## sinceramente no se que hace eso, si alguno sabe me avisa
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and NumbersOfShields > 0:
		defense()
		
	
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
	if Input.is_action_just_pressed("sprint"):
		dash.start_dash(sprint_dist)
	var actual_speed = sprint_speed if dash.is_dashing() else normal_speed
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * actual_speed
	else:
		velocity.x = move_toward(velocity.x, 0, actual_speed)
	if direction != 0 :
		animated_sprite_2d.flip_h = false if direction > 0 else true
		if dash.is_dashing() :
			current_state = State.Sprint
		elif is_on_floor():
			current_state = State.Run
		elif !is_on_floor():
			current_state = State.Jump

## Funcion para saltos
func _jumping(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		current_state = State.Jump
		ACTUAL_JUMPS = 1
## Doble salto
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

func defense():
		var shield = preShield.instantiate()
		add_child(shield)
		NumbersOfShields -= 1
		
		
pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Personaje"):
		OrbeAbsorbido = false
		area.queue_free()
		print("orbe absorbido")
		
	
	pass # Replace with function body.
