extends CharacterBody2D

var speed = 500


func  _ready():
	pass
	
func  _process(_delta):
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed 
	move_and_slide()
	pass
