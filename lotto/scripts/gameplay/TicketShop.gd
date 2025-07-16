extends Panel

@onready var grid := $GridContainer  # This line was causing the error
var ticket_defs := []

func _ready():
	_load_defs()
	_spawn_buttons()

func _load_defs():
	var file_content = FileAccess.get_file_as_string("res://data/tickets.json")
	ticket_defs = JSON.parse_string(file_content)

func _spawn_buttons():
	for cfg in ticket_defs:
		var btn := Button.new()
		btn.text = "%s\n$%d" % [cfg.id.capitalize(), cfg.price]
		btn.connect("pressed", Callable(self, "_on_ticket_pressed").bind(cfg))
		grid.add_child(btn)

func _on_ticket_pressed(cfg):
	if GameManager.coins < cfg.price: 
		return
	GameManager.add_coins(-cfg.price)
	var ticket := TicketFactory.create_ticket(cfg)
	add_child(ticket)   # overlay ticket for scratching
