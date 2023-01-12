extends State

class_name AttackState

var queue_attack := false
var string_over := false
var cancel_window := false
var string_count := 1
var physics_delta := 0.0

func _ready():
	animation_tree.set("parameters/attack_state/current", 1)
	
func _process(_delta):
	if !queue_attack && persistent_state.attack_string_over:
		print("first condition")
		animation_tree.set("parameters/attack_state/current", 0)
		persistent_state.attack_string_over = false
		change_state.call_func("idle")
	elif queue_attack && !persistent_state.attack_string_over:
		if string_count < animation_tree.get_tree_root().get_node("attack_state").input_count -1:
			string_count += 1
			animation_tree.set("parameters/attack_state/current", string_count)
			queue_attack = false
	elif persistent_state.attack_string_over:
		print("third condition")
		animation_tree.set("parameters/attack_state/current", 0)
		persistent_state.attack_string_over = false
		change_state.call_func("idle")
	else:
		pass
#		print("no conditions true")
		
func _physics_process(delta):
	physics_delta = delta
	
func attack_requested():
	queue_attack = true

func move_entity(_target_velocity):
	persistent_state.velocity = lerp(persistent_state.velocity, Vector3.ZERO, 2.0 * physics_delta)
	
func _on_cancel_window_opened():
	print("cancel window open")

func _on_attack_finished(string_end):
	print("attack finished signal, string end: ", string_end)
	string_over = string_end
