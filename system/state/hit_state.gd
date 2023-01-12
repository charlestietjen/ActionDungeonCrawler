extends State

class_name HitState

onready var iframes_time = persistent_state.hit_iframes_time
onready var hit_anim_node = animation_tree.get_tree_root().get_node("hit_one_shot")

func _ready():
	animation_tree.set("parameters/hit_one_shot/active", true)
	persistent_state.hurtbox.set_deferred("monitoring", false)
#	change_state.call_func("idle")

func _process(_delta):
	if !animation_tree.get("parameters/hit_one_shot/active"):
		reset_animation_state()
		change_state.call_func("idle")

func _physics_process(delta):
	persistent_state.velocity = lerp(persistent_state.velocity, Vector3.ZERO, 3.0 * delta)

func move_entity(_target_vel):
	pass

func jump():
	pass

func attack_requested():
	pass

func evade():
	pass
