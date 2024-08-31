extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
enum State {Idle, Run, Jump, Stand}
var current_state

func _ready() -> void:
	current_state = State.Idle

func _physics_process(delta: float) -> void:
	_gravedad(delta)
	_idle(delta)
	_jumping(delta)
	_running(delta)
	_animations(delta)
	
	move_and_slide()

func _gravedad(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func _idle(delta: float) -> void:
	if is_on_floor():
		current_state = State.Idle

func _running(delta:float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction != 0 :
		animated_sprite_2d.flip_h = false if direction > 0 else true
		if is_on_floor():
			current_state = State.Run
		else:
			current_state = State.Jump



func _jumping(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		current_state = State.Jump


func _animations(delta: float) -> void:
	if current_state == State.Run:
		animated_sprite_2d.play("run")
	elif current_state == State.Jump:
		animated_sprite_2d.play("jump")
	elif current_state == State.Stand:
		animated_sprite_2d.play("stand")
	elif current_state == State.Idle:
		animated_sprite_2d.play("idle")
