extends Node2D


var player: Player

const CHARACTER_PREFAB: PackedScene = preload("res://prefabs/Character.tscn")
const PLAYER_PREFAB: PackedScene = preload("res://prefabs/Player.tscn")


func _ready() -> void:
	add_prev_connected_characters(Net.connected_peer_ids)
	player.connect("changed_weapon", Gui.update_weapon)
	Gui.show_ammo()


func add_character(peer_id: int) -> void:
	var new_character := PLAYER_PREFAB.instantiate() if Net.is_master_peer(peer_id) else CHARACTER_PREFAB.instantiate()
	
	new_character.set_multiplayer_authority(peer_id)
	new_character.init_net(multiplayer.get_unique_id())
	%Characters.add_child(new_character)
	
	if new_character is Player:
		player = new_character


func add_prev_connected_characters(peer_ids: Array) -> void:
	for peer_id in peer_ids:
		add_character(peer_id)
