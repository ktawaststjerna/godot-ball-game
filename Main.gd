extends Spatial

var players      = []
var console_show = false
var money        = 1000
var bandwidth    = 14.4
var timecop      = Timer.new()

func _ready():
	$Panel.hide()
	timecop.set_wait_time(60)
	timecop.connect("timeout", self, "_on_timecop_timeout")
	add_child(timecop)
	timecop.start()
	$Network.start_server()

func _on_Area_body_shape_entered(body_id, body, body_shape, area_shape):
	if body is RigidBody:
		print("win")
		$Panel.show()