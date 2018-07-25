extends KinematicBody


signal eyes_enter(object)
signal eyes_leave(object)
signal eyes_action(object)


enum Mode { NORMAL = 0, FLIGTH = 1 }


# Player camera position
var _camera = Vector2()

var _camera_collider = null

var _velocity = Vector3()

export(Mode) var mode = NORMAL


func _ready():
	if mode == null:
		mode = NORMAL

	_camera.x = rad2deg(get_node("Head").get_rotation().y)
	_camera.y = rad2deg(get_node("Head/Eyes").get_rotation().x)


func _physics_process(delta):
	var aim = get_node("Head/Eyes").get_global_transform().basis

	var direction = Vector3()

	if Input.is_action_pressed("move_forward"):
		direction -= aim.z

	if Input.is_action_pressed("move_backward"):
		direction += aim.z

	if Input.is_action_pressed("move_left"):
		direction -= aim.x

	if Input.is_action_pressed("move_right"):
		direction += aim.x

	if mode == NORMAL:
		_process_normal_mode(direction, delta)
	elif mode == FLIGTH:
		_process_flight_mode(direction, delta)


func _process_normal_mode(direction, delta):
	direction.y = 0

	direction = direction.normalized()

	var speed = 3

	if Input.is_action_pressed("move_faster"):
		speed = 5

	var velocity_y = _velocity.y - delta * 9.8

	_velocity.y = 0

	var acceleration = 1

	if is_on_floor():
		acceleration = 5

		if direction.length() == 0 || direction.dot(_velocity) < 0:
			acceleration = 15

		if Input.is_action_just_pressed("jump"):
			velocity_y = 4

			get_node("Jump").play()

		if direction.length() > 0:
			_start_moving_sound(speed)
		else:
			_stop_moving_sound()
	else:
		_stop_moving_sound()

	if get_node("Head/Eyes/RayCast").is_colliding():
		var collider = get_node("Head/Eyes/RayCast").get_collider()

		if collider != _camera_collider:
			_camera_collider = collider

			emit_signal("eyes_enter", _camera_collider)
	else:
		if _camera_collider != null:
			emit_signal("eyes_leave", _camera_collider)

			_camera_collider = null

	if Input.is_action_just_pressed("action"):
		if _camera_collider != null:
			emit_signal("eyes_action", _camera_collider)

	_velocity = _velocity.linear_interpolate(direction * speed, delta * acceleration)

	_velocity.y = velocity_y

	_velocity = move_and_slide(_velocity, Vector3(0, 1, 0))


func _process_flight_mode(direction, delta):
	_stop_moving_sound()

	var speed = 4

	if Input.is_action_pressed("move_faster"):
		speed = 7

	_velocity = _velocity.linear_interpolate(direction * speed, delta * 15)

	_velocity = move_and_slide(_velocity, Vector3(0, 1, 0))


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


func _on_Timer_timeout():
	get_node("Move").play()


func _start_moving_sound(speed):
	var timer = get_node("Move/Timer")

	timer.wait_time = 1.5 / speed

	if timer.is_stopped():	
		timer.start()


func _stop_moving_sound():
	var timer = get_node("Move/Timer")

	if !timer.is_stopped():
		timer.stop()
