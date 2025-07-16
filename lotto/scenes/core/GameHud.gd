extends CanvasLayer

@onready var lbl := $CoinsLabel

func _ready() -> void:
	lbl.text = str(GameManager.coins)
	GameManager.coins_changed.connect(_on_coins_changed)

func _on_coins_changed(total: int) -> void:
	lbl.text = str(total)
