extends CanvasLayer

@export var alive_players = 0
@export var killed_players = 0
var enemyPos 

func _ready():
	alive_players = get_node('Players')
	alive_players.text = "Players Alive : 10"
	killed_players = get_node('killed')
	killed_players.text = "Players Killed : 02"
	
	pass

func _process(_delta):
	
	
	pass
