extends Node2D
# https://www.youtube.com/watch?v=zkMSbQoUd9o

const LightTexture = preload("res://assets/sprites/kenney_particle-pack/PNG (Transparent)/circle_05.png")
const GRID_SIZE = 16
@export var LIGHT_SIZE = 100

@onready var fog = $Fog

var display_width = ProjectSettings.get("display/window/size/viewport_width")
var display_height = ProjectSettings.get("display/window/size/viewport_height")

var fogImage = Image.new()
var fogTexture = ImageTexture.new()
var lightImage = LightTexture.get_image()
var light_offset = Vector2(LIGHT_SIZE/2, LIGHT_SIZE/2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var fog_image_width = display_width/GRID_SIZE
	var fog_image_height = display_height/GRID_SIZE
	fogImage = Image.create_empty(fog_image_width, fog_image_height, false, Image.FORMAT_RGBAH)
	fogImage.fill(Color.BLACK)
	lightImage.resize(LIGHT_SIZE, LIGHT_SIZE)
	lightImage.convert(Image.FORMAT_RGBAH)
	fog.scale *= GRID_SIZE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_fog($"../Player".position/GRID_SIZE)

func update_fog(new_grid_position):
	var light_rect = Rect2(Vector2.ZERO, Vector2(LIGHT_SIZE, LIGHT_SIZE))
	fogImage.blend_rect(lightImage, light_rect, new_grid_position - light_offset)
	update_fog_image_texture()

func update_fog_image_texture():
	fogTexture = ImageTexture.create_from_image(fogImage)
	fog.texture = fogTexture
