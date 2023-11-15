extends Node2D


var player: Player

const CHARACTER_PREFAB: PackedScene = preload("res://prefabs/Character.tscn")
const PLAYER_PREFAB: PackedScene = preload("res://prefabs/Player.tscn")


func _ready() -> void:
	Gui.show_gui()
	if Net.is_host:
		Net.multiplayer_peer.peer_connected.connect(
			func(new_peer_id):
				await get_tree().create_timer(1).timeout
				rpc("add_newly_connected_character", new_peer_id)
				rpc_id(new_peer_id, "add_prev_connected_characters", 
						Net.connected_peer_ids)
				add_character(new_peer_id)
		)
		add_character(Net.multiplayer.get_unique_id())


func add_character(peer_id: int) -> void:
	Net.connected_peer_ids.append(peer_id)
	var new_character := PLAYER_PREFAB.instantiate() if Net.is_master_peer(peer_id) else CHARACTER_PREFAB.instantiate()
	
	new_character.set_multiplayer_authority(peer_id)
	new_character.init_net(multiplayer.get_unique_id())
	%Characters.add_child(new_character)
	
	if new_character is Player:
		player = new_character


@rpc
func add_newly_connected_character(new_peer_id: int) -> void:
	add_character(new_peer_id)


@rpc
func add_prev_connected_characters(peer_ids: Array) -> void:
	for peer_id in peer_ids:
		add_character(peer_id)


@rpc("any_peer", "reliable")
func begin_game() -> void:
	Root.change_scene(GLOBAL.SCENES.GAME)


func _input(event: InputEvent) -> void:
	if event.is_action_released(GLOBAL.ACTIONS.INTERACT):
		rpc("begin_game")
		begin_game()
