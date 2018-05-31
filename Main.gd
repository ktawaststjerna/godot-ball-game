extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$Panel.hide()

# func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area_body_shape_entered(body_id, body, body_shape, area_shape):
	if body is RigidBody:
		print("win")
		$Panel.show()