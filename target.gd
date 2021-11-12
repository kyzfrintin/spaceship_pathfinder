extends Spatial


func _ready():
	_on_Timer_timeout()

func _on_Timer_timeout():
	global_transform.origin = Vector3(rand_range(-20,20),rand_range(-20,20),rand_range(-20,20))
	$Timer.start(3)
