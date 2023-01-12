extends Node

onready var persistent_state : KinematicBody = get_parent()
onready var camera_anchor : Spatial = get_parent().find_node("CAMERA_ANCHOR")

func _process(_delta):
	var input_vec = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var move_direction = Vector3(input_vec.x, persistent_state.velocity.y, input_vec.y)
	move_direction = move_direction.rotated(Vector3.UP, camera_anchor.rotation.y).normalized()
	persistent_state.move_entity(move_direction)
	if Input.is_action_just_pressed("jump"):
		persistent_state.jump()
	if Input.is_action_just_pressed("attack"):
		persistent_state.attack_requested()
	if Input.is_action_just_pressed("evade"):
		persistent_state.evade()
