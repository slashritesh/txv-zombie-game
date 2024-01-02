extends CharacterBody2D

const speed = 300



func _ready():
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())
	print("Player scene ready on instance with ID:", name)
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		$Camera2D.enabled = true
	else:
		$Camera2D.enabled = false
	pass

func _physics_process(_delta: float):
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		$Camera2D.make_current()
		var direction = Input.get_vector("left","right","up","down")
		velocity = direction * speed 
		move_and_slide()



