extends Node
class_name TicketFactory

static func create_ticket(cfg: Dictionary) -> Control:
	var TicketScene := preload("res://scenes/ticket/Ticket.tscn")
	var ticket := TicketScene.instantiate()
	ticket.init_from_cfg(cfg)      # call custom initializer
	return ticket
