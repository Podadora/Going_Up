class_name Orbe

extends Area2D
var i = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if i >= -20:
		i -= 1
		position.x += i * delta 
		position.y += i * delta 
		print(i)
		if i <= -20:
			i=21
		
		
	pass
