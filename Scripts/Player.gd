extends CharacterBody2D

@export var move_speed : float = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(Input.get_vector("left","right","up","down"))
	velocity = Input.get_vector("left","right","up","down") * move_speed
	move_and_slide()
