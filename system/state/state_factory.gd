extends Node

class_name StateFactory

var states

func _init():
	states = {
		"idle": IdleState,
		"run": RunState,
		"jump": JumpState,
		"fall": FallState,
		"attack": AttackState,
		"hit": HitState,
		"evade": EvadeState,
	}

func get_state(state_name):
	if states.has(state_name):
		return states.get(state_name)
	else:
		printerr("No state '", state_name,"' in state factory.")
