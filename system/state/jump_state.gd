extends State

class_name JumpState

onready var jump_strength :float = persistent_state.AV.jump_strength
onready var move_speed :float = persistent_state.AV.move_speed
onready var jump_acceleration :float = persistent_state.AV.jump_acceleration

var physics_delta := 0.0

func _ready():
	animation_tree.set("parameters/in_air_state/current", 1)
	animation_tree.set("parameters/jump_one_shot/active", true)
	persistent_state.velocity.y += jump_strength

func physics_update(delta):
	physics_delta = delta
#	print(persistent_state.velocity.y)
	if persistent_state.velocity.y < 0.0:
		change_state.call_func("fall")

func move_entity(target_velocity: Vector3):
	persistent_state.velocity = lerp(persistent_state.velocity, target_velocity * move_speed, jump_acceleration * physics_delta)
