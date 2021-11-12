extends Spatial

var ray_num : int
var interest : Array = []
var danger : Array = []
var chosen_dir : = Vector3.ZERO

func _ready():
	ray_num = $casts.get_child_count()
	interest.resize(ray_num)
	danger.resize(ray_num)
	
func _get_dir(num):
	return global_transform.origin.direction_to($dirs.get_child(num).global_transform.origin)

func calculate_path(pos) -> Vector3:
	var dir = global_transform.origin.direction_to(pos)
	_set_interest(dir)
	_set_danger()
	var new_dir = _decide_path()
	return new_dir

func _set_interest(prefered_direction):
	for i in ray_num:
		var d = _get_dir(i).dot(prefered_direction)
		interest[i] = max(0, d)
	
func _set_danger():
	for i in ray_num:
		var cast : RayCast = $casts.get_child(i)
		var result = cast.is_colliding()
		danger[i] = 1.0 if result else 0.0

func _decide_path() -> Vector3:
	for i in ray_num:
		if danger[i] > 0.0:
			interest[i] = 0.0
	var dir = Vector3.ZERO
	for i in ray_num:
		dir += _get_dir(i) * interest[i]
	dir = dir.normalized()
	return dir
