extends Node


var multiplayer_peer = ENetMultiplayerPeer.new()

const PORT: int = 9999

var connected_peer_ids: Array[int]

var is_host: bool = false


func init_server() -> void:
	multiplayer_peer.create_server(PORT)
	multiplayer.multiplayer_peer = multiplayer_peer
	is_host = true


func init_client(ip: StringName) -> void:
	multiplayer_peer.create_client(ip, PORT)
	multiplayer.multiplayer_peer = multiplayer_peer


func is_master_peer(peer_id: int) -> bool:
	return peer_id == multiplayer.get_unique_id()
