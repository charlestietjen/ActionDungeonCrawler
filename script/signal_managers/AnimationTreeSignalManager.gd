extends AnimationTree

signal on_cancel_window_begin
signal on_attack_finished(string_ended)
signal on_attack_string_start
signal evade_begin
signal evade_end

func emit_cancel_window_signal():
	print("attack cancel signal emit")
	emit_signal("on_cancel_window_begin")

func emit_attack_finished_signal(string_ended):
	print("attack finish signal emit, last attack: ", string_ended)
	emit_signal("on_attack_finished", string_ended)

func emit_attack_string_start():
	print("attack string start")
	emit_signal("on_attack_string_start")

func emit_evade_signal(end = false):
	if !end:
		emit_signal("evade_begin")
	else:
		emit_signal("evade_end")
