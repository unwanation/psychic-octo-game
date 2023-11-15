extends Node


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)


func get_current_scene() -> Node:
	return get_tree().get_current_scene()


func get_player() -> Player:
	return get_current_scene().player


func change_scene(scene: String) -> void:
	get_tree().change_scene_to_file(scene)


func quit() -> void:
	get_tree().quit()
