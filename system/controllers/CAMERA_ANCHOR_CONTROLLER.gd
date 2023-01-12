extends Spatial

onready var camera_target = get_parent()
onready var camera = get_node("Camera")
var camera_zoom := 2.5

func _ready():
	set_as_toplevel(true)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _process(delta):
	if Input.is_action_just_released("camera_zoom_out"):
		camera_zoom += 1
	elif Input.is_action_just_released("camera_zoom_in"):
		camera_zoom -= 1
	camera_zoom = clamp(camera_zoom, Global.min_camera_zoom, Global.max_camera_zoom)
	camera.translation.z = lerp(camera.translation.z, camera_zoom, 1.0 * delta)

func _physics_process(_delta):
	translation = camera_target.translation

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * Settings.control_settings.mouse_sensitivity.y
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 30.0)
		rotation_degrees.y -= event.relative.x * Settings.control_settings.mouse_sensitivity.x
		rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0)
		Global.worldview_rotation_degrees.x = stepify(rotation_degrees.x, 45.0)
		Global.worldview_rotation_degrees.y = stepify(rotation_degrees.y, 45.0)
