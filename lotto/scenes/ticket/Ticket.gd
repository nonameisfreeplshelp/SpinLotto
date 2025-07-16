extends Panel

var numbers: Array[int]
var cfg: Dictionary
var cost: int

func init_from_cfg(c: Dictionary) -> void:
	cfg = c
	cost = cfg.price
	numbers = _unique_numbers(
		cfg.number_range[0],
		cfg.number_range[1],
		cfg.slots
	)
	_build_ui()

func _build_ui() -> void:
	var box := $SlotBox
	for n in numbers:
		var lbl := Label.new()
		lbl.text = str(n)
		lbl.add_theme_color_override("font_color", Color.WHITE)
		lbl.mouse_filter = Control.MOUSE_FILTER_PASS
		lbl.connect("gui_input", _on_label_input.bind(lbl))
		box.add_child(lbl)

func _on_label_input(event: InputEvent, lbl: Label) -> void:
	if event is InputEventMouseButton and event.pressed:
		lbl.add_theme_color_override("font_color", Color.YELLOW)
		if _all_scratched():
			var payout := _evaluate()
			GameManager.add_coins(payout)
			queue_free()

# Fixed function - now uses Array instead of PackedInt32Array
static func _unique_numbers(a: int, b: int, count: int) -> Array[int]:
	var pool: Array[int] = []
	for i in range(a, b + 1):
		pool.push_back(i)
	pool.shuffle()  # This now works!
	return pool.slice(0, count)

func _all_scratched() -> bool:
	for l in $SlotBox.get_children():
		if l.get_theme_color("font_color") == Color.WHITE:
			return false
	return true

func _evaluate() -> int:
	# Simple rule: all even → win 5× price
	for n in numbers:
		if n % 2 != 0:
			return 0
	return cost * 5
