extends State

class_name IdleState

func _ready():
	animation_tree.set("parameters/move_state/current", 0)
	animation_tree.set("parameters/in_air_state/current", 0)
	persistent_state.velocity = Vector3.ZERO

func move_entity(target_velocity):
	if target_velocity != Vector3.ZERO:
		change_state.call_func("run")

func _physics_process(_delta):
	if !persistent_state.detect_floor.is_colliding():
		change_state.call_func("fall")
