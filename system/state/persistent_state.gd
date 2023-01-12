extends KinematicBody

class_name PersistentState

signal state_changed(state)

onready var animation_tree :AnimationTree = find_node("AnimationTree")
onready var detect_floor :RayCast = get_node("./DetectFloor")
onready var armature :Spatial = find_node("Armature")
onready var viewport_camera :Spatial = find_node("ANCHOR")
onready var AV = find_node("ACTOR_VARS")
onready var hurtbox := $Hurtbox
onready var iframes_timer := $IframesTimer
export var drag := 0.8
export var jump_acceleration := 3.0

var state
var state_factory
var acceleration :float
var is_evading := false
var evade_speed := 4.0
var velocity = Vector3.ZERO
var attack_string_over := false

func _ready():
	state_factory = StateFactory.new()
	change_state("idle")
	animation_tree.active = true
	animation_tree.connect("on_attack_finished", self, "_on_attack_finished")
	animation_tree.connect("on_attack_string_start", self, "_on_attack_string_start")
	animation_tree.connect("evade_begin", self, "_on_evade_begin")
	animation_tree.connect("evade_end", self, "_on_evade_end")
	hurtbox.connect("body_entered", self, "_on_hurtbox_entered")
	iframes_timer.connect("timeout", self, "_iframes_timer_timeout")
	acceleration = AV.acceleration

func move_entity(move_direction: Vector3):
	state.move_entity(move_direction)
	
func jump():
	state.jump()

func evade():
	state.evade()

func attack_requested():
	print("attack requested")
	state.attack_requested()
	
func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(funcref(self, "change_state"), animation_tree, self)
	state.name = "current_state"
	add_child(state)
	emit_signal("state_changed", new_state_name)

func _on_attack_finished(string_end):
	attack_string_over = string_end

func _on_attack_string_start():
	attack_string_over = false

func _on_hurtbox_entered(body):
	print(body)
	if "knockback_damage" in body:
		iframes_timer.start(AV.hit_iframes_time)
		var direction_to_damage = body.global_translation.direction_to(global_translation)
		direction_to_damage.y += 1.0
		state.knockback(direction_to_damage * body.knockback_damage)
	else:
		printerr("unhandled hurtbox collision with '", body, "', confirm appropriate vars and layers")

func _iframes_timer_timeout():
	print("iframes_timer_expired")
	hurtbox.set_deferred("monitoring", true)

func _on_evade_begin():
#	print("evade begin")
	hurtbox.set_deferred("monitoring", false)

func _on_evade_end():
#	print("evade end")
	is_evading = false
#	print("is_evading: ", is_evading)
	hurtbox.set_deferred("monitoring", true)
