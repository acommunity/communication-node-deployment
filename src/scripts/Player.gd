extends KinematicBody


# Player camera position
var camera = Vector2()

# Player velocity
var velocity = Vector3()


func _ready():
	camera.x = rad2deg(get_node("Head").get_rotation().y)
	camera.y = rad2deg(get_node("Head/Eyes").get_rotation().x)


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

	direction.y = 0
	direction = direction.normalized()

	var speed = 3

	if Input.is_action_pressed("move_faster"):
		speed = 5

	var velocity_y = velocity.y - delta * 9.8

	velocity.y = 0

	var acceleration = 1

	if is_on_floor():
		acceleration = 5

		if direction.length() == 0 || direction.dot(velocity) < 0:
			acceleration = 10

		if Input.is_action_just_pressed("jump"):
			velocity_y = 4

			get_node("Jump").play()

		if direction.length() > 0:
			if !get_node("Footstep").is_playing():
				get_node("Footstep").play()
		else:
			get_node("Footstep").stop()

	velocity = velocity.linear_interpolate(direction * speed, delta * acceleration)

	velocity.y = velocity_y

	velocity = move_and_slide(velocity, Vector3(0, 1, 0))


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		camera -= event.relative * 0.2
		camera.x = fmod(camera.x, 360)
		camera.y = clamp(camera.y, -85, 85)

		get_node("Head").set_rotation(Vector3(0, deg2rad(camera.x), 0))
		get_node("Head/Eyes").set_rotation(Vector3(deg2rad(camera.y), 0, 0))


func _enter_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _exit_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
