extends CanvasLayer

@onready var content_panel := $ContentPanel
var current_scene: Control

func _ready() -> void:
	switch_to_scene("res://scenes/core/TicketShop.tscn")

func switch_to_scene(scene_path: String) -> void:
	if current_scene:
		current_scene.queue_free()

	var new_scene: PackedScene = load(scene_path)
	assert(new_scene, "%s could not be loaded" % scene_path)

	current_scene = new_scene.instantiate()
	content_panel.add_child(current_scene)
