class_name Weapon
extends Sprite2D


signal shot


const BASE_OFFSET_X = 84

var is_working: bool = true
var is_player: bool = false
var has_infinite_ammo: bool = false

var cooldown: float = 0.5
var reload_time: float = 1
var recoil: float = 0.4
var bullet_lifetime: float = 0.5
var bullet_acceleration: float = 1000

var ammo: int = 0
var ammo_in_magazine: int = 0
var max_ammo: int = 0

var tween: Tween

const BULLET: PackedScene = preload("res://prefabs/Weapons/Bullet.tscn")
const BULLET_ENEMY: PackedScene = preload("res://prefabs/Weapons/BulletEnemy.tscn")


func _enter_tree() -> void:
	is_player = true if get_parent().get_parent() is Player else false


func _ready() -> void:
	if has_infinite_ammo:
		max_ammo = GLOBAL.INFINITY
		ammo_in_magazine = GLOBAL.INFINITY
		ammo = ammo_in_magazine


func _on_cooldown_timeout() -> void:
	is_working = true


func shoot() -> void:
	if is_working and ammo == 0:
		reload()


func try_spend_ammo(count: int) -> bool:
	if count <= ammo:
		ammo -= count
		return true
	else:
		if max_ammo >= ammo_in_magazine:
			reload()
		return false


func wait_cooldown() -> void:
	is_working = false
	%Cooldown.start(cooldown)


func reload() -> void:
	is_working = false
	%Reload.start(reload_time)
	await %Reload.timeout
	
	ammo = ammo_in_magazine
	max_ammo -= ammo_in_magazine
	is_working = true


func rebound() -> void:
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "offset:x", BASE_OFFSET_X * recoil, cooldown / 2)
	tween.tween_property(self, "offset:x", BASE_OFFSET_X, cooldown / 2)
	tween.tween_callback(tween.kill)

