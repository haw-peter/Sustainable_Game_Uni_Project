extends Node

signal notification_parent_set

var notification_parent: Node = null

func set_notification_parent(parent_node: Node):
	notification_parent = parent_node
	emit_signal("notification_parent_set")
