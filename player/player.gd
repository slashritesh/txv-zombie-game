extends CharacterBody2D

var speed = 500


func  _ready():
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())
	print("Player scene ready on instance with ID:", name)
	pass
	
func  _process(_delta):
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		var direction = Input.get_vector("left","right","up","down")
		velocity = direction * speed 
		move_and_slide()
		
		
	pass
