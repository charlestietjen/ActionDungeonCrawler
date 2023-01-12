extends State

class_name RunState

onready var move_speed : float = persistent_state.AV.move_speed
onready var acceleration : float = persistent_state.acceleration
var physics_delta := 0.0

func _ready():
	animation_tree.set("parameters/move_state/current", 1)
	animation_tree.set("parameters/in_air_state/current", 0)
	
func _physics_process(delta):
	if !persistent_state.detect_floor.is_colliding():
		change_state.call_func("fall")
	physics_delta = delta

func move_entity(target_velocity):
	persistent_state.velocity = lerp(persistent_state.velocity, target_velocity * move_speed, acceleration * physics_delta)
	if abs(persistent_state.velocity.x + persistent_state.velocity.z) > 0.5:
		var look_direction = Vector2(persistent_state.velocity.z, persistent_state.velocity.x)
		persistent_state.rotation.y = look_direction.angle()
		persistent_state.armature.rotation_degrees.y = stepify(rad2deg(look_direction.angle()), 45.0)
	if target_velocity == Vector3.ZERO:
		persistent_state.velocity = Vector3.ZERO
		change_state.call_func("idle")
