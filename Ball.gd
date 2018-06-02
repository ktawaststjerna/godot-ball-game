extends RigidBody

var pos = Vector3(1,1,1)

func _ready():
	randomize()
	pos = Vector3(floor(rand_range(-30, 30)),1,floor(rand_range(-30, 30)))
	self.set_translation(pos)
	
func set_colour(colour):
	var material = SpatialMaterial.new()
	material.albedo_color = colour
	$MeshInstance.set_surface_material(0, material)