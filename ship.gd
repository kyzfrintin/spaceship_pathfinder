extends Spatial

export(NodePath) var target_dir
export var speed := 0.4
var target_pos : = Vector3.ZERO
var movement : = Vector3.ZERO
var target

func _ready():
	target = get_node(target_dir)
	
func _physics_process(delta):
	if !target: return
	target_pos = target.global_transform.origin
	var dis = global_transform.origin.distance_to(target_pos)
	if dis > 5:
		var dir = $steering.calculate_path(target_pos)
		movement = lerp(movement, dir*speed,0.4)
		look_at(global_transform.origin+movement, global_transform.basis.y)
		global_translate(movement)
