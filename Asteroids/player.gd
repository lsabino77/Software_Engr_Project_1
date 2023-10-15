extends Area2D

@export var max_speed = 400;
@export var accel_coeff = 10;
@export var rotate_speed = 0.1; # How many radians the player will rotate per frame when turning
@export var velocity_damp = 0.25; # Velocity damping coefficient (between 0-1)
var heading = Vector2.UP;
var velocity = Vector2.ZERO;
var acceleration = Vector2.ZERO;
var screen_size;

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size;
	print(screen_size);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	acceleration = Vector2.ZERO;
	
	if Input.is_action_pressed("boost"):
		acceleration += heading;
	if Input.is_action_pressed("rotate_left"):
		heading.x = heading.x * cos(-rotate_speed) - heading.y * sin(-rotate_speed);
		heading.y = heading.x * sin(-rotate_speed) + heading.y * cos(-rotate_speed);
	if Input.is_action_pressed("rotate_right"):
		heading.x = (heading.x * cos(rotate_speed) - heading.y * sin(rotate_speed));
		heading.y = (heading.x * sin(rotate_speed) + heading.y * cos(rotate_speed));
		
	acceleration = acceleration.normalized() * accel_coeff;
	velocity += acceleration*delta;
	# velocity.clamp(Vector2.ZERO,Vector2(max_speed,max_speed));
	
	position += velocity * delta;
	velocity *= pow(velocity_damp, delta);
	rotation = heading.angle();
	
	if position.x > screen_size.x:
		position.x = 0;
	if position.y > screen_size.y:
		position.y = 0;
	if position.x < 0:
		position.x = screen_size.x;
	if position.y < 0:
		position.y = screen_size.y;
