extends State

class_name FallState

onready var move_speed :float = persistent_state.AV.move_speed
onready var drag :float = persistent_state.drag

var physics_delta := 0.0

func _ready():
	animation_tree.set("parameters/in_air_state/current", 1)

func _physics_process(delta):
	physics_delta = delta
	if persistent_state.is_on_floor():
		animation_tree.set("parameters/in_air_state/current", 0)
		change_state.call_func("idle")

func move_entity(target_velocity: Vector3):
	persistent_state.velocity = lerp(persistent_state.velocity, target_velocity * move_speed, drag * physics_delta)
