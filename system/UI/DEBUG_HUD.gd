extends Control

onready var player = get_parent().find_node("Player")
onready var state_label = $Panel/VBoxContainer/StateLabel

func _ready():
	player.connect("state_changed", self, "_on_state_changed")
	
func _on_state_changed(state):
	state_label.text = str("State: ", state)
