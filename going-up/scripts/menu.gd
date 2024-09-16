extends Control

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
