extends Node

signal coins_changed(new_total)

@export var coins: int = 0 :
	set(value):
		coins = value
		emit_signal("coins_changed", coins)

@export var prestige_points: int = 0

func add_coins(amount: int) -> void:
	coins += amount

# convenience for scene swapping later
func goto_scene(scene_path: String) -> void:
	call_deferred("_deferred_goto_scene", scene_path)

func _deferred_goto_scene(path):
	var root := get_tree().root
	var new_scene: PackedScene = load(path)
	root.get_child(-1).queue_free()
	root.add_child(new_scene.instantiate())
