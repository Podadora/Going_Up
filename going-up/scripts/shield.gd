extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _physics_process(delta: float) -> void:
	
	rotation = get_local_mouse_position().angle_to_point(position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
