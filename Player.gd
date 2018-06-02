extends Spatial

var dir = {
	"N":[
		Vector3(0, 0, -1),
		Vector3(0, 0, 1),
		Vector3(-1, 0, 0),
		Vector3(1, 0, 0)
	],
	"S":[
		Vector3(0, 0, 1),
		Vector3(0, 0, -1),
		Vector3(1, 0, 0),
		Vector3(-1, 0, 0)
	],
	"W":[
		Vector3(-1, 0, 0),
		Vector3(1, 0, 0),
		Vector3(0, 0, 1),
		Vector3(0, 0, -1)
	],
	"O":[
		Vector3(1, 0, 0),
		Vector3(-1, 0, 0),
		Vector3(0, 0, -1),
		Vector3(0, 0, 1)
	]
}

var control   = false
var player_id = 0
var direct    = ["N", "W", "S", "O"]
var move      = "stop"
var step      = 0
var pos       = Vector3(1, 1, 1)
var rotL      = 0;
var rotR      = 0;
var id        = {16777232:0, 16777234:1, 16777231:2, 16777233:3}
var root      = false

func _ready():
	randomize()
	pos = Vector3(random_int(-30,30),1,random_int(-30,30))
	self.set_translation(pos)
	
	var colour = Color(random_float(0.0,1.0), random_float(0.0,1.0), random_float(0.0,1.0))
	
	var material = SpatialMaterial.new()
	material.albedo_color = colour
	$MeshInstance.set_surface_material(0, material)
	
	root    = get_parent()
	
	var ball_scene		= load("res://Ball.tscn")
	var ball			= ball_scene.instance()
	ball.set_colour(colour)
	get_parent().add_child(ball)
	
	set_process(true)
	
func step_mov(key):
	if (Input.is_key_pressed(key) and move == "stop") or move == direct[id[key]]:
		move  = direct[id[key]]
		step += 1
		pos  += 0.1 * dir[direct[0]][id[key]]
		
		if step == 50:
			move = "stop"
			step = 0
			pos  = Vector3(round(pos.x), 1, round(pos.z))
		
		var movement = Vector3(pos.x, 1, pos.z)
		
		set_translation(movement)
		rpc_unreliable("do_move", movement, player_id)
		
remote func do_move(position, pid):
	var root    = get_parent()
	var pnode   = root.get_node(str(pid))
	
	pnode.set_translation(position)
	
func rot():
	if (Input.is_key_pressed(16777235)) and step == 0 and rotR == 0 or rotL != 0:
		if rotL == 0:
			direct.push_back(direct[0])
			direct.pop_front()
		
		rotL += 1
		
		if rotL == 100:
			rotL = 0
			
		self.rotate(Vector3(0, 1, 0), -0.0157)
		
	if (Input.is_key_pressed(16777236)) and step == 0 and rotL == 0 or rotR != 0:
		if rotR == 0:
			direct.push_front(direct[3])
			direct.pop_back()
			
		rotR += 1
		
		if rotR == 100:
			rotR = 0
			
		self.rotate(Vector3(0, 1, 0), 0.0157)
		
func _process(delta):
	if control == true:
		step_mov(KEY_UP)
		step_mov(KEY_DOWN)
		step_mov(KEY_LEFT)
		step_mov(KEY_RIGHT)
		rot()

func random_int(low, high):
	randomize()
	var random_int = floor(rand_range(low, high))
	return random_int

func random_float(low, high):
	randomize()
	var random_float = rand_range(low, high)
	return random_float