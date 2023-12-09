extends AudioStreamPlayer


func _process(delta):
	if !$"/root/BackgroundMusic".playing:
		$"/root/BackgroundMusic".play()
