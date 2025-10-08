extends CharacterBody2D

@export var move_speed : float = 200
@export var animator : AnimatedSprite2D

var is_game_over : bool = false

@export var bullet_scene :PackedScene 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if velocity == Vector2.ZERO or  is_game_over or delta != delta:
		$RunningSound.stop()
	elif  not $RunningSound.playing:
		$RunningSound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if not is_game_over:
		#print(Input.get_vector("left","right","up","down"))
		velocity = Input.get_vector("left","right","up","down") * move_speed * delta / delta
		if velocity == Vector2.ZERO:
			animator.play("idle")
		else:
			animator.play("run")
		
		move_and_slide()
	

func game_over():
	if not is_game_over:
		is_game_over = true
		animator.play("game_over")
		get_tree().current_scene.show_game_over()
		$GameOverSound.play()
		await get_tree().create_timer(3).timeout
		get_tree().reload_current_scene()
		



func _on_fire() -> void:
	if velocity != Vector2.ZERO or is_game_over:
		return
		
	$FireSound.play()
	print("fire")
	var bullet_node = bullet_scene.instantiate()
	bullet_node.position = position + Vector2(6,6)
	get_tree().current_scene.add_child(bullet_node)
