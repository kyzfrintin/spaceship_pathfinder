extends Spatial

onready var target = get_node("../target")

var target_pos : = Vector3.ZERO
var movement : = Vector3.ZERO

func _physics_process(delta):
	target_pos = target.global_transform.origin
	var dis = global_transform.origin.distance_to(target_pos)
	if dis > 1:
		var dir = $steering.calculate_path(target_pos)
		movement = lerp(movement, dir*0.06,0.4)
		look_at(global_transform.origin+movement, global_transform.basis.y)
		global_translate(movement)
