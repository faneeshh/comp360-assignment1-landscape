extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	# Create FastNoiseLite instance
	var noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	noise.frequency = 0.02
	
	# Add multiple octaves (fractal noise)
	noise.fractal_octaves = 4
	noise.fractal_lacunarity = 2.0
	noise.fractal_gain = 0.5

	# Image dimensions
	var width = 256
	var height = 256
	var img = Image.create(width, height, false, Image.FORMAT_RGBA8)

	# Fill image with noise
	for y in range(height):
		for x in range(width):
			var n = noise.get_noise_2d(x, y)  # value in [-1, 1]
			n = (n + 1.0) * 0.5  # map to [0, 1]
			img.set_pixel(x, y, Color(n, n, n, 1))  # greyscale

	# Convert to texture
	var tex = ImageTexture.create_from_image(img)
	sprite.texture = tex
