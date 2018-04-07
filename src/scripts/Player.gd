extends RigidBody


# Player camera position
var _camera = Vector2()


func _ready():
	_camera.x = rad2deg(get_node("Head").get_rotation().y)
	_camera.y = rad2deg(get_node("Head/Eyes").get_rotation().x)


func _physics_process(delta):
	var aim = get_node("Head/Eyes").get_global_transform().basis

	var direction = Vector3()

	if Input.is_action_pressed("move_forward"):
		direction -= aim.x

	if Input.is_action_pressed("move_backward"):
		direction += aim.x

	if Input.is_action_pressed("move_left"):
		direction += aim.z

	if Input.is_action_pressed("move_right"):
		direction -= aim.z

	direction.y = 0
	direction = direction.normalized()

	var speed = 3

	if Input.is_action_pressed("move_faster"):
		speed = 5

	get_node("Feet").axis_lock_angular_x = direction.x == 0
	get_node("Feet").axis_lock_angular_z = direction.z == 0

	get_node("Feet").set_angular_velocity(direction * speed * 2)

	if get_node("RayCast").is_colliding():
		if Input.is_action_just_pressed("jump"):
			var feet = get_node("Feet")

			apply_impulse(translation, Vector3(0, 5, 0) * mass)
			feet.apply_impulse(feet.translation, Vector3(0, 5, 0) * feet.mass)

			get_node("Jump").play()

		if direction.length() > 0:
			if !get_node("Move").is_playing():
				get_node("Move").play()
		else:
			get_node("Move").stop()


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		_camera -= event.relative * 0.2
		_camera.x = fmod(_camera.x, 360)
		_camera.y = clamp(_camera.y, -85, 85)

		get_node("Head").set_rotation(Vector3(0, deg2rad(_camera.x), 0))
		get_node("Head/Eyes").set_rotation(Vector3(deg2rad(_camera.y), 0, 0))


func _enter_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _exit_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
