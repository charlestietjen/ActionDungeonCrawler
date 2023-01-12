extends Node

class_name State

var change_state
var animation_tree : AnimationTree
var persistent_state : KinematicBody
var velocity := Vector3.ZERO
var gravity_vector := Vector3.DOWN

func _process(delta):
	_sync_cameras()
	update(delta)

func _physics_process(delta):
	physics_update(delta)
	persistent_state.velocity += gravity_vector
	persistent_state.velocity = persistent_state.move_and_slide(persistent_state.velocity, Vector3.UP)

func setup(change_state, animation_tree, persistent_state):
	self.change_state = change_state
	self.animation_tree = animation_tree
	self.persistent_state = persistent_state

func move_entity(_target_velocity):
	if persistent_state.velocity == Vector3.ZERO:
		change_state.call_func("idle")

func attack_requested():
#	persistent_state.attack_string_over = false
	print("default state attack method")
	change_state.call_func("attack")

func knockback(knockback):
	persistent_state.velocity = knockback
	change_state.call_func("hit")

func jump():
	if persistent_state.detect_floor.is_colliding():
		change_state.call_func("jump")
		
func evade():
	persistent_state.is_evading = true
	print("is_evading: ", persistent_state.is_evading)
	change_state.call_func("evade")

func reset_animation_state():
	animation_tree.set("parameters/attack_state/current", 0)

func _sync_cameras():
	persistent_state.viewport_camera.rotation_degrees.x = Global.worldview_rotation_degrees.x
	persistent_state.viewport_camera.rotation_degrees.y = Global.worldview_rotation_degrees.y

func physics_update(_delta):
	pass

func update(_delta):
	pass
