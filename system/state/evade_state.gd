extends State

class_name EvadeState

func _ready():
	animation_tree.set("parameters/evade_one_shot/active", 1)
	var global_direction = Vector3(0,0,1)
	var facing = global_direction.rotated(Vector3(0,1,0), persistent_state.rotation.y)
	gravity_vector = Vector3.ZERO
	persistent_state.velocity = velocity + facing * persistent_state.evade_speed

func move_entity(_target_vel):
	pass

func update(_delta):
	if !animation_tree.get("parameters/evade_one_shot/active"):
		change_state.call_func("idle")

func evade():
	pass

func jump():
	pass

func knockback(_knockback):
	pass

func attack_requested():
	pass
