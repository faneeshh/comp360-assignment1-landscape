extends Node3D

@export var rows: int = 4
@export var cols: int = 4
@export var quad_size: float = 1.0  # size of each quad

func _ready():
	build_grid()

func build_grid():
	for row in range(rows):
		for col in range(cols):
			var quad = MeshInstance3D.new()
			quad.mesh = build_quad()
			add_child(quad)
			
			# Position quads in XZ plane
			var x = (col - cols/2) * quad_size
			var z = (row - rows/2) * quad_size
			quad.position = Vector3(x, 0, z)

func build_quad() -> ArrayMesh:
	var arr_mesh = ArrayMesh.new()

	# vertices of a single quad
	var vertices = PackedVector3Array([
		Vector3(-quad_size/2, 0, -quad_size/2),
		Vector3( quad_size/2, 0, -quad_size/2),
		Vector3( quad_size/2, 0,  quad_size/2),
		Vector3(-quad_size/2, 0,  quad_size/2)
	])

	var uvs = PackedVector2Array([
		Vector2(0, 1),
		Vector2(1, 1),
		Vector2(1, 0),
		Vector2(0, 0)
	])

	var indices = PackedInt32Array([0,1,2, 0,2,3])

	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	arrays[Mesh.ARRAY_INDEX] = indices

	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	return arr_mesh
