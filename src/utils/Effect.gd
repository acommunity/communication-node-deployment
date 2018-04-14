var mat;

func gen_new_material(color, amount):
	var at = SpatialMaterial.new()
	at.params_grow = true
	at.params_grow_amount = amount
	at.albedo_color = color
	at.flags_unshaded = true 
	at.params_cull_mode = 1
	return at

func visual_select_object(mesh_instance):
	var surf = mesh_instance.get_surface_material(0)
	surf.next_pass = mat

func visual_unselect_object(mesh_instance):
	var surf = mesh_instance.get_surface_material(0)
	surf.next_pass = null	

func _init(color = Color(1.0, 0.0, 0.0), amount = 0.05):
	mat = gen_new_material(color, amount)
